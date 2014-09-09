//
//  Ty_CustomDatePicker.m
//  腾云家务
//
//  Created by 齐 浩 on 14-7-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_CustomDatePicker.h"


#define kDuration 0.3
#define HourArray @[@"00点",@"01点",@"02点",@"03点",@"04点",@"05点",@"06点",@"07点",@"08点",@"09点",@"10点",@"11点",@"12点",@"13点",@"14点",@"15点",@"16点",@"17点",@"18点",@"19点",@"20点",@"21点",@"22点",@"23点"]
@implementation Ty_CustomDatePicker
{
    UIPickerView *dayPicker;
    
    NSMutableArray *dayArray;
    NSMutableArray *hourArray;
    NSMutableArray *minArray;
    
    UIView* showView;
}
@synthesize titleLabel;
@synthesize customDate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        
    }
    return self;
}
-(void)initData
{
    customDate = [[CustomDate alloc]init];
    
    dayArray = [[NSMutableArray alloc] init];
    hourArray = [[NSMutableArray alloc] init];
    minArray = [[NSMutableArray alloc] init];
    NSDate * ty_date = [NSDate date];
    
    NSDateFormatter* dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"MM月dd日"];
    
    NSDateFormatter* dateformatter2 = [[NSDateFormatter alloc]init];
    [dateformatter2 setDateFormat:@"HH"];
    
    if (![[dateformatter2 stringFromDate:ty_date] isEqualToString:@"23"]) {
        [dayArray addObject:@"今天"];
    }
    [dayArray addObject:@"明天"];
    [dayArray addObject:@"后天"];
    
    for (int i = 3; i <7; i++) {
        [dayArray addObject:[NSString stringWithFormat:@"%@",
                             [dateformatter stringFromDate:[ty_date dateByAddingTimeInterval:(3600*24*i)]]]];
    }
    [hourArray setArray:HourArray];
    
    [minArray addObjectsFromArray:@[@"00分",@"30分"]];
    if (![[dateformatter2 stringFromDate:ty_date] isEqualToString:@"23"]) {
        customDate.dayStr = dayArray[1];
    }else{
        customDate.dayStr = dayArray[0];
    }
    customDate.hourStr = hourArray[10];
    customDate.minStr = minArray[0];
    
}

- (id)initWithTitle:(NSString *)title delegate:(id /*<UIActionSheetDelegate>*/)delegate
{
    self = [super init];
    if (self) {
        [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 260)];
        
        self.delegate = delegate;
        
        [self initData];
        
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
        
        dayPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 216)];
        [dayPicker setAlpha:1.0f];
        dayPicker.delegate = self;
        dayPicker.dataSource = self;
        [dayPicker setBackgroundColor:[UIColor whiteColor]];
        if ([dayArray[0] isEqualToString:@"今天"]) {
            [dayPicker selectRow:1 inComponent:0 animated:NO];
        }
        [dayPicker selectRow:10 inComponent:1 animated:NO];
        
        [self addSubview:dayPicker];
        
        if (IOS7) {
            showView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH,SCREEN_HEIGHT)];
        }else{
            showView = [[UIView alloc]initWithFrame:CGRectMake(0, -44, SCREEN_WIDTH,SCREEN_HEIGHT)];
        }
        
        [showView setBackgroundColor:[UIColor grayColor]];
    }
    
    return self;
}





- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return dayArray.count;
            break;
        case 1:
            return hourArray.count;
            break;
        case 2:
            return minArray.count;
            break;
        default:
            return 0;
            break;
    }
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return dayArray[row];
            break;
        case 1:
            return hourArray[row];
            break;
        case 2:
            return minArray[row];
            break;
        default:
            return nil;
            break;
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            if ([dayArray[row] isEqualToString:@"今天"]) {
                
                [hourArray setArray:HourArray];
                
                NSDate * ty_date = [NSDate date];
                
                NSDateFormatter* dateformatter = [[NSDateFormatter alloc]init];
                [dateformatter setDateFormat:@"HH点"];
                
                while (![[dateformatter stringFromDate:ty_date] isEqualToString:hourArray[0]]) {
                    [hourArray removeObjectAtIndex:0];
                }
                [hourArray removeObjectAtIndex:0];
            }else{
                [hourArray setArray:HourArray];
            }
            
            customDate.dayStr = dayArray[row];
            customDate.hourStr = hourArray[0];
            customDate.minStr = minArray[0];
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            
            break;
        case 1:
            customDate.hourStr = hourArray[row];
            customDate.minStr = minArray[0];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            
            break;
        case 2:
            customDate.minStr = minArray[row];
            break;
        default:
            break;
    }
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
    
    UILabel *myView = nil;
    switch (component) {
        case 0:
            myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 140, 30)];
            
            myView.textAlignment = UITextAlignmentCenter;
            
            myView.text = dayArray[row];
            
            myView.font = FONT18_SYSTEM;         //用label来设置字体大小
            
            myView.backgroundColor = [UIColor clearColor];
            break;
        case 1:
            myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 90, 30)];
            
            myView.textAlignment = UITextAlignmentCenter;
            
            myView.text = hourArray[row];
            
            myView.font = FONT18_SYSTEM;         //用label来设置字体大小
            
            myView.backgroundColor = [UIColor clearColor];
            break;
        case 2:
            myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 90, 30)];
            
            myView.textAlignment = UITextAlignmentCenter;
            
            myView.text = minArray[row];
            
            myView.font = FONT18_SYSTEM;         //用label来设置字体大小
            
            myView.backgroundColor = [UIColor clearColor];
            break;
        default:
            break;
    }
    return myView;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return 140;
            break;
        case 1:
            return 90;
            break;
        case 2:
            return 90;
            break;
        default:
            return 0;
            break;
    }
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
    
    
    NSDate *ty_date = [NSDate date];
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    
    if ([dayArray[0] isEqualToString:@"今天"]) {
        [customDate.dateString appendFormat:@"%@",[dateformatter stringFromDate:[ty_date dateByAddingTimeInterval:(3600*24*[dayArray indexOfObject:customDate.dayStr])]]];
    }else{
        [customDate.dateString appendFormat:@"%@",[dateformatter stringFromDate:[ty_date dateByAddingTimeInterval:(3600*24*([dayArray indexOfObject:customDate.dayStr]+1))]]];
    }
    [customDate.dateString appendFormat:@" %@",[customDate.hourStr substringToIndex:2]];
    [customDate.dateString appendFormat:@":%@",[customDate.minStr substringToIndex:2]];
    
    NSLog(@"%@,%@,%@",customDate.dayStr,customDate.hourStr,customDate.minStr);
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
