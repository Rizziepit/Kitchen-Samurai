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
        /*
         UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
         
         UIView *holderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
         UIImageView *imageview = [[UIImageView alloc] initWithFrame:[holderView frame]];
         [imageview setImage:image];
         [holderView addSubview:imageview];
         
         UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scale:)];
         [pinchRecognizer setDelegate:self];
         [holderView addGestureRecognizer:pinchRecognizer];
         
         UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
         [rotationRecognizer setDelegate:self];
         [holderView addGestureRecognizer:rotationRecognizer];
         
         UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
         [panRecognizer setMinimumNumberOfTouches:1];
         [panRecognizer setMaximumNumberOfTouches:1];
         [panRecognizer setDelegate:self];
         [holderView addGestureRecognizer:panRecognizer];
         
         UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
         [tapRecognizer setNumberOfTapsRequired:1];
         [tapRecognizer setDelegate:self];
         [holderView addGestureRecognizer:tapRecognizer];
         
         [self.view addSubview:holderView];
         */
    }
    return self;
}

- (void)performSwipe:(id)sender
{
    NSLog(@"swipe performed");
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
    // Do any additional setup after loading the view from its nib
    GameView *gameView = ((GameView*)self.view);
    [gameView setGameModel:game];
    [gameView initIngredientImages];
    
    // Set up swipe gesture recognizers
    UISwipeGestureRecognizer *swipe1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(performSwipe:)];
    [swipe1 setDelegate:self];
    [swipe1 setNumberOfTouchesRequired:1];
    [swipe1 setDirection:(UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionDown | UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionUp)];
    [gameView addGestureRecognizer:swipe1];
    [swipe1 release];
    
    // Set up drag gesture recognizer
    [gameView release];
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

@end
