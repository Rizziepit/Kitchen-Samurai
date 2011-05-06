//
//  Ingredient.h
//  Kitchen Samurai
//
//  Created by Aidan Musnitzky on 2011/05/05.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Ingredient : NSObject {
    NSString* type;
    UIImageView*view;
    float x;
    float y;

}

-(void)moveByTime:(int) time;
-(void)setView:(UIImageView*)v;
-(void) setX:(int)startX andY:(int)startY andType:(NSString*)type;

@property(nonatomic,retain) NSString* type;
@property(nonatomic,retain) UIImageView* view;
@property(nonatomic) float x;
@property(nonatomic) float y;

@end
