/*
 Copyright (C) <2012> <Wojciech Czelalski/CzekalskiDev>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#define kCDBorderAroundButton 3
#define degreesToRadians(x) (M_PI * x / 180.0)
#import "CDCircleOverlayView.h"
#import "CDCircle.h"

#import <QuartzCore/QuartzCore.h>

@implementation CDCircleOverlayView
@synthesize circle, controlPoint, buttonCenter, overlayThumb;
- (id)initWithCircle:(CDCircle *)cicle
{
    CGRect frame = cicle.frame;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = NO;
        self.circle = cicle;
        self.circle.overlayView = self;
        CGRect rect1 = CGRectMake(0, 0, CGRectGetHeight(self.circle.frame) - (2*circle.ringWidth), CGRectGetWidth(self.circle.frame) - (2*circle.ringWidth));
        rect1.origin.x = self.circle.frame.size.width / 2  - rect1.size.width / 2;
        rect1.origin.y = 0;

        
        overlayThumb = [[CDCircleThumb alloc] initWithShortCircleRadius:rect1.size.height/2 longRadius:self.circle.frame.size.height/2 numberOfSegments:self.circle.numberOfSegments];
        overlayThumb.gradientFill = NO;
        
        overlayThumb.layer.position = CGPointMake(CGRectGetWidth(frame)/2, circle.ringWidth/2);
        self.controlPoint = overlayThumb.layer.position;
        [self addSubview:overlayThumb];
        overlayThumb.arcColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.3f];
        self.buttonCenter = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(self.circle.frame));

              }

    return self;
}


-(BOOL) pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return NO;
    
}

-(void) setCenter:(CGPoint)center {
    [super setCenter:center];
    [self.circle setCenter:buttonCenter];
}

@end
