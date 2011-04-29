//
//  MainMenu.h
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/04/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecipeSelection;

@interface MainMenu : UIViewController {
    
}

@property (nonatomic, retain) IBOutlet RecipeSelection *recipeSelection;

- (IBAction)startNewGame:(id)sender;
- (IBAction)continueGame:(id)sender;
- (IBAction)showRecipes:(id)sender;
- (IBAction)showInstructions:(id)sender;

@end
