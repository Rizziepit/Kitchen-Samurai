//
//  RecipeSelection.m
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/04/28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RecipeSelection.h"


@implementation RecipeSelection
@synthesize Recipe_Name;

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
    [Recipe_Name release];
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
    NSString* DataPath = [path stringByAppendingPathComponent:@"Recipe_List.plist"];
    NSDictionary* recipeList = [[NSDictionary alloc] initWithContentsOfFile:DataPath];
    
    for (NSString *key in recipeList)
    {
        NSDictionary* recipe = [recipeList valueForKey:key];
        NSString* name = [recipe valueForKey:@"Name"];
        int dif = [[recipe valueForKey:@"Difficulty"] intValue];
        BOOL unlocked = [[recipe objectForKey:@"Unlocked"] boolValue];
        if (unlocked)
        {
            NSLog(@"UNLOCKED : ");
        }
        else 
        {
            NSLog(@"LOCKED");
        }
        [Recipe_Name setText:name];
        NSLog(@"Recipe No : %@ is %@ With Difficulty of %i has been unlocked %i",key,name,dif,unlocked);
        
    }
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadRecipeList];

}

- (void)viewDidUnload
{
    [self setRecipe_Name:nil];
    [self setRecipe_Name:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)goBack:(id)sender {
    [self.view removeFromSuperview];
}
@end
