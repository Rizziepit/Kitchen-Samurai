//
//  RecipeSelection.h
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/04/28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RecipeSelection : UIViewController {
    UILabel *Recipe_Name;
}
- (void)loadRecipeList;
- (IBAction)goBack:(id)sender;
@property (nonatomic, retain) IBOutlet UILabel *Recipe_Name;


@end
