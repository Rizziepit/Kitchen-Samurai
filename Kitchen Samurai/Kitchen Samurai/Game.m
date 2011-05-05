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
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(gameLoop)];
    [self.displayLink setFrameInterval:1];
    return self;
}

// initialise game with saved data
- (void)startGame
{
    //[self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)endGame
{
    //[self.displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
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
    NSLog(@"frame call");
}

- (void)dealloc
{
    [self.gameScreen release];
    [self.displayLink release];
    [super dealloc];
}

@end
