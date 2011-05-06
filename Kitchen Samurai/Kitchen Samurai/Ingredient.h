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
    carrot,
    potato,
    tomato
} IngredientType;

@interface Ingredient : PhysicalObject {
    NSString* type;

}


@property(nonatomic,retain) NSString* type;
@end
