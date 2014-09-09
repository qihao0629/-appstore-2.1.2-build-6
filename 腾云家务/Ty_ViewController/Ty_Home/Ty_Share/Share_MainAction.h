//
//  Share_MainAction.h
//  腾云家务
//
//  Created by 齐 浩 on 14-5-6.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "CustomStatusBar.h"
@interface Share_MainAction : NSObject
{
    AppDelegate *_appDelegate;

}
@property(nonatomic,strong)NSMutableArray* DataArray; //分享列表条目
@property(nonatomic,strong)NSString* titleString; //提示语头目
- (void)shareBySMSClickHandler:(UIViewController*)view;
- (void)shareToSinaWeiboClickHandler:(UIViewController *)view;
- (void)shareToWeixinSessionClickHandler:(UIViewController*)view;
- (void)shareToWeixinTimelineClickHandler:(UIViewController *)view;
@end
