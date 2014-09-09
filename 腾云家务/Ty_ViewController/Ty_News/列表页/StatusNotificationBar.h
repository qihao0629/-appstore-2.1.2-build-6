//
//  StatusNotificationBar.h
//  腾云家务
//
//  Created by liu on 14-7-7.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusNotificationBar : UIWindow
{
    UILabel *_notificationMsgLabel;
    
    NSInteger _messageNum;
    
    NSTimer *_timer;
    
    UIView *_bgView;
    
}

+ (StatusNotificationBar *)shareNotificationBar;

- (void)showStatusMessage:(NSString *)message;
- (void)hide;
- (void)changeMessge:(NSString *)message;

- (void)fullStatueBar;


@end
