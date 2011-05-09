//
//  IngredientGenerator.m
//  Kitchen Samurai
//
//  Created by Aidan Musnitzky on 2011/05/09.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IngredientGenerator.h"
#import "Ingredient.h"


@implementation IngredientGenerator

-(id)initWithRecipe:(NSDictionary*)recipe{
    [super init];
    //NSLog(@"%i",[recipe count]);
    return self;
}

-(Ingredient*)giveIngredient{
    //Simple unbalanced one for now, just generates with 1%chance each frame
    Ingredient* i = nil;
    if (rand()%100<1){
        //NSString* type;
        //to do: decide on type, starting position, 
        
        int x=512;
        int y=0;
        int vx=5;
        int vy=768;
        /*if(rand()%100<50){
         type =[[NSBundle mainBundle] pathForResource:@"test" ofType:@"jpg"];
         x=150;
         }
         else
         {
         type =[[NSBundle mainBundle] pathForResource:@"recipe_button_locked" ofType:@"png"];
         
         }*/
        
        //UIImageView *ingredientView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:type]]; //this disables userinteractions, may want to reenable.
        //ingredientView.frame=CGRectMake(x, y, ingredientView.image.size.width, ingredientView.image.size.height); 
        //[gameScreen.view addSubview:ingredientView];
        IngredientType type = (IngredientType)(rand()%22);
        i=[[Ingredient alloc] init:x :y :vx :vy:32.0f:type];
    }
    [i autorelease];
    return i;
}
@end
