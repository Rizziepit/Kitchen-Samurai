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

@interface GameScreen : UIViewController <UIGestureRecognizerDelegate> {
    UILongPressGestureRecognizer *drag;
    UISwipeGestureRecognizer *swipe1;
    UILongPressGestureRecognizer *tempSwipe;
    
    UIButton *quitButton;
    UIView *ingredientCountersView;
}

@property (nonatomic, retain) Kitchen_SamuraiAppDelegate *appDelegate;
@property (nonatomic, retain) Game *game;
@property (nonatomic, retain) NSMutableDictionary* progressImageDictionary;
@property (nonatomic, retain) NSMutableDictionary* numberImageDictionary;

- (IBAction)quitGameButtonClicked:(id)sender;
- (void)performSwipe:(id)sender;
- (void)dragPot:(id)sender;
-(UIImageView*)addIngredientToView:(Ingredient *)i;
-(UIImageView*)addPotToView:(PhysicalObject *)p;
- (void)addProgressFrame;
- (void) updateProgressFrame:(int) i;


@property (nonatomic, retain) IBOutlet UIButton *quitButton;
@property (nonatomic, retain) IBOutlet UIView *ingredientCountersView;


@end
