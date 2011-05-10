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
    @"x.jpg",
    @"1.png",
    @"2.png",
    @"3.png",
    @"4.png",
    @"5.png",
    @"6.png",
    @"7.png",
    @"8.png",
    @"9.png",
};

@synthesize gameModel;
@synthesize ingredientImages;
@synthesize numberImages;

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
        [image release];
    }
    numberImages = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i = 0; i < 10; i++)
    {
        UIImage* image = [UIImage imageNamed:numberToFileName[i]];
        [numberImages addObject:image];
        [image release];
    }
    
    // set up the pot images
    pot_bottom = [UIImage imageNamed:@"pot.png"];
    pot_top = [UIImage imageNamed:@"pot_top.png"];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //Draw topleft window
    float x=20;
    float y=20;
    for(id type in gameModel.ingredientsLeft)
    {
        id number = [gameModel.ingredientsLeft valueForKey:type];
        UIImage* image = [ingredientImages objectAtIndex:[type intValue]];
        [image drawAtPoint:CGPointMake(x,y)];
        UIImage* numberimage = [numberImages objectAtIndex:[number intValue]];
        if([number intValue]==0){
            [numberimage drawAtPoint:CGPointMake(x,y)];
        }
        else{
            [numberimage drawAtPoint:CGPointMake(x+100,y)];
        }
        y+=100;
    }
    
    //Draw ingredients on screen
    for(Ingredient* i in gameModel.ingredientsOnScreen)
    {
        UIImage* image = [ingredientImages objectAtIndex:(int)i.ingredientType];
        //[image drawAtPoint:CGPointMake(i.xPos - image.size.width/2, 768 - i.yPos - image.size.height/2) blendMode:kCGBlendModeNormal alpha:i.alpha];
        [image drawAtPoint:CGPointMake(i.xPos - image.size.width/2, 768 - i.yPos - image.size.height/2)];
    }
    CGPoint top_left = CGPointMake(gameModel.pot.xPos - pot_top.size.width/2,768 - gameModel.pot.yPos - pot_top.size.height/2);
    [pot_top drawAtPoint:top_left];
    [pot_bottom drawAtPoint:top_left];
}

- (void)dealloc
{
    [ingredientImages release];
    [gameModel release];
    [super dealloc];
}

@end
