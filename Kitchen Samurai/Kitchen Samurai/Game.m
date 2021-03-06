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
@synthesize ingredientsLeft;
@synthesize generator;
@synthesize pot;
@synthesize difficulty;
@synthesize rating;
@synthesize levelNumber;

- (id)init
{
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(gameLoop:)];
    [self.displayLink setFrameInterval:1];
    return self;
}

- (void) updateTimer{
    timeleft--;
    int minutes = timeleft/60;
    int seconds = timeleft%60;
    [viewController updateTimerMinutes:minutes andSeconds:seconds];
    if(timeleft==0){
        [timer invalidate];
        [self endGame:NO];
    }
}

-(void)catchIngredient:(Ingredient*)i{
    NSString* keyString = [NSString stringWithFormat:@"%i",i.ingredientType];
    int currentAmount = [[ingredientsLeft valueForKey:keyString] intValue];
    if(currentAmount==0){
        mistakes++;
        [viewController mistake];
    }
    else{
        //[soundEffect play];
        
        currentAmount--;
        NSNumber* newAmount=[NSNumber numberWithInt:currentAmount];
        [ingredientsLeft setValue:newAmount forKey:keyString];
        [viewController updateProgressFrame:i.ingredientType];
        
        number--;
    }
    if (currentAmount==0){
        [ingredientsLeft removeObjectForKey:keyString];
    }

}

// initialise game with saved datas
- (void)startGame: (NSDictionary*) recipe:(int)level
{
    mistakes = 0;
    number = 0;
    [viewController setMistakes:0];
    prevTime = -1;
    difficulty = [recipe valueForKey:@"Difficulty"];
    timeleft = [difficulty intValue] * 60;
    totaltime = timeleft;
    
    NSLog(@"Starting game...");
    number = [[recipe valueForKey:@"NumberIngredients"] intValue];
    ingredientsOnScreen=[[NSMutableArray alloc] init];
    ingredientsLeft = [recipe valueForKey:@"Ingredients"];
    levelNumber = level;
    self.generator = [[IngredientGenerator alloc] initForGame:self];
    [viewController.pauseButton setEnabled:YES];
    [viewController.quitButton setEnabled:YES];
    [viewController.EndGameView setHidden:YES];
    [viewController updateTimerMinutes:timeleft/60 andSeconds:timeleft%60];
    [viewController addProgressFrame];
    // add the pot
    self.pot = [[PhysicalObject alloc] init:512 :64 :0 :0 :64];
    pot.imageView = [viewController addPotToView:pot];
    
    //soundEffect = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"swoosh" ofType:@"caf"]] error:nil]; 
    
    isPaused = NO;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [self.displayLink setPaused:NO];
    [viewController enableGestureRecognizers:YES];
}

- (void)endGame:(BOOL)win
{
    if (!isPaused)
        [self pauseGame];
    [viewController enableGestureRecognizers:NO];
    [self.displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [ingredientsOnScreen release];   //kill all ingredients and array
    [pot release];
    
    if (win)
    {
        //Work out rating
        float timerate = timeleft/((float)totaltime);
        int score;
        if (timerate < 0.2f)
            score = 1;
        else if (timerate < 0.4f)
            score = 2;
        else
            score = 3;
        if (mistakes == 0)
            score += 2;
        else if (mistakes == 1)
            score += 1;
        else if (mistakes == 2)
            score -= 1;
        else
            score -= 2;
        if(score<=0)
        {
            score=1;
        }
        NSLog(@"%d",score);
        [viewController endGame:YES :score :levelNumber]; // add correct level number
    }
    else
        [viewController endGame:NO :0 :0];
}

- (void)pauseGame
{
    self.isPaused = YES;
    [self.displayLink setPaused:YES];
    [timer invalidate];
}

- (void)resumeGame
{
    //if(self.isPaused == YES){
        NSLog(@"Resume");
        self.isPaused = NO;
        prevTime = -1;
        [self.displayLink setPaused:NO];
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    //}
}


- (void)gameLoop:(CADisplayLink *)sender
{
    // calculate time step
    float time;
    if (prevTime < 0)
        time = 0;
    else
        time = [sender timestamp]-prevTime;
    prevTime = [sender timestamp];
    
    //update Timer
    //[self updateTimer];
    //generate ingredient
    Ingredient*i=[generator giveIngredient];
    if(i!=nil){
        [ingredientsOnScreen addObject:i];
        i.imageView = [viewController addIngredientToView:i];
    }

    [self moveAndCatchIngredients: time];
}

-(void) moveAndCatchIngredients:(float) timepassed{
    // objects are added to this array when they need to be released (can't alter array when using a foreach-type loop)
    NSMutableArray* toBeRemoved = [[NSMutableArray alloc] init];
    
    for(Ingredient* ingredient in ingredientsOnScreen){
        //NSLog(@"%i",[ingredients count]);
        if ([ingredient isOffscreen])
            [toBeRemoved addObject:ingredient];
        else
        {
            [ingredient updatePosition:(timepassed +timepassed*([difficulty floatValue])/5)]; //check that this is timesincelastframe
            
            // check for collision with pot
            if (ingredient.isCut && ingredient.yVel < 0 && ingredient.yPos < 144 && ingredient.yPos > 128)
            {
                if (ingredient.xPos > pot.xPos-64 && ingredient.xPos < pot.xPos+64)
                {
                    [toBeRemoved addObject:ingredient];
                    [self catchIngredient:ingredient];
                }
            }
        }
    }
    
    // remove objects that aren't visible
    for(Ingredient* offscreen in toBeRemoved)
    {
        [ingredientsOnScreen removeObject:offscreen];
    }
    [toBeRemoved release]; //this calls release on all objects in the array too
    if (mistakes > 3)
        [self endGame:NO];
    else if (number <= 0)
        [self endGame:YES];
}

- (void)dealloc
{
    [self.displayLink release];
    [super dealloc];
}

@end
