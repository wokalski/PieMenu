//
//  CDIconView.h
//  Wheel
//
//  Created by Wojciech Czekalski on 07.01.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDIconView : UIView
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign, setter = setIsSelected:) BOOL selected;
@property (nonatomic, strong) UIColor *highlitedIconColor;
-(void) setIsSelected:(BOOL)isSelected; 

@end
