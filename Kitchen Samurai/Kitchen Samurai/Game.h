//
//  Game.h
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/05/05.
//  Copyright 2011 University of Cape Town. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@class GameScreen;
@class IngredientGenerator;
@class PhysicalObject;
@class Ingredient;

@interface Game : NSObject {
    AVAudioPlayer* soundEffect;
    int number;
    int timeleft;
    NSTimer* timer;
    int mistakes;
}

- (void) startGame: (NSDictionary*) recipe; // initialise game with saved data
- (void) endGame;
- (void) pauseGame;
- (void) updateTimer;
- (void) resumeGame;
- (void) gameLoop:(CADisplayLink *)sender;
- (void) moveAndCatchIngredients:(float) timepassed;
- (void)catchIngredient:(Ingredient*)i;

@property (nonatomic) BOOL isPaused;
@property (nonatomic, retain) GameScreen* viewController;
@property (nonatomic, retain) CADisplayLink *displayLink;
@property (nonatomic, retain) NSMutableArray* ingredientsOnScreen;
@property (nonatomic, retain) NSMutableDictionary* ingredientsLeft;
@property (nonatomic, retain) IngredientGenerator* generator;
@property (nonatomic, retain) PhysicalObject* pot;
@property (nonatomic, retain) NSNumber* difficulty;
@property (nonatomic, retain) NSNumber* rating;
@end

