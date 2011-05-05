//
//  Kitchen_SamuraiAppDelegate.h
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/04/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainMenu;
@class GameScreen;
@class Game;

@interface Kitchen_SamuraiAppDelegate : NSObject <UIApplicationDelegate> {

}

-(void)loadPlist;
-(void)switchToGame;
-(void)switchToMenu;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) MainMenu *mainMenu;
@property (nonatomic, retain) GameScreen *gameScreen;
@property (nonatomic, retain) Game *game;
@end
