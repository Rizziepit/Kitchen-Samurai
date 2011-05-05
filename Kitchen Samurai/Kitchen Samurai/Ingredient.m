//
//  Ingredient.m
//  Kitchen Samurai
//
//  Created by Aidan Musnitzky on 2011/05/05.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Ingredient.h"


@implementation Ingredient
@synthesize type;
int x;
int y;
-(void) setX:(int)startX andY:(int)startY andType:(NSString*)startType{
    x=startX;
    y=startY;
    self.type=startType;
    
}

-(void)moveByTime:(int)time{
    
}

@end
