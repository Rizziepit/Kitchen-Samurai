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
#import "IngredientGenerator.h"

@implementation Game

float lastTimeStamp = -1;
float prevTime;

@synthesize isPaused;
@synthesize viewController;
@synthesize displayLink;
@synthesize ingredients;
@synthesize generator;

- (id)init
{
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(gameLoop:)];
    [self.displayLink setFrameInterval:1];
    return self;
}

// initialise game with saved datas
- (void)startGame: (NSDictionary*) recipe
{
    NSLog(@"Starting game...");
    ingredients=[[NSMutableArray alloc] init];
    self.generator = [[IngredientGenerator alloc] initWithRecipe:[recipe valueForKey:@"Ingredients"]];
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
    // calculate time step
    float time = [sender timestamp]-prevTime;
    prevTime = [sender timestamp];
    
    [self runIngredientGenerator];
    [self moveAndCatchIngredients: time];
    
    [viewController.view setNeedsDisplay];
}

- (void)runIngredientGenerator{
    Ingredient*i=[generator giveIngredient];
    if(i!=nil){
       [ingredients addObject:i];
    }
    
}

-(void) moveAndCatchIngredients:(float) timepassed{
    // objects are added to this array when they need to be released (can't alter array when using a foreach-type loop)
    NSMutableArray* toBeRemoved = [[NSMutableArray alloc] init];
    
    for(Ingredient* ingredient in ingredients){
        //NSLog(@"%i",[ingredients count]);
        if ([ingredient isOffscreen])
            [toBeRemoved addObject:ingredient];
        else
            [ingredient updatePosition:timepassed]; //check that this is timesincelastframe
    }
    
    // remove objects that aren't visible
    for(Ingredient* offscreen in toBeRemoved)
    {
        [ingredients removeObject:offscreen];
    }
    [toBeRemoved release]; //this calls release on all objects in the array too
}

- (void)dealloc
{
    [self.displayLink release];
    [super dealloc];
}

@end
