//
//  MainMenu.m
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/04/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainMenu.h"
#import "RecipeSelection.h"

@implementation MainMenu

@synthesize recipeSelection;
@synthesize instructions;
@synthesize videoURL;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSString *path = [[NSBundle mainBundle] pathForResource:@"video_test" ofType:@"mp4"];
        NSURL *url = [[NSURL fileURLWithPath:path] retain];
        self.videoURL = url;
        [url release];
        MPMoviePlayerViewController *vd = [[MPMoviePlayerViewController alloc] initWithContentURL:self.videoURL];
        vd.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
        [vd shouldAutorotateToInterfaceOrientation:YES];
        self.instructions = vd;
        [vd release];
    }
    return self;
}

- (void)dealloc
{
    [self.recipeSelection release];
    [self.instructions release];
    [self.videoURL release];
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

- (void)instructionVideoDone:(NSNotification*)aNotification
{
    MPMoviePlayerController *player = [aNotification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    [player stop];
    [instructions.view removeFromSuperview];
}

- (IBAction)startNewGame:(id)sender {
}

- (IBAction)continueGame:(id)sender {
}

- (IBAction)showRecipes:(id)sender {
    [self.view addSubview:recipeSelection.view];
}

- (IBAction)showInstructions:(id)sender {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(instructionVideoDone:) name:MPMoviePlayerPlaybackDidFinishNotification object:[instructions moviePlayer]];
    [self.view addSubview:instructions.view];
    [instructions.moviePlayer play];
}
@end
