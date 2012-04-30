//
//  Common.h
//  CoreGraphics1
//
//  Created by Wojciech Czekalski on 24.12.2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define degreesToRadians(x) (M_PI * (x) / 180.0)
#define radiansToDegrees(x) ((x) / M_PI * 180)


@interface Common : NSObject



typedef enum {
    CGGradientPositionVertical = 1,
    CGGradientPositionHorizontal
} CGGradientPosition;

void drawLinearGradient(CGContextRef context, CGPathRef  path, CFArrayRef colors, CGGradientPosition position, CGFloat locations[], CGRect rect);

CGRect rectFor1PxStroke(CGRect rect);
@end
