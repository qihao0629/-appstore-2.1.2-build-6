//
//  StatusNotificationBar.m
//  腾云家务
//
//  Created by liu on 14-7-7.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "StatusNotificationBar.h"


@implementation StatusNotificationBar

static StatusNotificationBar *_shareNotificationBar = nil;

+ (StatusNotificationBar *)shareNotificationBar
{
    if (_shareNotificationBar == nil)
    {
        _shareNotificationBar = [[StatusNotificationBar alloc]init];
    }
    
    return _shareNotificationBar;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = UIWindowLevelNormal;
        self.windowLevel = UIWindowLevelStatusBar + 1.0f;
		self.frame = [UIApplication sharedApplication].statusBarFrame;
        self.backgroundColor = [UIColor clearColor];
        self.hidden = NO;
        
        
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, 320, 20)];
        _bgView.backgroundColor = [UIColor clearColor];
        [self addSubview:_bgView];
        _bgView.hidden = YES;
        
        _notificationMsgLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        _notificationMsgLabel.backgroundColor = [UIColor clearColor];
        _notificationMsgLabel.font = [UIFont systemFontOfSize:14];
        _notificationMsgLabel.textAlignment = UITextAlignmentRight;
        _notificationMsgLabel.font = [UIFont boldSystemFontOfSize:13];
        _notificationMsgLabel.textColor = [UIColor colorWithWhite:0.2 alpha:1];
        _notificationMsgLabel.clipsToBounds = YES;
        
        [_bgView addSubview:_notificationMsgLabel];
        
        _messageNum = 0;
        
       // [self.window addSubview:self];
     
    }
    return self;
}

- (void)showStatusMessage:(NSString *)message
{
    //_messageNum += 2;
    
    if (message.length > 0 && IFLOGINYES)
    {
        self.hidden = NO;
        
        if (_bgView.hidden)
        {
            _bgView.hidden = NO;
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^
             {
                 _bgView.alpha = 1;
                 _bgView.transform = CGAffineTransformMakeTranslation(0, -10);
                 
             }completion:^(BOOL finished)
             {
                 if (IOS7)
                 {
                     _bgView.backgroundColor = [UIColor colorWithRed:219.0/255 green:34.0/255 blue:21.0/255 alpha:1.0];
                 }
                 else
                 {
                     _bgView.backgroundColor = [UIColor  blackColor];
                 }
                 
                 _notificationMsgLabel.textColor = [UIColor whiteColor];
                 _notificationMsgLabel.text = message;
             }];
            
            
        }
        else
        {
            _notificationMsgLabel.text = message;
        }
        
        
        //NSLog(@"%d",_timer.isValid);
        if (_timer.isValid && _timer != nil)
        {
            [_timer invalidate];
            _timer = nil;
        }
        // NSLog(@"%d",_timer.isValid);
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(dismiss) userInfo:nil repeats:NO];
    }
    
    
    
   // [self performSelector:@selector(update) withObject:nil afterDelay:2];

    
}

- (void)update
{
    if (_timer.isValid && _timer != nil)
    {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(dismiss) userInfo:nil repeats:NO];
   // [_timer fire];
}

- (void)dismiss
{
    [_timer invalidate];
    
    if (!IOS7)
    {
        _bgView.backgroundColor = [UIColor clearColor];
    }
    
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^
     {
         
         _bgView.transform = CGAffineTransformMakeTranslation(0, 0);
         _bgView.alpha = 0;
         
     }completion:^(BOOL finished)
     {
         self.hidden = YES;
         _bgView.hidden = YES;
         _notificationMsgLabel.text = @"";
         _messageNum = 0;
         
     }];
  
    //UIDevice
    
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
