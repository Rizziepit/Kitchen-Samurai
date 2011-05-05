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

@interface Game : NSObject {
    NSMutableArray* ingredients;
}

- (void) startGame; // initialise game with saved data
- (void) endGame;
- (void) pauseGame;
- (void) continueGame;
- (void) gameLoop:(CADisplayLink *)sender;
- (void) generateIngredientIfNecessary;
- (void) moveAndCatchIngredients:(float) timepassed;

@property (nonatomic, retain) GameScreen *gameScreen;
@property (nonatomic) BOOL isPaused;
@property (nonatomic, retain) CADisplayLink *displayLink;

@end

