//
//  GameScreen.h
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/04/28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSwipeGestureRecognizer.h"

@class Kitchen_SamuraiAppDelegate;
@class Game;
@class Ingredient;
@class CATransition;

@interface GameScreen : UIViewController <UIGestureRecognizerDelegate> {
    UILongPressGestureRecognizer *drag;
    UISwipeGestureRecognizer *swipe1;
    UILongPressGestureRecognizer *tempSwipe;
    NSArray *timerpics;
    UIButton *quitButton;
    UIView *ingredientCountersView;
    UIView *EndGameView;
    int mistakes;
    CGFloat* fingerVelocities;
    CGPoint lastFingerPosition;
    CFTimeInterval lastFingerTime;
    UIImage *dot;
    int dotCounter; // dot index used to get UIImageView from pool instead of creating one
    NSMutableArray *dotImageViews;
    UIImageView *timerM;
    UIImageView *timerS;
    UIImageView *timerSS;
}

@property (nonatomic, retain) Kitchen_SamuraiAppDelegate *appDelegate;
@property (nonatomic, retain) Game *game;
@property (nonatomic, retain) NSMutableDictionary* progressImageDictionary;
@property (nonatomic, retain) NSMutableDictionary* numberImageDictionary;

- (IBAction)quitGameButtonClicked:(id)sender;
- (IBAction)pauseGameButtonClicked:(id)sender;
- (IBAction)resumeGameButtonClicked:(id)sender;
- (IBAction)nextRecipe:(id)sender;
- (void)performSwipe:(id)sender;
- (void)dragPot:(id)sender;
-(UIImageView*)addIngredientToView:(Ingredient *)i;
-(UIImageView*)addPotToView:(PhysicalObject *)p;
- (void)addProgressFrame;
- (void) mistake;
- (void) updateTimerMinutes:(int) minutes andSeconds:(int) seconds;
- (void) endGame;
- (void) updateProgressFrame:(int) i;
- (void)saveGameState:(int)r forLevel:(int)l;


@property (nonatomic, retain) IBOutlet UIImageView *timerM;
@property (nonatomic, retain) IBOutlet UIImageView *timerS;
@property (nonatomic, retain) IBOutlet UIImageView *timerSS;
@property (nonatomic, retain) IBOutlet UIButton *quitButton;
@property (nonatomic, retain) IBOutlet UIView *ingredientCountersView;
@property (nonatomic, retain) IBOutlet UIView *EndGameView;


@end
