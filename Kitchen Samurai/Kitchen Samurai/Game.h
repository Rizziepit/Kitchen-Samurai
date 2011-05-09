//
//  Game.h
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/05/05.
//  Copyright 2011 University of Cape Town. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@class GameScreen;
@class IngredientGenerator;

@interface Game : NSObject {
}

- (void) startGame: (NSDictionary*) recipe; // initialise game with saved data
- (void) endGame;
- (void) pauseGame;
- (void) continueGame;
- (void) gameLoop:(CADisplayLink *)sender;
- (void) moveAndCatchIngredients:(float) timepassed;

@property (nonatomic) BOOL isPaused;
@property (nonatomic, retain) GameScreen* viewController;
@property (nonatomic, retain) CADisplayLink *displayLink;
@property (nonatomic, retain) NSMutableArray* ingredientsOnScreen;
@property (nonatomic, retain) IngredientGenerator* generator;
@end

