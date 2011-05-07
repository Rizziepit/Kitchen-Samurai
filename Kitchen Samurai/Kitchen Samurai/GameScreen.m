//
//  GameScreen.m
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/04/28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameScreen.h"
#import "Kitchen_SamuraiAppDelegate.h"
#import "Game.h"
#import "GameView.h"

@implementation GameScreen

@synthesize appDelegate;
@synthesize game;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // set up all the ingredient images here
        UIImage* im = [UIImage imageNamed:@"test.jpg"];
        ingredientImages[0] = [im CGImage];
        [im release];
    }
    return self;
}

- (void)dealloc
{
    [appDelegate release];
    [game release];
    [super dealloc];
}

-(void)quitGameButtonClicked:(id)sender{
    [game endGame];
    [self.appDelegate switchToMenu];
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
    [((GameView*)self.view) setGameModel:game];
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

- (CGImageRef*)getIngredientImage:(int)index
{
    return &(ingredientImages[index]);
}

@end
