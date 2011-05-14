//
//  IngredientGenerator.h
//  Kitchen Samurai
//
//  Created by Aidan Musnitzky on 2011/05/09.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ingredient.h"

@class Ingredient;
@class Game;

@interface IngredientGenerator : NSObject {
}

-(id)initForGame:(Game*)g;
-(Ingredient*)giveIngredient;
-(IngredientType) pickType;
-(NSArray*)pickStartCoords;

@property (nonatomic, retain) Game *gameModel;
@end
