//
//  Game.m
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/05/05.
//  Copyright 2011 University of Cape Town. All rights reserved.
//

#import "Game.h"
#import "GameScreen.h"
#import "Ingredient.h"

@implementation Game
float lastTimeStamp = -1;

@synthesize gameScreen;
@synthesize isPaused;
@synthesize displayLink;

- (id)init
{
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(gameLoop:)];
    [self.displayLink setFrameInterval:1];
    return self;
}

// initialise game with saved datas
- (void)startGame
{
    NSLog(@"Starting game...");
    ingredients=[[NSMutableArray alloc] init];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    //Riz, caddisplaylink wasnt working coz u put gameLoop as the selector instead of gameLoop: haha - and touch still works while this is running but its not actually a seperate thread theres just tons of time to detect touches between gameLoop: method calls...may be necessary to thread it if gameLoop takes longer/if control of the pot is imprecise, but not gonna bother now unless we have issues like that.
}

- (void)endGame
{
    [self.displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [ingredients dealloc];
    //to do: kill all ingredients and array
}

- (void)pauseGame
{
    self.isPaused = YES;
}

- (void)continueGame
{
    self.isPaused = NO;
}

- (void)gameLoop:(CADisplayLink *)sender
{
    [self runIngredientGenerator];
    [self moveAndCatchIngredients: [sender timestamp]];
    //[gameScreen.view setNeedsDisplay];
    //NSLog(@"frame call");
}

- (void)runIngredientGenerator{
    //Simple unbalanced one for now, just generates with 1%chance each frame
    if (rand()%100<1){
        NSString* type;
        //to do: decide on type, starting position, 
        
        int x=550;
        int y=150;
        if(rand()%100<50){
            type =[[NSBundle mainBundle] pathForResource:@"test" ofType:@"jpg"];
            x=150;
        }
        else
        {
            type =[[NSBundle mainBundle] pathForResource:@"recipe_button_locked" ofType:@"png"];
            
        }
        NSLog(@"Creating Ingredient...%@",type);
        Ingredient* i = [[Ingredient alloc] init];
        [i setX:x andY:y andType:type];

        [ingredients addObject:i];

        UIImageView *ingredientView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:type]]; //this disables userinteractions, may want to reenable.
        ingredientView.frame=CGRectMake(x, y, ingredientView.image.size.width, ingredientView.image.size.height); 
        [gameScreen.view addSubview:ingredientView];
        i.view = ingredientView;
        NSUInteger test = [i hash];
        NSLog(@"%i",test);
        [ingredientView release];
        [i release];
    }    
}

-(void) moveAndCatchIngredients:(float) timepassed{
    for(Ingredient* ingredient in ingredients){
        [ingredient moveByTime:timepassed];
    }
}

- (void)dealloc
{
    [self.gameScreen release];
    [self.displayLink release];
    [super dealloc];
}

@end
