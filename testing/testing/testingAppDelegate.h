//
//  testingAppDelegate.h
//  testing
//
//  Created by Rizmari Versfeld on 2011/04/28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class testingViewController;

@interface testingAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet testingViewController *viewController;

@end
