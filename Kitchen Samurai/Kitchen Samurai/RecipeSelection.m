//
//  RecipeSelection.m
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/04/28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RecipeSelection.h"
#import "Kitchen_SamuraiAppDelegate.h"



@implementation RecipeSelection

@synthesize DetailedView;
@synthesize Lock;
@synthesize appDelegate;
@synthesize rating;
@synthesize DetailedTextView;
@synthesize DetailedDifficulty;
@synthesize DetailedStars;
@synthesize DetailedTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) createLabels
{
    NSInteger n = 0;
    NSInteger c = 0;
    NSInteger r = 0;
    for (NSInteger j=1; j<=3;j++)
    {
        for (NSInteger i=1; i<=4;i++)
        {
            UILabel *newLabel = [[UILabel alloc] init];
            newLabel.text = [NSString stringWithFormat:@"Label #%d",n];
            newLabel.frame = CGRectMake(125+210*c,130+210*r ,150, 80);
            newLabel.tag = n;
            newLabel.numberOfLines = 0;
            [newLabel setTextAlignment:UITextAlignmentCenter];
            newLabel.lineBreakMode = UILineBreakModeWordWrap;
            [newLabel setBackgroundColor:[UIColor clearColor]];
            [self.view addSubview:newLabel];
            [newLabel release],newLabel = nil;
            n++;
            c++;
        }
        r++;
        c=0;
    }
}

- (void) createButtons
{
    NSInteger n = 1;
    NSInteger c = 0;
    NSInteger r = 0;
    for (NSInteger j=1; j<=3;j++)
    {
        for (NSInteger i=1; i<=4;i++)
        {
            UIButton *newButton = [[UIButton alloc] init];
            newButton.frame = CGRectMake(100+210*c,120+210*r ,190, 190);
            newButton.tag = n;
            [newButton setBackgroundColor:[UIColor clearColor]];
            [newButton setImage:[UIImage imageNamed:@"recipe_button_unlocked"] forState:UIControlStateNormal];
            [self.view addSubview:newButton];
            [newButton release],newButton = nil;
            n++;
            c++;
        }
        r++;
        c=0;
    }
}

- (UILabel *)getLabelAtIndex:(NSInteger)index
{
    //index--;
    for (UIView *v in self.view.subviews)
    {
        if ([v isKindOfClass:[UILabel class]]) 
        {
            if (v.tag == index)
            {
                //NSLog(@" Label found at index %i",index);
                return (UILabel *)v;
            }
        }
    }
    //NSLog(@" Label not found at index %i",index);
    return nil;
}

- (UIButton *)getButtonAtIndex:(NSInteger)index
{
    for (UIView *v in self.view.subviews)
    {
        if([v isKindOfClass:[UIButton class]])
            {
                if (v.tag == index)
                {
                    //NSLog(@" Button found at index %i",index);
                    return (UIButton *)v;
                }
            }
    }
    //NSLog(@"Button not found at index %i",index);
    return nil;
}

- (UITextView *)getTextViewAtIndex:(NSInteger)index
{
    for (UIView *v in self.view.subviews)
    {
        if([v isKindOfClass:[UITextView class]])
        {
            if (v.tag == index)
            {
                //NSLog(@" Image found at index %i",index);
                return (UITextView *)v;
            }
        }
    }
    //NSLog(@"Text not found at index %i",index);
    return nil;
}

- (UIImageView *)getImageAtIndex:(NSInteger)index
{
    for (UIView *v in self.view.subviews)
    {
        if([v isKindOfClass:[UIImageView class]])
        {
            if (v.tag == index)
            {
                //NSLog(@" Image found at index %i",index);
                return (UIImageView *)v;
            }
        }
    }
    //NSLog(@"Image not found at index %i",index);
    return nil;
}

- (void) loadStars
{
    for (int i = 0;i < 6;i++)
    {
        [starsArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d_stars",i]]];
    }
}

- (void)dealloc
{
    [Lock release];
    [rating release];
    [DetailedTextView release];
    [DetailedTitle release];
    [DetailedStars release];
    [DetailedDifficulty release];
    [DetailedView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)loadRecipeList
{
    NSString* path = [[NSBundle mainBundle] bundlePath];
    DataPath = [path stringByAppendingPathComponent:@"Recipe_List.plist"];
    //NSLog(@"%@",DataPath);
    recipeList = [[NSMutableDictionary alloc] initWithContentsOfFile:DataPath];
    
    for (int number = 1; number < [recipeList count]+1; number++)
    {
        UILabel *tmp = [self getLabelAtIndex:number];
        NSString *key = [NSString stringWithFormat:@"%i",number];
        NSMutableDictionary* recipe = [recipeList valueForKey:key];
        NSString* name = [recipe valueForKey:@"Name"];
        //int dif = [[recipe valueForKey:@"Difficulty"] intValue];
        int starRating = [[recipe valueForKey:@"Rating"] intValue];
        BOOL unlocked = [[recipe objectForKey:@"Unlocked"] boolValue];
        
        if (unlocked)
        {
            UIButton *tmp_btn = [self getButtonAtIndex:number];
            tmp_btn.enabled = YES;
            [tmp_btn setImage:[UIImage imageNamed:@"recipe_button_unlocked"] forState:UIControlStateNormal];
            [tmp_btn setBackgroundColor:[UIColor clearColor]];
            UIImageView *tmp_star = [self getImageAtIndex:number];
            //tmp_star = [[UIImageView alloc] initWithImage:[starsArray objectAtIndex:rating]];
            //tmp_star = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d_stars",rating]]];
            [tmp_star setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_stars",starRating]]];
            
            [tmp setText:[NSString stringWithFormat:@"%@",name]];
            [tmp sizeToFit];
            
            //NSLog(@"UNLOCKED : ");
        }
        else 
        {
            //NSLog(@"LOCKED");
            //UIButton *tmp_btn = [self getButtonAtIndex:number];
            //[tmp_btn setImage:[UIImage imageNamed:@"recipe_button_locked"] forState:UIControlStateNormal];
            [Lock setHidden:NO];
        }
        

        //NSLog(@"Recipe No : %@ is %@ With Difficulty of %i has been unlocked %i. Star Rating is %d",key,name,dif,unlocked,starRating);
        
    }
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self createButtons];
    //[self createLabels];
    [self loadRecipeList];
   

}

- (void)viewDidUnload
{
    [self setLock:nil];
    [self setRating:nil];
    [self setDetailedTextView:nil];
    [self setDetailedTitle:nil];
    [self setDetailedStars:nil];
    [self setDetailedDifficulty:nil];
    [self setDetailedView:nil];
    [recipeList release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)close:(id)sender
{
    UIView* tmpDetails = [self.view viewWithTag:222];
    tmpDetails.hidden = YES;
    
    tmpDetails = nil;
}

- (IBAction)Cook:(id)sender
{
    NSLog(@"ASD");
    [appDelegate switchToGame:chosenRecipe];

}

- (IBAction)getRecipe:(id)sender
{
    //DetailedViewOpen = YES;//check out how to set bool correctly.
    
    
    
    NSString* buttonTag = [NSString stringWithFormat:@"%i",[sender tag]];
    int level;
    level = [buttonTag intValue];
            
    NSMutableDictionary* recipe = [recipeList valueForKey:buttonTag];
    
    //NSLog(@"%@",[recipe valueForKey:@"Rating"]);
    
    NSNumber* NewRating = [[NSNumber alloc] initWithInt:4];
    
    
    [recipe setValue:NewRating forKey:@"Rating"];
    
    
    DetailedTitle.text = [recipe valueForKey:@"Name"];
    
    [DetailedStars setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%istars_large",[[recipe valueForKey:@"Rating"] intValue]]]];
    
    DetailedDifficulty.text = [NSString stringWithFormat:@"%i",[[recipe valueForKey:@"Difficulty"] intValue]];
    
    
    //NSLog(@"%@",[recipe valueForKey:@"Rating"]);
    
    NSString* homeDir = [[NSBundle mainBundle] pathForResource:[recipe valueForKey:@"DetailsName"]  ofType:@"txt"];
    //NSLog(@"%@",homeDir);
    
    NSString* contents = [NSString stringWithContentsOfFile:homeDir encoding:NSUTF8StringEncoding error:nil];
    
    //NSLog(@"%@",contents);
    
    DetailedTextView.text = contents;
    
    NSString* path2 = [[NSBundle mainBundle] bundlePath];
    NSString* DataPath2 = [path2 stringByAppendingPathComponent:@"Recipe_List.plist"];
    
    
    //NSLog(@"%@",DataPath2);
    
    
    [recipeList writeToFile:DataPath2 atomically:YES];
    DetailedView.hidden = NO;
    chosenRecipe = recipe; //just put this here as global for now so that Cook: can see what it is to send to the game, not the best way to do it though
        
        
}

- (IBAction)goBack:(id)sender {
    if (DetailedView.hidden == NO)
    {
        DetailedView.hidden = YES;
        [self loadRecipeList];
        //DetailedViewOpen = NO;
    }
    else
    {
        [self.view removeFromSuperview];
    }
}
@end
