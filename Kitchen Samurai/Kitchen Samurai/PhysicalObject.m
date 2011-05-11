//
//  PhysicalObject.m
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/05/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PhysicalObject.h"

@implementation PhysicalObject
float gravity = -320.0f;

@synthesize xPos;
@synthesize yPos;
@synthesize xVel;
@synthesize yVel;
@synthesize radius;
@synthesize image;

- (id)init:(float)xPosition : (float) yPosition : (float) xVelocity : (float) yVelocity :(float) collisionRadius
{
    [super init];
    self.xPos = xPosition;
    self.yPos = yPosition;
    self.xVel = xVelocity;
    self.yVel = yVelocity;
    self.radius = collisionRadius;
    return self;
}

- (void)updatePosition:(float)timeSinceLastFrame
{
    //v = u + at
    
    xPos += xVel * timeSinceLastFrame;
    yPos += yVel * timeSinceLastFrame;
    yVel = yVel + gravity * timeSinceLastFrame;
    [image setCenter:CGPointMake(xPos, 768-yPos)];
}

- (BOOL)checkCollisionWithLine:(float)startX: (float)startY: (float)endX: (float)endY
{
    // r2 = x2 + y2
    // y = mx + c
    // c = y - mx;
    
    float m = (endY - startY)/(endX - startX);
    float a = -1 * m;
    float c = -1 * (startY - m * startX);
    
    // dist = |ax + by + c|/root(a2 + b2)
    float dist = abs(a * xPos + yPos + c)/sqrtf(a*a + 1);
    if (dist <= radius)
        return YES;
    else
        return NO;
}

- (BOOL) checkCollisionWithPoint:(float)x :(float)y
{
    float difX = xPos - x;
    float difY = yPos - y;
    float dist2 = difX * difX + difY * difY;
    if (dist2 <= radius * radius)
        return YES;
    else
        return NO;
}

- (void) dealloc
{
    [image removeFromSuperview];
    [super dealloc];
}

- (BOOL) isOffscreen
{
    if (yPos < -radius)
        return YES;
    else
        return FALSE;
}
@end
