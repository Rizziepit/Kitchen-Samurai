//
//  CustomSwipeGestureRecognizer.m
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/05/10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomSwipeGestureRecognizer.h"
#import "PhysicalObject.h"

@implementation CustomSwipeGestureRecognizer

@synthesize pot;

- (void)reset
{
    [super reset];
}

// Touch began on view so save the start point
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if ([touches count] != 1) {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
    else
    {
        self.state = UIGestureRecognizerStateBegan;
    }
    NSLog(@"touch start");
}

// Track the move of the current gesture
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    CGPoint newPoint = [[touches anyObject] locationInView:self.view];
    pot.xPos = newPoint.x;
    /*if (self.state == UIGestureRecognizerStateFailed)
        return;
    
    // Get the current and previous touch locations
    CGPoint newPoint    = [[touches anyObject] locationInView:self.view];
    CGPoint prevPoint   = [[touches anyObject] previousLocationInView:self.view];
    
    // If we track the first stroke
    if (_checkmarkState == CheckmarkFirstStrokeDown)
    {
        // While we move to the right and downwards
        if (newPoint.x &gt;= prevPoint.x &amp;&amp; newPoint.y &gt;= prevPoint.y)
        {
            // Keep the possible turn point of the stroke
            _turnPoint = newPoint;
        }
        // Else if we change direction to the right and upwards
        else if (newPoint.x &gt;= prevPoint.x &amp;&amp; newPoint.y &lt;= prevPoint.y)
        {
            // Set the state to observe the second stroke
            _checkmarkState = CheckmarkSecondStrokeUp;
        }
        else
        {
            // In any other case the gesture will fail
            self.state = UIGestureRecognizerStateFailed;
        }
    }// Else we track the second stroke
    else if(_checkmarkState == CheckmarkSecondStrokeUp)
    {
        if(newPoint.x &lt; prevPoint.x)             self.state = UIGestureRecognizerStateFailed;     } } 
{
    // Set state to UIGestureRecognizerStateRecognized and
    // the gesture recognizer will call the defined action
    self.state = UIGestureRecognizerStateRecognized;
}
else
{
    self.state = UIGestureRecognizerStateFailed;
}
}*/
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    self.state = UIGestureRecognizerStateFailed;
}
// The gesture will fail if touch was cancelled
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    self.state = UIGestureRecognizerStateFailed;
}

@end
