//
//  RecipeSelection.h
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/04/28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RecipeSelection : UIViewController {
    UIImageView *Lock;
    UIImageView *rating;
    NSMutableArray* starsArray;
}
- (void)loadRecipeList;
- (void) createLabels;
- (void) createButtons;
- (UILabel *)getLabelAtIndex:(NSInteger)index;
- (UIButton *)getButtonAtIndex:(NSInteger)index;
- (UIImageView *)getImageAtIndex:(NSInteger)index;
- (IBAction)goBack:(id)sender;
@property (nonatomic, retain) IBOutlet UIImageView *Lock;
@property (nonatomic, retain) IBOutlet UIImageView *rating;


@end
