//
//  CDWheelViewController.m
//  Wheel
//
//  Created by Wojciech Czekalski on 30.12.2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CDWheelViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CDCircle.h"
#import "CDCircleOverlayView.h"
#import "CDIconView.h"
@implementation CDWheelViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    CDCircle *circle = [[CDCircle alloc] initWithFrame:CGRectMake(10 , 90, 300, 300) numberOfSegments:6 ringWidth:80.f];
    circle.dataSource = self;
    circle.delegate = self;
    CDCircleOverlayView *overlay = [[CDCircleOverlayView alloc] initWithCircle:circle];


    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
//Set this property to change color of the overlay thumb (by default it's light gray with alpha set to 0.3f
  
    // circle.overlayView.overlayThumb.arcColor = [UIColor colorWithRed:0.00f green:1.00f blue:0.25f alpha:0.4];
  
//Set this property to change color of a circle. It may be usable when you want to achieve specyfic effect (e.g. semi transparent thumbs, and coloured circle will create some effect
    
    // circle.circleColor = [UIColor yellowColor];
    
    
    

//To modify single thumb, take it's pointer as follows "[circle.thumbs objectAtIndex:x];" and then  you can set it's properties
    
    
    /*
    
     CDCircleThumb *thumb = [circle.thumbs objectAtIndex:0];
     
     
     //Color of a highlited icon on thumb
     [thumb.iconView setHighlitedIconColor:[UIColor blueColor]];
     //Color of the separator
     thumb.separatorColor = [UIColor redColor];
     //Separator style may be basic and None
     thumb.separatorStyle = CDCircleThumbsSeparatorNone;
     //If gradientFill is set to NO, a thumb is coloured with solid color
     thumb.gradientFill = YES;
     //Colors of a gradient
     thumb.gradientColors = [NSArray arrayWithObjects:(id) [UIColor whiteColor].CGColor, (id) [UIColor yellowColor].CGColor, (id) [UIColor cyanColor].CGColor, nil];
     //If you omit locations of colors, colors will be placed symmetrical
     thumb.colorsLocations = [NSMutableArray arrayWithObjects:[NSNumber numberWithFloat:0.00f], [NSNumber numberWithFloat:0.30f], [NSNumber numberWithFloat:1.00f], nil];
    
    
*/
    
    
    
    
//To modify all thumbs, simply iterate through them and change their properties.
    /*
      for (CDCircleThumb *thumb in circle.thumbs) {
       [thumb.iconView setHighlitedIconColor:[UIColor redColor]];
     thumb.separatorColor = [UIColor blackColor];
     thumb.separatorStyle = CDCircleThumbsSeparatorBasic;
     thumb.gradientFill = NO;
     thumb.arcColor = [UIColor redColor];
     thumb.gradientColors = [NSArray arrayWithObjects:(id) [UIColor blackColor].CGColor, (id) [UIColor yellowColor].CGColor, (id) [UIColor blueColor].CGColor, nil];
     thumb.colorsLocations = [NSMutableArray arrayWithObjects:[NSNumber numberWithFloat:0.00f], [NSNumber numberWithFloat:0.30f], [NSNumber numberWithFloat:1.00f], nil];
    
       }
*/
    
    [self.view addSubview:circle];
    //Overlay cannot be subview of a circle because then it would turn around with the circle
   [self.view addSubview:overlay];
    
   
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark - Circle delegate & data source

-(void) circle:(CDCircle *)circle didMoveToSegment:(NSInteger)segment thumb:(CDCircleThumb *)thumb {
    
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"User did select item" message:[NSString stringWithFormat:@"Segment's tag: %i", segment] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
   [alert show];
    
    
}

-(UIImage *) circle:(CDCircle *)circle iconForThumbAtRow:(NSInteger)row {
    NSString *fileString = [[[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:nil] lastObject];
    
    return [UIImage imageWithContentsOfFile:fileString];
    
}



@end
