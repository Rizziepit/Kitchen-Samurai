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

- (id) init:(float)xPosition :(float)yPosition :(float)xVelocity :(float)yVelocity :(float)collisionRadius:(IngredientType)type
{
    ingredientType = type;
    isCut = false;
    return [super init:xPosition :yPosition :xVelocity :yVelocity :collisionRadius];
}

@end
