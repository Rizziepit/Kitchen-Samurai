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

float SCREENWIDTH=1024;
float SCREENHEIGHT=768;
float GRAVITY=-320.0f;
-(id)initWithRecipe:(NSDictionary*)recipe{
    [super init];
    //NSLog(@"%i",[recipe count]);
    return self;
}

-(NSArray*)pickStartCoords{
    /*STARTING MOTION GENERATOR
     
     alg:
     ypos=offscreen
     pick random vy within range that works fine for current gravity (either experiment and hardcode, or calculate from gravity value to allow for changing gravity)
     work out y distance travelled
     work out time travelled
     pick x pos in first or last quarter of screen, or one of external quarters
     check maxdistance ingredient can travel from that point
     choose distance random between min and max (can be weighted to allow for more long distance movements)
     calculate xvelocity that will cause this distance to be travelled using time calculated earlier.
     */
    float y = 0;
    float vy =(SCREENHEIGHT/3)*2 +rand()%(int)(SCREENHEIGHT/3);
    float timetravelled = (0-vy/GRAVITY)*2;
    float x;
    float vx;
    if (rand()%100<50){
        x= -(SCREENWIDTH/4) + rand()%(int)(SCREENWIDTH/2);
        float maxdistance = SCREENWIDTH-x-50;
        float mindistance=SCREENWIDTH/2;
        float distance = mindistance+rand()%(int)(maxdistance-mindistance);
      //  float yDistanceTravelled = 4;
       // float timetravelled = (-2*vy+sqrt(4*((int)vy^2) - 4*GRAVITY*-2*yDistanceTravelled))/2*GRAVITY;
        vx = distance/timetravelled;

    }
    else{
        x= (SCREENWIDTH/4)*3 + rand()%(int)(SCREENWIDTH/2);
        float maxdistance = -(x-50);    
        float mindistance=-SCREENWIDTH/2;
        float distance = mindistance+rand()%(int)(maxdistance-mindistance);
        vx = distance/timetravelled;
    }
    NSArray* start = [NSArray arrayWithObjects:[NSNumber numberWithFloat:x],[NSNumber numberWithFloat:y],[NSNumber numberWithFloat:vx],[NSNumber numberWithFloat:vy], nil];
    return start;
}

-(Ingredient*)giveIngredient{
    //Simple unbalanced one for now, just generates with 1%chance each frame
    if (rand()%100<3){
        Ingredient* i = nil;
        float rad= 30.0f;
        IngredientType type = [self pickType];
        NSArray* start = [self pickStartCoords];
        i=[[Ingredient alloc] init:[[start objectAtIndex:0] floatValue]	 :[[start objectAtIndex:1] floatValue] :[[start objectAtIndex:2] floatValue] :[[start objectAtIndex:3] floatValue] :rad :type];
        [i autorelease];
        return i;
    }
    return nil;
}

-(IngredientType) pickType{
    return (IngredientType)(rand()%22);
}


@end