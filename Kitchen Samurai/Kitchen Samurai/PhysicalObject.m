//
//  PhysicalObject.m
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/05/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PhysicalObject.h"

@implementation PhysicalObject
float gravity = 40.0f;

@synthesize xPos;
@synthesize yPos;
@synthesize xVel;
@synthesize yVel;
@synthesize sprite;

- (id)init:(float)xPosition : (float) yPosition : (float) xVelocity : (float) yVelocity : (UIImageView*) spriteImage
{
    [super init];
    self.xPos = xPosition;
    self.yPos = yPosition;
    self.xVel = xVelocity;
    self.yVel = yVelocity;
    self.sprite = spriteImage;
    return self;
}

- (void)updatePosition:(float)timeSinceLastFrame
{
    //v = u + at
    
    xPos += xVel * timeSinceLastFrame;
    yPos += yVel * timeSinceLastFrame;
    yVel = yVel + gravity * timeSinceLastFrame;
    self.sprite.center = CGPointMake(xPos, 768 - yPos);
}

@end
