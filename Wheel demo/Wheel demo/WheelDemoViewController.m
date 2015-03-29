    //
//  WheelDemoViewController.m
//  Wheel demo
//
//  Created by Wojciech Czekalski on 01.05.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WheelDemoViewController.h"

@interface WheelDemoViewController ()
@property (weak, nonatomic) IBOutlet UIView *demoView;

@end

@implementation WheelDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(moved:)];
    
    [self.demoView addGestureRecognizer:rotationGestureRecognizer];
    self.demoView.userInteractionEnabled = YES;
}

- (void)moved:(UIRotationGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%f", gestureRecognizer.rotation);
    self.view.transform = CGAffineTransformMakeRotation(gestureRecognizer.rotation);
}

@end
