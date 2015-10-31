/*
 Copyright (C) <2012> <Wojciech Czelalski/CzekalskiDev>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
#define kIconViewWidth 30
#define kIconViewHeight 30

#import "Common.h"
#import "CDCircleThumb.h"
#import <QuartzCore/QuartzCore.h>
@implementation CDCircleThumb
@synthesize sRadius, lRadius, yydifference, arc, separatorColor, separatorStyle, centerPoint;
@synthesize iconView;
@synthesize gradientFill, gradientColors, arcColor;
@synthesize colorsLocations;
- (id)initWithShortCircleRadius:(CGFloat)shortRadius longRadius:(CGFloat)longRadius numberOfSegments: (CGFloat) sNumber

{
    //Calculating suitable frame
        //Variables
    
    CGRect frame;
    
    CGFloat width;
    CGFloat height;
    //
    CGFloat fstartAngle = 270 - ((360/sNumber)/2);
    CGFloat fendAngle = 270 + ((360/sNumber)/2);
    //
    CGFloat startAngle = degreesToRadians(fstartAngle);
    CGFloat endAngle = degreesToRadians(fendAngle);
    
    
    UIBezierPath *bigArc = [UIBezierPath bezierPathWithArcCenter:CGPointMake(longRadius, longRadius) radius:longRadius startAngle:startAngle endAngle:endAngle clockwise:YES];
    UIBezierPath *smallArc = [UIBezierPath bezierPathWithArcCenter:CGPointMake(longRadius, longRadius) radius:shortRadius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
            // Start of calculations
    if ((fendAngle - fstartAngle) <= 180) {
            width = bigArc.bounds.size.width;
        height = smallArc.currentPoint.y ;
        frame = CGRectMake(0, 0, width, height);
    }
    if ((fendAngle - fstartAngle) > 269) {
        frame = CGRectMake(0, 0, bigArc.bounds.size.width, bigArc.bounds.size.height);
    }
            //End of calculations
    
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        sRadius = shortRadius;
        lRadius = longRadius;
        numberOfSegments = sNumber;
        CGFloat y = (lRadius - sRadius)/2.00;
        CGFloat xi = 0.5;
        CGFloat yi = y/frame.size.height;
        self.layer.anchorPoint = CGPointMake(xi, yi);
        self.gradientFill = YES;
        self.arcColor = [UIColor greenColor];
        self.centerPoint = CGPointMake(CGRectGetMidX(self.bounds), y);
        self.iconView = [[CDIconView alloc] initWithFrame:CGRectMake(CGRectGetMidX(frame), y, kIconViewWidth, kIconViewHeight)];
        self.iconView.center = CGPointMake(CGRectGetMidX(frame), y);
        [self addSubview:self.iconView];
        self.gradientColors =  [NSArray arrayWithObjects:(id)[UIColor blackColor].CGColor,(id)[UIColor grayColor].CGColor,  nil];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    [self.arcColor setStroke];
    [self.arcColor setFill];
    //Angles
    
    CGFloat clockwiseStartAngle = degreesToRadians((270 - ((360/numberOfSegments)/2)));
    CGFloat clockwiseEndAngle = degreesToRadians((270 + ((360/numberOfSegments)/2)));
    
    CGFloat nonClockwiseStartAngle = clockwiseEndAngle;
    CGFloat nonClockwiseEndAngle = clockwiseStartAngle;
    
    
    
    CGPoint center = CGPointMake(CGRectGetMidX(rect), lRadius);

    self.arc = [UIBezierPath bezierPathWithArcCenter: center radius:lRadius startAngle:clockwiseStartAngle endAngle:clockwiseEndAngle clockwise:YES];
    CGPoint f = arc.currentPoint;
    
        
    [arc addArcWithCenter:center radius:sRadius startAngle:nonClockwiseStartAngle endAngle:nonClockwiseEndAngle clockwise:NO];

    CGPoint e = arc.currentPoint;
    
    [arc closePath];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (self.gradientFill == NO) {
        [arc fill];
    }
    else {
    
        CGFloat la[[gradientColors count]];
    CGPathRef path = arc.CGPath;
        if ([gradientColors count] == 2) {
            la[0] = 0.00f;
            la[1] = 1.00f;
        }
        else 
        {
            
            if (!colorsLocations) {
                for (int i = [gradientColors count]-1; i >= 0; i--) {
                    float fi = [gradientColors count]-1;
                    float point = 1.00f/fi;
                    la[i] = point * i;            }
                

            }
            else {
                for (int i = 0; i < [colorsLocations count]; i++) {
                    
                    la[i] = [[colorsLocations objectAtIndex:i] floatValue];
                }
            }
        }
   
    
    
    
    drawLinearGradient(context, path, (__bridge CFArrayRef) self.gradientColors, CGGradientPositionHorizontal, la, rect);
    
    
    
    }
    
    
    [[UIColor lightGrayColor] setStroke];
    [[UIColor lightGrayColor] setFill];
    
    
    if (self.separatorStyle != CDCircleThumbsSeparatorNone) {
        UIBezierPath *line = [UIBezierPath bezierPath];
        if (separatorStyle == CDCircleThumbsSeparatorBasic) {
            line.lineWidth = 1.0f;
        }
       

    
    [line moveToPoint:f];
    [line addLineToPoint:CGPointMake(f.x - e.x, e.y)];
    [self.separatorColor setStroke];
    [self.separatorColor setFill];
                
    [line strokeWithBlendMode:kCGBlendModeCopy alpha:1.00f];
    [line fillWithBlendMode:kCGBlendModeCopy alpha:1.00f];
    }
}

-(BOOL) pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return NO;
}

@end
