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

@synthesize gameModel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    for(Ingredient* i in gameModel.ingredients)
    {
        CGContextSetRGBFillColor(context, 255, 0, 0, 1);
        CGContextFillEllipseInRect(context, CGRectMake(i.xPos, 768 - i.yPos, 32, 32));
    }
}


- (void)dealloc
{
    [super dealloc];
}

@end
