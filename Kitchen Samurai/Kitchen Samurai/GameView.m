//
//  GameView.m
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/05/07.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameView.h"
#import "Ingredient.h"
#import "Game.h"

@implementation GameView

NSString * const ingredientTypeToFileName[] = {
    @"asparagus.png",
    @"baby_marrow.png",
    @"bean.png",
    @"beetroot.png",
    @"bell_pepper.png",
    @"brinjal.png",
    @"broccoli.png",
    @"butternut.png",
    @"carrot.png",
    @"cauliflower.png",
    @"celery.png",
    @"chilli.png",
    @"corn.png",
    @"garlic.png",
    @"lemon.png",
    @"onion.png",
    @"parsnip.png",
    @"peas.png",
    @"potato.png",
    @"pumpkin.png",
    @"tomato.png",
    @"turnip.png"
};

NSString * const numberToFileName[] = {
    @"x.png"};


@synthesize gameModel;
@synthesize ingredientImages;
@synthesize numberImages;
@synthesize pot;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self; 
}


- (void)initIngredientImages
{
    // set up all the ingredient images here
    NSLog(@"initializing ingredient images and numbers...");
    ingredientImages = [[NSMutableArray alloc] initWithCapacity:22];
    for (int i = 0; i < 22; i++)
    {
        UIImage* image = [UIImage imageNamed:ingredientTypeToFileName[i]];
        [ingredientImages addObject:image];
        //[image release];
    }
    numberImages = [[NSMutableArray alloc] initWithCapacity:1];
    UIImage* image = [UIImage imageNamed:numberToFileName[0]];
    [numberImages addObject:image];
    //[image release];
    
    // set up the pot images
    pot = [UIImage imageNamed:@"pot.png"];
}


- (void)dealloc
{
    [ingredientImages release];
    [gameModel release];
    [pot release];
    [super dealloc];
}

@end
