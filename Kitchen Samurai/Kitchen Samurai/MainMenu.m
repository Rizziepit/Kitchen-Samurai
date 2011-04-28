//
//  MainMenu.m
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/04/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainMenu.h"

@implementation MainMenu

@synthesize mainMenu;
@synthesize recipeSelection;
@synthesize instructions;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        UIView *aMainMenu = [[[NSBundle mainBundle] loadNibNamed:@"MainMenu" owner:self options:nil] objectAtIndex:0];
        UIView *aRecipeSelection = [[[NSBundle mainBundle] loadNibNamed:@"MainMenu" owner:self options:nil] objectAtIndex:0];
        UIView *aInstructions = [[[NSBundle mainBundle] loadNibNamed:@"MainMenu" owner:self options:nil] objectAtIndex:0];
        [self setMainMenu:aMainMenu];
        [self setRecipeSelection:aRecipeSelection];
        [self setInstructions:aInstructions];
        [self setView:mainMenu];
        [aMainMenu release];
        [aRecipeSelection release];
        [aInstructions release];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)startNewGame:(id)sender {
}

- (IBAction)continueGame:(id)sender {
}

- (IBAction)showRecipes:(id)sender {
}

- (IBAction)showInstructions:(id)sender {
}
@end
