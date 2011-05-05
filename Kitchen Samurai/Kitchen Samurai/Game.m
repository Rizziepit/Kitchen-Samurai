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

    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    //Riz, caddisplaylink wasnt working coz u put gameLoop as the selector instead of gameLoop: haha - and touch still works while this is running but its not actually a seperate thread theres just tons of time to detect touches between gameLoop: method calls...may be necessary to thread it if gameLoop takes longer/if control of the pot is imprecise, but not gonna bother now unless we have issues like that.
}

- (void)endGame
{
    [self.displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
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
    [self generateIngredientIfNecessary];
    [self moveAndCatchIngredients: [sender timestamp]];
    //[gameScreen.view setNeedsDisplay];
    //NSLog(@"frame call");
}

- (void)generateIngredientIfNecessary{
    //Simple unbalanced one for now, just generates with 0.1%chance
    if (rand()%100<1){
        
        //to do: decide on type, starting position, 
        NSString* type = @"test";
        int x=0;
        int y=0;
        
        NSLog(@"Creating Ingredient...");
        Ingredient* i = [[Ingredient alloc] init];
        [i setX:x andY:y andType:type];
        [ingredients addObject:i];
        [i release];
    }    
}

-(void) moveAndCatchIngredients:(float) timepassed{
    NSLog(@"%f",timepassed);
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
