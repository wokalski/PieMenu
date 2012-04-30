//
//  CDCircleOverlayView.h
//  Wheel
//
//  Created by Wojciech Czekalski on 05.01.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDCircle.h"
#import "CDCircleThumb.h"
@interface CDCircleOverlayView : UIView {
    CDCircleThumb  *overlayThumb;
}
@property (nonatomic, strong) CDCircle *circle;
@property (nonatomic, assign) CGPoint controlPoint;
@property (nonatomic, assign) CGPoint buttonCenter;
@property (nonatomic, strong) CDCircleThumb *overlayThumb;

-(id) initWithCircle: (CDCircle *) cicle;

@end
