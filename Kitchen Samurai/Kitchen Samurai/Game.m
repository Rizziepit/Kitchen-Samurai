//
//  Game.m
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/05/05.
//  Copyright 2011 University of Cape Town. All rights reserved.
//

#import "Game.h"
#import "GameScreen.h"

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
    //Riz, caddisplaylink wasnt working coz u put gameLoop as the selector instead of gameLoop: haha
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
    [self moveAndCatchIngredients];
   // [gameScreen.view setNeedsDisplay];
    //NSLog(@"frame call");
}

- (void)generateIngredientIfNecessary{
    //Simple unbalanced one for now, just generates with 0.1%chance
    if (rand()%100<1){
        NSLog(@"Starting game...");

    }
    
}

-(void) moveAndCatchIngredients{
    
}

- (void)dealloc
{
    [self.gameScreen release];
    [self.displayLink release];
    [super dealloc];
}

@end
