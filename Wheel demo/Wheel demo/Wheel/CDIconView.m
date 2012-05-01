/*
 Copyright (C) <2012> <Wojciech Czelalski/CzekalskiDev>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

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
