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
#import "PhysicalObject.h"
#import "Ingredient.h"

@implementation GameScreen
@synthesize endGameLabel;
@synthesize timeLabel;
@synthesize quitButton;
@synthesize ingredientCountersView;
@synthesize EndGameView;
@synthesize pauseButton;
@synthesize chef1;
@synthesize chef2;
@synthesize nextButton;
@synthesize chef3;

@synthesize appDelegate;
@synthesize game;
@synthesize numberImageDictionary;
@synthesize progressImageDictionary;
@synthesize mistakes;
@synthesize starsImage;
@synthesize retryButton;
@synthesize play;
@synthesize pause;
@synthesize tempSwipe;
@synthesize drag;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        fingerVelocities = (CGFloat*)malloc(3*sizeof(CGFloat));
        fingerVelocities[0] = 0;
        fingerVelocities[1] = 0;
        fingerVelocities[2] = 0;
        lastFingerPosition.x = -1;
        lastFingerTime = -1;
        
        pause = [UIImage imageNamed:@"pause.png"];
        play = [UIImage imageNamed:@"play.png"];
        
        dot = [UIImage imageNamed:@"fingerDot.jpg"];
        dotCounter = 0;
        dotImageViews = [[NSMutableArray alloc] initWithCapacity:200];
        for (int i = 0; i < 200; i++)
        {
            UIImageView* fingerDot = [[UIImageView alloc] initWithImage:dot];
            [dotImageViews addObject:fingerDot];
            [fingerDot release];
        }
    }
    baarMetLarge = [UIFont fontWithName:@"Baar Metanoia" size:48];
    baarMetXLarge = [UIFont fontWithName:@"Baar Metanoia" size:64];
    baarMetSmall = [UIFont fontWithName:@"Baar Metanoia" size:24];
    return self;
}

- (void) updateTimerMinutes: (int) minutes andSeconds:(int) seconds
{
    
    if (seconds==0){
        [timeLabel setText:[NSString stringWithFormat:@"%i:00",minutes]];    
    }
    else if(seconds<=9){
        [timeLabel setText:[NSString stringWithFormat:@"%i:0%i",minutes,seconds]];    
    }
    else{
        [timeLabel setText:[NSString stringWithFormat:@"%i:%i",minutes,seconds]];    
    }

}

- (IBAction)retry:(id)sender 
{
    NSLog(@"retry pressed");
    [appDelegate startNextRecipe:game.levelNumber];
}

- (void)performSwipe:(id)sender
{
    CGPoint touchPoint = [((UILongPressGestureRecognizer*)sender) locationInView:tempSwipe.view];
    CFTimeInterval currentTime = CACurrentMediaTime();
    CGFloat timeDif = currentTime - lastFingerTime;
    if (lastFingerPosition.x != -1 && timeDif < 0.033f)
    {
        fingerVelocities[2] = fingerVelocities[1];
        fingerVelocities[1] = fingerVelocities[0];
        CGFloat difX = touchPoint.x - lastFingerPosition.x;
        CGFloat difY = touchPoint.y - lastFingerPosition.y;
        CGFloat size = sqrtf(difX*difX + difY*difY);
        fingerVelocities[0] = size/timeDif;
        CGFloat meanVelocity = (fingerVelocities[0] + fingerVelocities[1] + fingerVelocities[2])/3.0f;
        if (meanVelocity > 1500)
        {
            CGPoint vector = CGPointMake(difX/size, difY/size);
            CGPoint current = lastFingerPosition;
            CGFloat increment = size/16;
            for (int i = 0; i < increment; i++)
            {
                current.x = current.x + 16*vector.x;
                current.y = current.y + 16*vector.y;
                UIImageView* fingerDot = [dotImageViews objectAtIndex:dotCounter];
                [fingerDot setAlpha:1];
                [fingerDot setCenter:current];
                [UIImageView animateWithDuration:0.1 delay:i/increment*timeDif options:UIViewAnimationOptionAllowUserInteraction animations:^{fingerDot.alpha = 0.0;} completion:^(BOOL finished){ [fingerDot removeFromSuperview];}];
                [self.view insertSubview:fingerDot aboveSubview:ingredientCountersView];
                dotCounter++;
                if (dotCounter > 199)
                    dotCounter = 0;
            }
            for (Ingredient* i in game.ingredientsOnScreen)
            {
                if (abs(i.xPos - touchPoint.x) < 98 && abs(i.yPos - 768 + touchPoint.y) < 98)
                {
                    if (CGRectContainsPoint(i.imageView.frame, touchPoint)){
                        i.isCut = true;
                    }
                }
            }
        }
    }
    lastFingerPosition = touchPoint;
    lastFingerTime = currentTime;
}

- (void) updateProgressFrame:(int) type{
    int numLeft = [[game.ingredientsLeft valueForKey:[NSString stringWithFormat:@"%i",type]] intValue];
    UILabel* numberLabel = [numberImageDictionary valueForKey:[NSString stringWithFormat:@"%i",type]];
    //NSLog(@"%i",numLeft);
    if (numLeft==0){
        [numberLabel setText:@""];
        UIImageView* image = [progressImageDictionary valueForKey:[NSString stringWithFormat:@"%i",type]];
        UIImageView* crossOutImage = [[UIImageView alloc] initWithImage: [((GameView*)self.view).numberImages objectAtIndex:0]];
        [crossOutImage setFrame:CGRectMake(0, 0, crossOutImage.image.size.width * 0.5f, crossOutImage.image.size.height * 0.5f)];
        [crossOutImage setContentMode:UIViewContentModeScaleToFill];
        [crossOutImage setCenter:[image center]];
        [ingredientCountersView addSubview:crossOutImage];
        [crossOutImage release];
        [image release];
    }
    else{
        [numberLabel setText:[NSString stringWithFormat:@"%i", numLeft]];
    }
}

- (void) mistake
{
    mistakes++;
    if (mistakes == 1)
        [chef1 setAlpha:1];
    else if (mistakes == 2)
        [chef2 setAlpha:1];
    else if (mistakes == 3)
        [chef3 setAlpha:1];
}

- (void)saveGameState:(int)r forLevel:(int)l
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString* level = [NSString stringWithFormat:@"level-%i",l];
    NSArray* levelData = [prefs arrayForKey:level];
    NSString* ratingValue;
    int currentRating = [[levelData objectAtIndex:1] intValue];
    if (currentRating < r) {
        ratingValue = [NSString stringWithFormat:@"%i",r];
        levelData = [NSArray arrayWithObjects:@"1",ratingValue,nil];
        [prefs setObject:levelData forKey:level];
    }
    
    l++;
    //need to check if previous level has been unlocked or not
    level = [NSString stringWithFormat:@"level-%i",l];
    levelData = [prefs arrayForKey:level];
    if ([levelData count] == 0)
    {
        //unlock next recipe
        ratingValue = @"0";
        levelData = [NSArray arrayWithObjects:@"1",ratingValue,nil];
        level = [NSString stringWithFormat:@"level-%i",l];
        [prefs setObject:levelData forKey:level];
    }
    
    if (l == 5)
        l = 1;
    
    [prefs setInteger:l forKey:@"CurrentLevel"];


    [prefs synchronize];
}

- (void)dragPot:(id)sender
{
    CGPoint touchPoint =  [drag locationOfTouch:0 inView:drag.view];
    game.pot.xPos = touchPoint.x;
    [game.pot.imageView setCenter:CGPointMake(game.pot.xPos, 768 - game.pot.yPos)];
}

- (void)endGame:(BOOL)win:(int)score:(int)level
{
    EndGameView.hidden = NO;
    [pauseButton setEnabled:NO];
    [quitButton setEnabled:NO];
    [self resetGameScreen];
    if (win)
    {
        [self saveGameState:score forLevel:level];
        [endGameLabel setText:@"Congratulations! You win!"];
        if (level < 4)
        {
            [nextButton setHidden:NO];
            [nextButton setEnabled:YES];
        }
        else
        {
            [nextButton setHidden:YES];
            [nextButton setEnabled:NO];
        }
        [retryButton setHidden:YES];
        [retryButton setEnabled:NO];
        if (score == 0)
            [starsImage setImage:[UIImage imageNamed:@"0stars_large"]];
        else if (score == 1)
            [starsImage setImage:[UIImage imageNamed:@"1stars_large"]];
        else if (score == 2)
            [starsImage setImage:[UIImage imageNamed:@"2stars_large"]];
        else if (score == 3)
            [starsImage setImage:[UIImage imageNamed:@"3stars_large"]];
        else if (score == 4)
            [starsImage setImage:[UIImage imageNamed:@"4stars_large"]];
        else
            [starsImage setImage:[UIImage imageNamed:@"5stars_large"]];
    }
    else
    {
        [endGameLabel setText:@"You lose! Try again."];
        [starsImage setImage:[UIImage imageNamed:@"0stars_large"]];
        [nextButton setEnabled:NO];
        [nextButton setHidden:YES];
        [retryButton setEnabled:YES];
        [retryButton setHidden:NO];
    }  
}

- (void)dealloc
{
    [appDelegate release];
    [game release];
    [quitButton release];
    [ingredientCountersView release];
    [EndGameView release];
    [pauseButton release];
    [chef1 release];
    [chef2 release];
    [chef3 release];
    [timeLabel release];
    [endGameLabel release];
    [starsImage release];
    [retryButton release];
    [nextButton release];
    [super dealloc];
}

-(IBAction)nextRecipe:(id)sender
{
    NSLog(@"NEXT");
    [appDelegate startNextRecipe:(game.levelNumber+1)];
}

- (IBAction)mainMenuButton:(id)sender
{
    [EndGameView setHidden:YES];
    [self.appDelegate switchToMenu];
}

-(void)quitGameButtonClicked:(id)sender{
    [game endGame:NO];
    [EndGameView setHidden:YES];
    [self.appDelegate switchToMenu];
}

-(void)pauseGameButtonClicked:(id)sender{
    if (game.isPaused)
    {
        [pauseButton setImage:pause forState:UIControlStateNormal];
        [self enableGestureRecognizers:YES];
        [game resumeGame];
    }
    else
    {
        [pauseButton setImage:play forState:UIControlStateNormal];
        [self enableGestureRecognizers:NO];
        [game pauseGame];
    }
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)addProgressFrame 
{
    //Draw topleft window
    float x=16;
    float y=16;
    progressImageDictionary = [[NSMutableDictionary alloc] init];
    numberImageDictionary = [[NSMutableDictionary alloc] init];

    for(id type in game.ingredientsLeft)
    {
        NSNumber* number = [game.ingredientsLeft valueForKey:type];
        UIImageView* image = [[UIImageView alloc] initWithImage: [((GameView*)self.view).ingredientImages objectAtIndex:[type intValue]]];
        [image setCenter:CGPointMake(x,y)];
        [image setFrame:CGRectMake(x, y, image.image.size.width * 0.6f, image.image.size.height * 0.6f)];
        [image setContentMode:UIViewContentModeScaleToFill];
        [ingredientCountersView addSubview:image];
        UILabel* numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(x + 80, y, image.image.size.width * 0.6f, image.image.size.height * 0.6f)];
        [numberLabel setText:[number stringValue]];
        [numberLabel setBackgroundColor:[UIColor clearColor]];
        [numberLabel setFont:baarMetLarge];
        [ingredientCountersView addSubview:numberLabel];
        [progressImageDictionary setValue:image forKey:type];
        [numberImageDictionary setValue:numberLabel forKey:type];
        [image release];
        [numberLabel release];
        y+=image.frame.size.height + 16;
    }
    
}

- (void) enableGestureRecognizers:(BOOL)enabled
{
    [tempSwipe setEnabled:enabled];
    [drag setEnabled:enabled];
}

-(void)resetGameScreen
{
    for (UIView *view in self.ingredientCountersView.subviews) 
    {
        [view removeFromSuperview];
    }
    [chef1 setAlpha:0.3f];
    [chef2 setAlpha:0.3f];
    [chef3 setAlpha:0.3f];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
    GameView *gameView = ((GameView*)self.view);
    [gameView setGameModel:game];
    [gameView initIngredientImages];
    EndGameView.hidden = YES;
    
    mistakes = 0;
    
    [timeLabel setFont:baarMetLarge];
    [endGameLabel setFont:baarMetXLarge];
    
    // Set up swipe gesture recognizers
    tempSwipe = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(performSwipe:)];
    [tempSwipe setDelegate:self];
    [tempSwipe setNumberOfTouchesRequired:1];
    [tempSwipe setAllowableMovement:INFINITY];
    [tempSwipe setMinimumPressDuration:0];
    [tempSwipe setNumberOfTapsRequired:0];
    [gameView addGestureRecognizer:tempSwipe];
    
    // Set up drag gesture recognizer
    drag = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(dragPot:)];
    [drag setDelegate:self];
    [drag setAllowableMovement:INFINITY];
    [drag setMinimumPressDuration:0];
    [drag setNumberOfTouchesRequired:1];
    [drag setNumberOfTapsRequired:0];
    [drag setCancelsTouchesInView:YES];
    [gameView addGestureRecognizer:drag];
   // [gameView release]; shouln't be here? there was no extra retain, self.view doesn't do a retain? doing this makes exit game/start again not work anymore
}

- (void)viewDidUnload
{
    [self setQuitButton:nil];
    [self setIngredientCountersView:nil];
    [self setEndGameView:nil];
    [self setPauseButton:nil];
    [self setChef1:nil];
    [self setChef2:nil];
    [self setChef3:nil];
    [self setTimeLabel:nil];
    [self setEndGameLabel:nil];
    [self setStarsImage:nil];
    [self setRetryButton:nil];
    [self setNextButton:nil];
    [play release];
    [pause release];
    [tempSwipe release];
    [drag release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight)
        return YES;
    else
        return NO;
}

// UIGestureRecognizerDelegate methods

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGRect pot = CGRectMake(game.pot.xPos-75, 768-game.pot.yPos-70, 150, 140);
    CGPoint touch = [gestureRecognizer locationInView:self.view];
    if (CGRectContainsPoint(pot, touch))
        if (gestureRecognizer==drag)
            return YES;
        else
            return NO;
        else
            if (gestureRecognizer==tempSwipe)
                return YES;
            else
                return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint location = [touch locationInView:self.view];
    if (CGRectContainsPoint(quitButton.frame, location) || CGRectContainsPoint(pauseButton.frame, location))
        return NO;
    else
        return YES;
}

-(UIImageView*)addIngredientToView:(Ingredient *)i
{
    GameView* gameView = (GameView*)self.view;
    UIImage* image = [gameView.ingredientImages objectAtIndex:(int)i.ingredientType];
    UIImageView *imageView = [ [ UIImageView alloc ] initWithFrame:CGRectMake(i.xPos-image.size.width/2, 768 - i.yPos-image.size.height/2, image.size.width, image.size.height)];
    imageView.image = image;
    [gameView insertSubview:imageView belowSubview:ingredientCountersView];
    //[image release];
    //[imageView autorelease];
    return imageView;
}



-(UIImageView*)addPotToView:(PhysicalObject *)p
{
    GameView* gameView = (GameView*)self.view;
    UIImage* image = gameView.pot;
    UIImageView *imageView = [ [ UIImageView alloc ] initWithFrame:CGRectMake(p.xPos-image.size.width/2, 768 - p.yPos-image.size.height/2, image.size.width, image.size.height)];
    imageView.image = image;
    [gameView addSubview:imageView];
    //[image release];
    //[imageView autorelease];
    return imageView;
}

@end
