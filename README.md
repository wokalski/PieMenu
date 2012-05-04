CDPieMenu
=========
![CDPieMenu](http://i50.tinypic.com/ej2vd.png "Standard CDPieMenu")


View Hierarchy
--------------
* CDCircle - is UIView subclass. It's, let's say, the base of a CDPieMenu. It's a circle drawn using CoreGraphics/QuartzCore.

* CDCircleThumb - UIView subclass, is a single segment in a CDPieMenu. It's subview of a CDCircle. Highly customisable. More information about modifying a thumb is listed below.

* CDIconView - UIImageView subclass, it handles colouring of an icon. CDIconView is subview of a CDCircleThumb.

* CDCircleOverlayView - this is independent view outside of the main view hierarchy. It handles selection of a thumb. It cannot be subview of a CDCircle because then, it would turn around with a circle.

Methods
-------
###CDCircle
* -(id)initWithFrame:(CGRect) frame numberOfSegments:(NSUInteger) nSegments ringWidth:(CGFloat) ringWidth

####Delegate:

* -(void) circle:(CDCircle *)circle didMoveToSegment:(NSInteger)segment thumb:(CDCircleThumb *)thumb

####Data source:

* -(UIImage *) circle:(CDCircle *)circle iconForThumbAtRow:(NSInteger)row 

###CDCircleOverlayView
* -(id) initWithCircle:(CDCircle) circle

Properties
----------

###CDCircle:
* dataSource - data source of CDPieMenu.
* delegate - delegate of CDPieMenu
* (UIColor *) circleColor - Set this property to change color of a circle. It may be usable when you want to achieve specyfic effect (e.g. semi transparent thumbs, and coloured circle will create some effect)
* (NSArray *) thumbs - all thumbs.
* (CDCircleOverlayView *) overlayView - a pointer to CDCircleOverlayView


###CDCircleThumb:
* (CDIconView *)iconView - a pointer to thumb's CDIconView
* (UIColor *)separatorColor - color of a separator
* separatorStyle - it can be CDCircleThumbsSeparatorNone or CDCircleThumbsSeparatorBasic. Style of a separator.
* (BOOL)gradientFill - If gradientFill is set to NO, a thumb is coloured with solid color
* (NSArray *) gradientColors - colors of thumb's gradient.
* (NSArray *) colorsLocations - locations of colors in a gradient
* (UIColor *) arcColor - if gradientFill is set to 'NO' we can set thumb's color using this property.


###CDIconView:
* highlitedIconColor - color of an image when a thumb is selected

###CDCircleOverlayView:
* overlayThumb - pointer to a thumb which is the selector (central thumb)


Samples
-------
Use this code to implement standard CDPieMenu:

     CDCircle *circle = [[CDCircle alloc] initWithFrame:CGRectMake(10 , 90, 300, 300) numberOfSegments:6 ringWidth:80.f];
    circle.dataSource = self;
    circle.delegate = self;
    CDCircleOverlayView *overlay = [[CDCircleOverlayView alloc] initWithCircle:circle];
    [self.view addSubview:circle];
    //Overlay cannot be subview of a circle because then it would turn around with the circle
    [self.view addSubview:overlay];



![CDPieMenu](http://i46.tinypic.com/28bcrvm.png "Customized overlay thumb")

Code used to achieve effect shown above :

    circle.overlayView.overlayThumb.arcColor = [UIColor colorWithRed:0.00f green:1.00f blue:0.25f alpha:0.4];

![CDPieMenu](http://i50.tinypic.com/25pjy8n.png "Customized thumbs")

Code used to achieve effect shown above :

    for (CDCircleThumb *thumb in circle.thumbs) {
    [thumb.iconView setHighlitedIconColor:[UIColor redColor]];
     thumb.separatorColor = [UIColor whiteColor];
     thumb.separatorStyle = CDCircleThumbsSeparatorBasic;
     thumb.gradientFill = NO;
     thumb.arcColor = [UIColor greenColor];
     
      }



How to use CDPieMenu
--------------------
In order to use CDPieMenu add following frameworks to your project:
* CoreGraphics
* QuartzCore

License
-------
CDPieMenu is licensed under MIT license


CDPieMenu has been mentioned on:
------------------------
* [Maniacdev](ManiacDev.com)
* [iOSDeveloperTips](iOSDeveloperTips.com)

**Thank you guys for promotion**


About me
========

If you have got any question, feel free to mail me, my email address is: wczekalski@me.com
---------------------------------------------------------------------------------
I want to hear from you if you use my code in your app. Just mail me with a link to the AppStore
------------------------------------------