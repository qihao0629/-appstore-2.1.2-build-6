//
//  CustomDatePicker.m
//  腾云家务
//
//  Created by 齐 浩 on 13-10-11.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "CustomDatePicker.h"
#import <QuartzCore/QuartzCore.h>
#define kDuration 0.3
@implementation CustomDatePicker
//@synthesize dateformatter;
@synthesize titleLabel;
@synthesize datePicker;
@synthesize dateNow;
@synthesize showView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}
- (id)initWithTitle:(NSString *)title delegate:(id /*<UIActionSheetDelegate>*/)delegate
{
    self = [super init];
    if (self) {
        [self setFrame:CGRectMake(0, 0, 320, 260)];
        UIImageView* titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        [titleImage setImage:JWImageName(@"bg_023")];
        [titleImage setUserInteractionEnabled:YES];
        [self addSubview:titleImage];
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 11, 320, 21)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextColor:[UIColor blackColor]];
        [titleLabel setFont:FONT12_SYSTEM];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setText:title];
        [self addSubview:titleLabel];
    
        UIButton* cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(8, 6, 55, 32)];
//        [cancelButton setBackgroundImage:JWImageName(@"btn_020") forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
//        [cancelButton setFont:FONT12_SYSTEM];
        [cancelButton.titleLabel setFont:FONT14_SYSTEM];
        [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
        
        UIButton* qudingButton = [[UIButton alloc]initWithFrame:CGRectMake(258, 6, 55, 32)];
//        [qudingButton setBackgroundImage:JWImageName(@"btn_020") forState:UIControlStateNormal];
        [qudingButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [qudingButton setTitle:@"确定" forState:UIControlStateNormal];
//        [qudingButton setFont:FONT12_SYSTEM];
        [qudingButton.titleLabel setFont:FONT14_SYSTEM];
        [qudingButton addTarget:self action:@selector(locate:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:qudingButton];
        
        datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 44, 320, 216)];
        [datePicker setAlpha:1.0f];
        [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
        [datePicker setBackgroundColor:[UIColor whiteColor]];
        
        self.delegate = delegate;
        
        [self.datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        
        self.datePicker.timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
        
        [self addSubview:datePicker];
        
        //加载数据
        
        self.dateNow = [[CustomDate alloc] init];
        
        if (IOS7) {
            showView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH,SCREEN_HEIGHT)];
        }else{
            showView = [[UIView alloc]initWithFrame:CGRectMake(0, -44, SCREEN_WIDTH,SCREEN_HEIGHT)];
        }
        
        [showView setBackgroundColor:[UIColor grayColor]];
    }
    return self;
}
-(void)setDatePickerMode:(UIDatePickerMode*)_datepickerMode
{
    [datePicker setDatePickerMode:_datepickerMode];
}

- (void)showInView:(UIView *) view
{
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [showView setAlpha:0.5f];
    [self setAlpha:1.0f];
    [self.layer addAnimation:animation forKey:@"DDDatePickerView"];
    if (IOS7) {
        self.frame = CGRectMake(0, SCREEN_HEIGHT - self.frame.size.height-44, self.frame.size.width, self.frame.size.height);
    }else{
        self.frame = CGRectMake(0, SCREEN_HEIGHT - self.frame.size.height-64, self.frame.size.width, self.frame.size.height);
    }
//    [showView setBackgroundColor:[UIColor blackColor]];
    
    [view addSubview:showView];
    [view addSubview:self];

}
-(void)cancel:(id)sender {
    
    CATransition *animation = [CATransition  animation];
    
    animation.delegate = self;
    
    animation.duration = kDuration;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    animation.type = kCATransitionPush;
    
    animation.subtype = kCATransitionFromBottom;
    
    [self setAlpha:0.0f];
    [showView setAlpha:0.0f];
    
    [self.layer addAnimation:animation forKey:@"TSDatePickerView"];
    
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
    
    [showView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
    
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:0];
    }
}

- (void)locate:(id)sender {
   self.dateNow.date = datePicker.date;
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [showView setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"TSDatePickerView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
    [showView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:1];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
