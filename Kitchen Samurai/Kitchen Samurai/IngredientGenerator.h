//
//  IngredientGenerator.h
//  Kitchen Samurai
//
//  Created by Aidan Musnitzky on 2011/05/09.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Ingredient;

@interface IngredientGenerator : NSObject {
    
}

-(id)initWithRecipe:(NSDictionary*)recipe;
-(Ingredient*)giveIngredient;

@end
