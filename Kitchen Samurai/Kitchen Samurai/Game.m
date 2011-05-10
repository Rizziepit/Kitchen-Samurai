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
@synthesize ingredientsOnScreen;
@synthesize generator;
@synthesize pot;

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
    ingredientsOnScreen=[[NSMutableArray alloc] init];
    self.generator = [[IngredientGenerator alloc] initWithRecipe:[recipe valueForKey:@"Ingredients"]];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    // add the pot
    self.pot = [[PhysicalObject alloc] init:512 :64 :0 :0 :64];
    
    prevTime=0;
}

- (void)endGame
{
    [self.displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [ingredientsOnScreen dealloc];   //kill all ingredients and array
    [pot dealloc];
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
    //make sure no bugs in physics/generator on first loop cal when prevTime has not been set.
    
    //generate ingredient
    Ingredient*i=[generator giveIngredient];
    if(i!=nil){
        [ingredientsOnScreen addObject:i];
    }

    [self moveAndCatchIngredients: time];
    
    [viewController.view setNeedsDisplay];
}


-(void) moveAndCatchIngredients:(float) timepassed{
    // objects are added to this array when they need to be released (can't alter array when using a foreach-type loop)
    NSMutableArray* toBeRemoved = [[NSMutableArray alloc] init];
    
    for(Ingredient* ingredient in ingredientsOnScreen){
        //NSLog(@"%i",[ingredients count]);
        if ([ingredient isOffscreen])
            [toBeRemoved addObject:ingredient];
        else
            [ingredient updatePosition:timepassed]; //check that this is timesincelastframe
    }
    
    // remove objects that aren't visible
    for(Ingredient* offscreen in toBeRemoved)
    {
        [ingredientsOnScreen removeObject:offscreen];
    }
    [toBeRemoved release]; //this calls release on all objects in the array too
}

- (void)dealloc
{
    [self.displayLink release];
    [super dealloc];
}

@end
