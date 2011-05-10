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

@interface GameScreen : UIViewController <UIGestureRecognizerDelegate> {
    CustomSwipeGestureRecognizer *drag;
    //UILongPressGestureRecognizer *drag;
    UISwipeGestureRecognizer *swipe1;

    
}

@property (nonatomic, retain) Kitchen_SamuraiAppDelegate *appDelegate;
@property (nonatomic, retain) Game *game;

- (IBAction)quitGameButtonClicked:(id)sender;
- (void)performSwipe:(id)sender;
- (void)dragPot:(id)sender;

@end
