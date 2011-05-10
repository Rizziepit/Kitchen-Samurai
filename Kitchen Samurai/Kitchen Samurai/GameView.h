//
//  GameView.h
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/05/07.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Game;

@interface GameView : UIView {
    UIImage* pot_bottom;
    UIImage* pot_top;
}

- (void) initIngredientImages;

@property (nonatomic, retain) Game *gameModel;
@property (nonatomic, retain) NSMutableArray *ingredientImages;
@property (nonatomic, retain) NSMutableArray *numberImages;

@end
