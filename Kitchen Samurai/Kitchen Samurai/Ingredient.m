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
@synthesize view;
@synthesize x;
@synthesize y;
-(void) setX:(int)startX andY:(int)startY andType:(NSString*)startType{
    self.x=startX;
    self.y=startY;
    self.type=startType;
}

-(void)moveByTime:(int)time{
    self.x+=1;
    self.y+=1;
    view.center=CGPointMake(self.x,self.y);
    //check collision detection, kill if collide or if goes offscreen...
}

@end
