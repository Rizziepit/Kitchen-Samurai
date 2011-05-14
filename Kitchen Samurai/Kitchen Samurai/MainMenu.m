//
//  MainMenu.m
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/04/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainMenu.h"
#import "RecipeSelection.h"
#import "Kitchen_SamuraiAppDelegate.h"

@implementation MainMenu

@synthesize recipeSelection;
@synthesize instructions;
@synthesize videoURL;
@synthesize slider;
@synthesize appDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [self.recipeSelection release];
    [self.instructions release];
    [self.videoURL release];
    [self.appDelegate release];
    [slider release];
    [super dealloc];
    [soundEffect release];
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
    prefs = [NSUserDefaults standardUserDefaults];

    float vol = [prefs floatForKey:@"Volume"];
    if (vol == 0)
    {
        vol = [slider value];
        [prefs setFloat:vol forKey:@"Volume"];
    }
    else
    {
        [slider setValue:vol];
    }
    
    soundEffect = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"swoosh" ofType:@"caf"]] error:nil];  
    
    soundEffect.volume = 0;
    [soundEffect play];
    
    soundEffect.volume = vol;
}

- (void)viewDidUnload
{
    [self setSlider:nil];
    [super viewDidUnload];
    NSLog(@"main did unload");
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

- (IBAction)adjustVolume:(id)sender
{
    float vol = [slider value];
    soundEffect.volume = vol;
    [prefs setFloat:vol forKey:@"Volume"];
}

- (IBAction)startNewGame:(id)sender {
    
    [soundEffect play];

    //find which recipe
    NSString* path = [[NSBundle mainBundle] bundlePath];
    NSString* DataPath = [path stringByAppendingPathComponent:@"Recipe_List.plist"];
    NSMutableDictionary* recipeList = [[NSMutableDictionary alloc] initWithContentsOfFile:DataPath];
    NSString* tmp = [NSString stringWithFormat:@"%i",1];
    
    NSMutableDictionary* recipe = [recipeList valueForKey:tmp];

    [appDelegate switchToGame:recipe];
}

- (IBAction)continueGame:(id)sender {
    //find which recipe
    NSMutableDictionary* recipe;
    [appDelegate switchToGame:recipe];
}

- (IBAction)showRecipes:(id)sender {
    [recipeSelection setAppDelegate:self.appDelegate];
    [soundEffect play];
    [self.view addSubview:recipeSelection.view];
}

- (IBAction)showInstructions:(id)sender {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(instructionVideoDone:) name:MPMoviePlayerPlaybackDidFinishNotification object:[instructions moviePlayer]];
    if (instructions == nil)
    {
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
    else
    {
        [instructions.moviePlayer play];
    }
    [self.view addSubview:instructions.view];
}
@end
