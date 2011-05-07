//
//  PhysicalObject.h
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/05/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface PhysicalObject : NSObject {
}

@property (nonatomic) float xPos;
@property (nonatomic) float yPos;
@property (nonatomic) float xVel;
@property (nonatomic) float yVel;
@property (nonatomic) float radius; // for collision detection
@property (nonatomic) CGImageRef *spriteLayer;

- (id)init:(float)xPosition : (float) yPosition : (float) xVelocity : (float) yVelocity : (CGImageRef*) spriteImage: (float) collisionRadius;
- (void)updatePosition:(float)timeSinceLastFrame;
- (BOOL)checkCollisionWithLine:(float)startX: (float)startY: (float)endX: (float)endY;
- (BOOL)checkCollisionWithPoint:(float)x: (float) y;
- (BOOL)isOffscreen;

@end
