//
//  CustomStatusBar.h
//  腾云家务
//
//  Created by 则卷同学 on 14-3-6.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomStatusBar : UIWindow
{
}
@property(nonatomic,assign)UILabel *labMessage;
+ (void)showStatusMessage:(NSString *)message;
+ (void)hide;
-(void)showMessage:(NSString *)message;
-(void)hideMessage;
@property (nonatomic, strong, readonly) UIWindow *overlayWindow;
@property (nonatomic, strong, readonly) UIView *topBar;
@property (nonatomic, strong) UILabel *stringLabel;
+ (void)showWithStatus:(NSString*)status;
+ (void)showErrorWithStatus:(NSString*)status;
+ (void)showSuccessWithStatus:(NSString*)status;
+ (void)dismiss;

@end
