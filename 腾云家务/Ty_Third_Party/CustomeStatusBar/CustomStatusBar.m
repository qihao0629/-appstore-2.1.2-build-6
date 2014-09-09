//
//  CustomStatusBar.m
//  腾云家务
//
//  Created by 则卷同学 on 14-3-6.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "CustomStatusBar.h"

@implementation CustomStatusBar
@synthesize labMessage;
@synthesize topBar, overlayWindow, stringLabel;

- (id)initWithFrame:(CGRect)frame
{
    /*self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        //self.userInteractionEnabled = NO;
        self.frame = [UIApplication sharedApplication].statusBarFrame;
        self.backgroundColor = [UIColor clearColor];
        self.windowLevel = UIWindowLevelStatusBar + 1.0f;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }*/
    
    if ((self = [super initWithFrame:frame])) {
		self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
		self.alpha = 0;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

+ (void)showStatusMessage:(NSString *)message
{
    [[CustomStatusBar sharedView] showMessage:message];
}

+ (void)hide
{
    [[CustomStatusBar sharedView] hideMessage];
}

- (void)showMessage:(NSString *)message
{
    self.hidden = NO;
    self.alpha = 1.0f;
    labMessage.text = @"";
     
    CGSize totalSize = self.frame.size;
    self.frame = (CGRect){ self.frame.origin, 0, totalSize.height };
     
    [UIView animateWithDuration:0.5f animations:^{
        self.frame = (CGRect)
        {
            self.frame.origin, totalSize
        };
    }completion:^(BOOL finished){
        labMessage.text = message;
    }];
    [self setNeedsDisplay];
}

-(void)hideMessage
{
    self.alpha = 1.0f;
    
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 0.0f;
    }completion:^(BOOL finished){
        labMessage.text = @"";
        self.hidden = YES;
    }];
}

+ (CustomStatusBar*)sharedView {
    static dispatch_once_t once;
    static CustomStatusBar *sharedView;
    dispatch_once(&once, ^{
        sharedView = [[CustomStatusBar alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        //sharedView = [[CustomStatusBar alloc]initWithFrame:CGRectMake(MainFram.size.width*0.6, 0, MainFram.size.width*0.4, MainFram.size.height)];
    });
    return sharedView;
}

+ (void)showSuccessWithStatus:(NSString*)status
{
    [CustomStatusBar showWithStatus:status];
    [CustomStatusBar performSelector:@selector(dismiss) withObject:self afterDelay:2.0 ];
}

+ (void)showWithStatus:(NSString*)status {
    UIColor * color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"titleBar.png"]];
    if(IOS7)
        //[[CustomStatusBar sharedView] showWithStatus:status barColor:[UIColor colorWithRed:208.0/255.0 green:38.0/255.0 blue:31.0/255.0 alpha:1.0] textColor:[UIColor colorWithRed:191.0/255.0 green:191.0/255.0 blue:191.0/255.0 alpha:1.0]];
        //[[CustomStatusBar sharedView] showWithStatus:status barColor:[UIColor colorWithRed:208.0/255.0 green:38.0/255.0 blue:31.0/255.0 alpha:1.0] textColor:[UIColor whiteColor]];
        [[CustomStatusBar sharedView] showWithStatus:status barColor:color textColor:[UIColor whiteColor]];
    else
        [[CustomStatusBar sharedView] showWithStatus:status barColor:[UIColor blackColor] textColor:[UIColor whiteColor]];
}

+ (void)showErrorWithStatus:(NSString*)status {
    [[CustomStatusBar sharedView] showWithStatus:status barColor:[UIColor colorWithRed:97.0/255.0 green:4.0/255.0 blue:4.0/255.0 alpha:1.0] textColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]];
    [CustomStatusBar performSelector:@selector(dismiss) withObject:self afterDelay:2.0 ];
}

+ (void)dismiss {
    [[CustomStatusBar sharedView] dismiss];
}

- (void)showWithStatus:(NSString *)status barColor:(UIColor*)barColor textColor:(UIColor*)textColor{
    //if(!self.superview)
        //[self.overlayWindow addSubview:self];
    [self.overlayWindow setHidden:NO];
    [self.topBar setHidden:NO];
    self.topBar.backgroundColor = barColor;
    NSString *labelText = status;
    CGRect labelRect = CGRectZero;
    CGFloat stringWidth = 0;
    CGFloat stringHeight = 0;
    if(labelText) {
        CGSize stringSize = [labelText sizeWithFont:self.stringLabel.font constrainedToSize:CGSizeMake(self.topBar.frame.size.width, self.topBar.frame.size.height)];
        stringWidth = stringSize.width;
        stringHeight = stringSize.height;
        
        labelRect = CGRectMake((self.topBar.frame.size.width / 2) - (stringWidth / 2), 0, stringWidth, stringHeight);
    }
    self.stringLabel.frame = labelRect;
    self.stringLabel.alpha = 0.0;
    self.stringLabel.hidden = NO;
    self.stringLabel.text = labelText;
    self.stringLabel.textColor = textColor;
    [UIView animateWithDuration:0.4 animations:^{
        self.stringLabel.alpha = 1.0;
    }];
    
    [self setNeedsDisplay];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.4 animations:^{
        self.stringLabel.alpha = 0.0;
    } completion:^(BOOL finished) {
        [topBar removeFromSuperview];
        topBar = nil;
        
        [overlayWindow removeFromSuperview];
        overlayWindow = nil;
    }];
}

- (UIWindow *)overlayWindow {
    if(!overlayWindow) {
        overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayWindow.backgroundColor = [UIColor clearColor];
        overlayWindow.userInteractionEnabled = NO;
        overlayWindow.windowLevel = UIWindowLevelStatusBar;
    }
    return overlayWindow;
}

- (UIView *)topBar {
    if(!topBar) {
        //topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, overlayWindow.frame.size.width, 20.0)];
        topBar = [[UIView alloc] initWithFrame:CGRectMake(190, 0, 130, 20.0)];
        [overlayWindow addSubview:topBar];
    }
    return topBar;
}

- (UILabel *)stringLabel {
    if (stringLabel == nil) {
        stringLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		//stringLabel.textColor = [UIColor colorWithRed:191.0/255.0 green:191.0/255.0 blue:191.0/255.0 alpha:1.0];
        stringLabel.textColor = [UIColor whiteColor];
		stringLabel.backgroundColor = [UIColor clearColor];
		stringLabel.adjustsFontSizeToFitWidth = YES;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
        stringLabel.textAlignment = UITextAlignmentCenter;
#else
        stringLabel.textAlignment = NSTextAlignmentCenter;
#endif
		stringLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		stringLabel.font = [UIFont boldSystemFontOfSize:12.0];
		//stringLabel.shadowColor = [UIColor blackColor];
		//stringLabel.shadowOffset = CGSizeMake(0, -1);
        //stringLabel.numberOfLines = 0;
    }
    
    if(!stringLabel.superview)
        [self.topBar addSubview:stringLabel];
    
    return stringLabel;

}

@end
