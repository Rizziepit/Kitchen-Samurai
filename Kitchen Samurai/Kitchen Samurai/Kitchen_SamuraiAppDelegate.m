//
//  Kitchen_SamuraiAppDelegate.m
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/04/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Kitchen_SamuraiAppDelegate.h"
#import "MainMenu.h"
#import "GameScreen.h"
#import "Game.h"

@implementation Kitchen_SamuraiAppDelegate

@synthesize window=_window;
@synthesize mainMenu=_mainMenu;
@synthesize gameScreen=_gameScreen;
@synthesize game=_game;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    isInGame = NO;
    
    Game *aGame = [[Game alloc] init];
    MainMenu *aMainMenu = [[MainMenu alloc] initWithNibName:@"MainMenu" bundle:[NSBundle mainBundle]];
    GameScreen *aGameScreen = [[GameScreen alloc] initWithNibName:@"GameScreen" bundle:[NSBundle mainBundle]];
    
    [aGameScreen setAppDelegate:self];
    [aMainMenu setAppDelegate:self];
    
    // game view controller and game model need to know about each other
    [aGameScreen setGame:aGame];
    [aGame setViewController:aGameScreen];
    
    [self setGame:aGame];
    [self setGameScreen:aGameScreen];
    [self setMainMenu:aMainMenu];
    
    [aGame release];
    [aMainMenu release];
    [aGameScreen release];
    
    // Override point for customization after application launch.
    self.window.rootViewController = self.mainMenu;
    [self.window makeKeyAndVisible];
    
    //[self loadPlist];
    
    return YES;
}

- (void)loadPlist
{
    NSString* path = [[NSBundle mainBundle] bundlePath];
    NSString* DataPath = [path stringByAppendingPathComponent:@"Recipe_List.plist"];
    NSDictionary* recipeList = [[NSDictionary alloc] initWithContentsOfFile:DataPath];
    
    for (NSString *key in recipeList)
    {
        NSDictionary* recipe = [recipeList valueForKey:key];
        NSString* name = [recipe valueForKey:@"Name"];
        int dif = [[recipe valueForKey:@"Difficulty"] intValue];
        BOOL unlocked = [[recipe objectForKey:@"Unlocked"] boolValue];
        
        
        NSLog(@"Recipe No : %@ is %@ With Difficulty of %i has been unlocked %i",key,name,dif,unlocked);

    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    if (isInGame){
        if(![_game isPaused]){
        [_game pauseGame];
        }
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_mainMenu release];
    [_gameScreen release];
    [_game release];
    [super dealloc];
}

- (void)switchToGame:(NSMutableDictionary*) recipe:(int)level
{
    isInGame = YES;
    self.window.rootViewController = self.gameScreen;
    // start the game
    [self.game startGame:recipe:level];
}

- (void)startNextRecipe:(int)level
{
    //find which recipe
    NSString* path = [[NSBundle mainBundle] bundlePath];
    NSString* DataPath = [path stringByAppendingPathComponent:@"Recipe_List.plist"];
    NSMutableDictionary* recipeList = [[NSMutableDictionary alloc] initWithContentsOfFile:DataPath];
    NSString* tmp = [NSString stringWithFormat:@"%i",level];
    
    NSMutableDictionary* recipe = [recipeList valueForKey:tmp];
    
    [self switchToGame:recipe:level];
}


- (void)switchToMenu
{
    isInGame = NO;
    self.window.rootViewController = self.mainMenu;
}

@end
