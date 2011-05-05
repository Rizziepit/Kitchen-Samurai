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
    
}

-(void)moveByTime:(int) time;
-(void) setX:(int)startX andY:(int)startY andType:(NSString*)type;

@property(nonatomic,retain) NSString* type;

@end
