/*
 Copyright (C) <2012> <Wojciech Czelalski/CzekalskiDev>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#define deceleration_multiplier 30.0f

#import <QuartzCore/QuartzCore.h>
#import "CDCircleGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "CDCircle.h"
#import "CDCircleThumb.h"
#import <AudioToolbox/AudioServices.h>
#import "CDCircleOverlayView.h"
#import "Common.h"


@implementation CDCircleGestureRecognizer

@synthesize rotation = rotation_, controlPoint;
@synthesize ended;
@synthesize currentThumb;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CDCircle *view = (CDCircle *) [self view];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:view];
    
   // Fail when more than 1 finger detected.
   if ([[event touchesForGestureRecognizer:self] count] > 1 || ([view.path containsPoint:point] == YES )) {
      [self setState:UIGestureRecognizerStateFailed];
   }
    self.ended = NO;
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
   if ([self state] == UIGestureRecognizerStatePossible) {
      [self setState:UIGestureRecognizerStateBegan];
   } else {
      [self setState:UIGestureRecognizerStateChanged];
   }

   // We can look at any touch object since we know we 
   // have only 1. If there were more than 1 then 
   // touchesBegan:withEvent: would have failed the recognizer.
   UITouch *touch = [touches anyObject];

   // To rotate with one finger, we simulate a second finger.
   // The second figure is on the opposite side of the virtual
   // circle that represents the rotation gesture.

    CDCircle *view = (CDCircle *) [self view];
   CGPoint center = CGPointMake(CGRectGetMidX([view bounds]), CGRectGetMidY([view bounds]));
   CGPoint currentTouchPoint = [touch locationInView:view];
   CGPoint previousTouchPoint = [touch previousLocationInView:view];
    previousTouchDate = [NSDate date];
    CGFloat angleInRadians = atan2f(currentTouchPoint.y - center.y, currentTouchPoint.x - center.x) - atan2f(previousTouchPoint.y - center.y, previousTouchPoint.x - center.x);
   [self setRotation:angleInRadians];
    currentTransformAngle = atan2f(view.transform.b, view.transform.a);
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
   // Perform final check to make sure a tap was not misinterpreted.
   if ([self state] == UIGestureRecognizerStateChanged) {
    
       
       CDCircle *view = (CDCircle *) [self view];
       CGFloat flipintime = 0;
       CGFloat angle = 0;
       if (view.inertiaeffect == YES) {
           CGFloat angleInRadians = atan2f(view.transform.b, view.transform.a) - currentTransformAngle;
           double time = [[NSDate date] timeIntervalSinceDate:previousTouchDate];
           double velocity = angleInRadians/time;
           CGFloat a = deceleration_multiplier;
           
            flipintime = fabs(velocity)/a; 
           
           
           
            angle = (velocity*flipintime)-(a*flipintime*flipintime/2);
           
           if (angle>M_PI/2 || (angle<0 && angle<-1*M_PI/2)) {
               if (angle<0) {
                   angle =-1 * M_PI/2.1f;
               }    
               else { angle = M_PI/2.1f; }
               
               flipintime = 1/(-1*(a/2*velocity/angle));
           }

       }
       
       
              
       [UIView animateWithDuration:flipintime delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
           [view setTransform:CGAffineTransformRotate(view.transform,angle)];

       } completion:^(BOOL finished) {
           for (CDCircleThumb *thumb in view.thumbs) {
               
               
               CGPoint point = [thumb convertPoint:thumb.centerPoint toView:nil];
               CDCircleThumb *shadow = view.overlayView.overlayThumb;
               CGRect shadowRect = [shadow.superview convertRect:shadow.frame toView:nil];
               
               if (CGRectContainsPoint(shadowRect, point) == YES) {
                   CGPoint pointInShadowRect = [thumb convertPoint:thumb.centerPoint toView:shadow];
                   if (CGPathContainsPoint(shadow.arc.CGPath, NULL, pointInShadowRect, NULL)) {
                       CGAffineTransform current = view.transform;
                   
                       
                    CGFloat deltaAngle= - degreesToRadians(180) + atan2(view.transform.a, view.transform.b) + atan2(thumb.transform.a, thumb.transform.b);

                       
                        [UIView animateWithDuration:0.2f animations:^{
                       [view setTransform:CGAffineTransformRotate(current, deltaAngle)];
                        }];
                       
                       
                       
                       
                       

                       SystemSoundID soundID;
                       NSString *filePath = [[NSBundle mainBundle] pathForResource:@"iPod Click" ofType:@"aiff"];
                       
                       NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
                       AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileUrl, &soundID);
                       AudioServicesPlaySystemSound(soundID);
                       
                       [currentThumb.iconView setIsSelected:NO];
                       [thumb.iconView setIsSelected:YES];
                       self.currentThumb = thumb;
                       //Delegate method
                       [view.delegate circle:view didMoveToSegment:thumb.tag thumb:thumb];
                       self.ended = YES;
                       break;
                   }
                   
               }            
           }
;
       }];


       currentTransformAngle = 0;
       
       
              
     [self setState:UIGestureRecognizerStateEnded];  
       
   } else {
       
       CDCircle *view = (CDCircle *)[self view];
       UITouch *touch = [touches anyObject];
       
       for (CDCircleThumb *thumb in view.thumbs) {
           
           CGPoint touchPoint = [touch locationInView:thumb];
           if (CGPathContainsPoint(thumb.arc.CGPath, NULL, touchPoint, NULL)) {
               
               CGFloat deltaAngle= - degreesToRadians(180) + atan2(view.transform.a, view.transform.b) + atan2(thumb.transform.a, thumb.transform.b);
               CGAffineTransform current = view.transform;
               [UIView animateWithDuration:0.3f animations:^{
                   [view setTransform:CGAffineTransformRotate(current, deltaAngle)];
               } completion:^(BOOL finished) {
                   
                   SystemSoundID soundID;
                   NSString *filePath = [[NSBundle mainBundle] pathForResource:@"iPod Click" ofType:@"aiff"];
                   
                   NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
                   AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileUrl, &soundID);
                   AudioServicesPlaySystemSound(soundID);
                   
                   [currentThumb.iconView setIsSelected:NO];
                   [thumb.iconView setIsSelected:YES];
                   self.currentThumb = thumb;
                   //Delegate method
                   [view.delegate circle:view didMoveToSegment:thumb.tag thumb:thumb];
                   self.ended = YES;
                   
               }];
               
               break;
           }
           
       }
       
       [self setState:UIGestureRecognizerStateFailed];
   }
}



- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
   [self setState:UIGestureRecognizerStateFailed];
}
@end
