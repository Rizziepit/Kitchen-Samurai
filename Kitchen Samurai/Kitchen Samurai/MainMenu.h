//
//  MainMenu.h
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/04/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenu : UIViewController {
    
}

@property (nonatomic, retain) UIView *mainMenu;
@property (nonatomic, retain) UIView *recipeSelection;
@property (nonatomic, retain) UIView *instructions;

- (IBAction)startNewGame:(id)sender;
- (IBAction)continueGame:(id)sender;
- (IBAction)showRecipes:(id)sender;
- (IBAction)showInstructions:(id)sender;

@end
