//
//  CDCircleThumb.h
//  Wheel
//
//  Created by Wojciech Czekalski on 01.01.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDCircle.h"
#import "CDIconView.h"




@interface CDCircleThumb : UIView
{
    CGFloat numberOfSegments;
    CGFloat bigArcHeight;
    CGFloat smallArcWidth;
}
@property (assign, readonly) CGFloat sRadius;
@property (assign, readonly) CGFloat lRadius;
@property (assign, readonly) CGFloat yydifference;
@property (nonatomic, strong) UIBezierPath *arc;
@property (nonatomic, strong) UIColor *separatorColor;
@property (nonatomic, assign) CDCircleThumbsSeparator separatorStyle;
@property (nonatomic, assign) CGPoint centerPoint;
@property (nonatomic, strong) NSMutableArray * colorsLocations;
@property (nonatomic, strong) CDIconView *iconView;
@property (assign) BOOL gradientFill;
@property (nonatomic, strong) NSArray *gradientColors;
@property (nonatomic, strong) UIColor *arcColor;

-(id) initWithShortCircleRadius: (CGFloat) shortRadius longRadius: (CGFloat) longRadius numberOfSegments: (CGFloat) sNumber;

@end
