//
//  CDSpinGestureRecognizer.m
//  CDPieMenu demo
//
//  Created by Wojciech Czekalski on 12.10.2014.
//
//

#import "CDSpinGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

static CGPoint CDCenterOfRect(CGRect rect)
{
  CGSize rectSize = rect.size;
  CGPoint center = CGPointMake(rectSize.width/2.f, rectSize.height/2.f);
  return center;
}

static CGFloat CDDistanceFromPointToPoint(CGPoint point1, CGPoint point2)
{
  return sqrt(pow((point1.x - point2.x), 2) + pow((point1.y - point2.y), 2));
}

@interface CDSpinGestureRecognizer ()
@property (nonatomic, assign) CGFloat rotation;
@end

@implementation CDSpinGestureRecognizer


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  [super touchesMoved:touches withEvent:event];
  
  CGPoint location = [[touches anyObject] locationInView:self.view];
  CGPoint previousLocation = [[touches anyObject] previousLocationInView:self.view];
  
  
}

- (void)setMaximumNumberOfTouches:(NSUInteger)maximumNumberOfTouches
{
  if (maximumNumberOfTouches <= 1) {
    [super setMaximumNumberOfTouches:maximumNumberOfTouches];
  } else {
    NSLog(@"%@: Invalid number of maximum touches set: %lu", self, (unsigned long)maximumNumberOfTouches);
  }
}

- (NSUInteger)maximumNumberOfTouches
{
  return 1;
}

- (void)reset
{
  [super reset];
  
  self.rotation = 0.f;
}

@end
