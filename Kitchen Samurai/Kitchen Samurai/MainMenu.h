//
//  MainMenu.h
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/04/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@class RecipeSelection;

@interface MainMenu : UIViewController {
    
}

@property (nonatomic, retain) IBOutlet RecipeSelection *recipeSelection;
@property (readwrite, retain) MPMoviePlayerViewController *instructions;
@property (nonatomic, retain) NSURL *videoURL;

- (void)instructionVideoDone:(NSNotification*)aNotification;

- (IBAction)startNewGame:(id)sender;
- (IBAction)continueGame:(id)sender;
- (IBAction)showRecipes:(id)sender;
- (IBAction)showInstructions:(id)sender;

@end
