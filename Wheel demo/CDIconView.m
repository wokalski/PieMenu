//
//  CDIconView.m
//  Wheel
//
//  Created by Wojciech Czekalski on 07.01.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CDIconView.h"

@implementation CDIconView
@synthesize image, selected, highlitedIconColor;

-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        selected = NO;
        self.opaque =NO;
        self.backgroundColor = [UIColor clearColor];
        self.highlitedIconColor = [UIColor colorWithRed:0.75 green:0.00f blue:0.00f alpha:1.00f];
    }
    return self;
}

-(void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (image != nil) {
    if (selected == YES) {
    CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(context, 0, image.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, kCGBlendModeColor);
        CGContextClipToMask(context, self.bounds, image.CGImage); // this restricts drawing to within alpha channel
        CGContextSetFillColorWithColor(context, self.highlitedIconColor.CGColor); // this is your color,  a light reddish tint
        
        CGContextFillRect(context, rect);
        
    }
    else {[image drawInRect:rect];}
    }

}
-(void) setIsSelected:(BOOL)isSelected {
    if (selected != isSelected) {
        selected = isSelected;
        [self setNeedsDisplay];
    }
    else return;
}


@end
