//
//  PhysicalObject.h
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/05/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhysicalObject : NSObject {
}

@property (nonatomic) float xPos;
@property (nonatomic) float yPos;
@property (nonatomic) float xVel;
@property (nonatomic) float yVel;
@property (nonatomic, retain) IBOutlet UIImageView *sprite;

- (id)init:(float)xPosition : (float) yPosition : (float) xVelocity : (float) yVelocity : (UIImageView*) spriteImage;
- (void)updatePosition:(float)timeSinceLastFrame;

@end
