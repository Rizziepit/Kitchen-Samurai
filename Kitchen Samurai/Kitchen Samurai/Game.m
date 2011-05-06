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

@synthesize gameScreen;
@synthesize isPaused;
@synthesize displayLink;
float prevTime;
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
    prevTime=0;
}

- (void)endGame
{
    [self.displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [ingredients dealloc];   //kill all ingredients and array
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
    float time = [sender timestamp]-prevTime;
    prevTime = [sender timestamp];
    [self moveAndCatchIngredients: time];
    //[gameScreen.view setNeedsDisplay];
    //NSLog(@"frame call");
}

- (void)runIngredientGenerator{
    //Simple unbalanced one for now, just generates with 1%chance each frame
    if (rand()%100<1){
        NSString* type;
        //to do: decide on type, starting position, 
        
        int x=550;
        int y=0;
        int vx=5;
        int vy=150;
        if(rand()%100<50){
            type =[[NSBundle mainBundle] pathForResource:@"test" ofType:@"jpg"];
            x=150;
        }
        else
        {
            type =[[NSBundle mainBundle] pathForResource:@"recipe_button_locked" ofType:@"png"];
            
        }
 
        UIImageView *ingredientView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:type]]; //this disables userinteractions, may want to reenable.
        ingredientView.frame=CGRectMake(x, y, ingredientView.image.size.width, ingredientView.image.size.height); 
        [gameScreen.view addSubview:ingredientView];

        Ingredient* i = [[Ingredient alloc] init:x :y :vx :vy :ingredientView];
        i.type=type;
       [ingredients addObject:i];
        [ingredientView release];
        [i release];
    }    
}

-(void) moveAndCatchIngredients:(float) timepassed{
    for(Ingredient* ingredient in ingredients){
        NSLog(@"%f",timepassed);
        [ingredient updatePosition:timepassed]; //check that this is timesincelastframe
    }
}

- (void)dealloc
{
    [self.gameScreen release];
    [self.displayLink release];
    [super dealloc];
}

@end
