//
//  Ingredient.h
//  Kitchen Samurai
//
//  Created by Aidan Musnitzky on 2011/05/05.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhysicalObject.h"

typedef enum {
    asparagus,
    baby_marrow,
    bean,
    beetroot,
    bell_pepper,
    brinjal,
    broccoli,
    butternut,
    carrot,
    cauliflower,
    celery,
    chilli,
    corn,
    garlic,
    lemon,
    onion,
    parsnip,
    peas,
    potato,
    pumpkin,
    tomato,
    turnip
} IngredientType;

@interface Ingredient : PhysicalObject {

}

- (id) init:(float)xPosition :(float)yPosition :(float)xVelocity :(float)yVelocity :(float)collisionRadius:(IngredientType)type;

@property(nonatomic) IngredientType ingredientType;
@end
