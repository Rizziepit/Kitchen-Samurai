//
//  Ingredient.m
//  Kitchen Samurai
//
//  Created by Aidan Musnitzky on 2011/05/05.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Ingredient.h"

@implementation Ingredient

@synthesize ingredientType;
@synthesize isCut;
@synthesize alpha;

- (id) init:(float)xPosition :(float)yPosition :(float)xVelocity :(float)yVelocity :(float)collisionRadius:(IngredientType)type
{
    ingredientType = type;
    isCut = false;
    counter = 0;
    alpha = 1;
    return [super init:xPosition :yPosition :xVelocity :yVelocity :collisionRadius];
}

- (void) updatePosition:(float)timeSinceLastFrame
{
    [super updatePosition:timeSinceLastFrame];
    if (isCut)
    {
        counter += timeSinceLastFrame*4;
        alpha = sinf(counter);
        if (alpha < 0)
            alpha *= -1;
        [self.image setAlpha:alpha];
    }
}
@end
