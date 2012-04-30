/*
 Copyright (C) <2012> <Wojciech Czelalski/CzekalskiDev>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
#import <UIKit/UIKit.h>

typedef enum {
    CDCircleThumbsSeparatorNone,
    CDCircleThumbsSeparatorBasic
}CDCircleThumbsSeparator;

@class CDCircle, CDCircleThumb, CDCircleOverlayView;
@protocol CDCircleDelegate <NSObject> 
@required
-(void) circle: (CDCircle *) circle didMoveToSegment:(NSInteger) segment thumb: (CDCircleThumb *) thumb;

@end
@protocol CDCircleDataSource <NSObject>
-(UIImage *) circle: (CDCircle *) circle iconForThumbAtRow: (NSInteger) row;

@end
@class CDCircleGestureRecognizer;

@interface CDCircle : UIView
@property (nonatomic, strong) NSMutableArray *thumbs;
@property (nonatomic, strong) UIBezierPath *circle;
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, assign) BOOL inertiaeffect;
@property (nonatomic, strong) CDCircleGestureRecognizer *recognizer;
@property (assign) int numberOfSegments;
@property (nonatomic, strong) UIColor *separatorColor;
@property (nonatomic, assign) CDCircleThumbsSeparator separatorStyle;
@property (nonatomic, strong) CDCircleOverlayView *overlayView;
@property (nonatomic, assign) CGFloat ringWidth;
@property (nonatomic, assign) BOOL overlay;

@property (nonatomic, strong) id <CDCircleDelegate> delegate;
@property (nonatomic, strong) id <CDCircleDataSource> dataSource;

@property (nonatomic, strong) UIColor *circleColor;

-(id) initWithFrame:(CGRect)frame numberOfSegments: (NSInteger) nSegments ringWidth: (CGFloat) width;

@end