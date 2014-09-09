//
//  Ty_News_Busine_Jpush.m
//  腾云家务
//
//  Created by lgs on 14-5-30.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_News_Busine_Jpush.h"
#import "APService.h"
#import "Ty_SystemMessageBusine.h"
#import "CustomStatusBar.h"
#import "StatusNotificationBar.h"
#import "AppDelegateViewController.h"
#import "ViewController.h"
#import "Ty_LifeTipsBusine.h"

@implementation Ty_News_Busine_Jpush

static Ty_News_Busine_Jpush* news_Busine;

+(Ty_News_Busine_Jpush *)shareJpush
{
    if (news_Busine == nil) {
        news_Busine = [[Ty_News_Busine_Jpush alloc]init];
    }
    return news_Busine;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
        [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kAPNetworkDidReceiveMessageNotification object:nil];
        
        //required
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)];
        // Required
        
    }
    return self;
}
-(void)setupWithOption:(NSDictionary *)launchingOption
{
    [APService setupWithOption:launchingOption];
}
-(void)registerDeviceToken:(NSData*)_token
{
    [APService registerDeviceToken:_token];
}
-(void)setJpush
{
    [APService setAlias:MyLoginUserGuid callbackSelector:nil object:self];
}
-(void)releaseJpush
{
    [APService setAlias:@"" callbackSelector:nil object:self];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kAPNetworkDidReceiveMessageNotification object:nil];
    news_Busine = nil;
    
}


-(void)saveTokenToUserDefaultWithDeviceToken:(NSData*)deviceToken
{
    NSMutableString * token = [[NSMutableString alloc]init];
    [token appendFormat:@"%@",deviceToken];
    NSString * tokenstr = [token substringWithRange:NSMakeRange(1,token.length-2)];
    NSString* tokenString = [tokenstr stringByReplacingOccurrencesOfString:@" " withString:@""];
    [[NSUserDefaults standardUserDefaults] setValue:tokenString forKey:@"deviceToken"];
}
- (void)networkDidReceiveMessage:(NSNotification *)notification
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    NSDictionary * userInfo = [notification userInfo];
    NSDictionary* extras = [userInfo objectForKey:@"extras"];
    
    NSLog(@"%@",extras);
    
    if ([extras objectForKey:@"flag"] != nil&&([[extras objectForKey:@"flag"] intValue] == 602||[[extras objectForKey:@"flag"] intValue] == 603 || [[extras objectForKey:@"flag"] integerValue]  ==  601)) {
        [APService handleRemoteNotification:userInfo];
        Ty_SystemMessageBusine* systemBusine = [[Ty_SystemMessageBusine alloc] init];
        [systemBusine getMessageFromNet:[extras objectForKey:@"flag"] reqGuid:[extras objectForKey:@"rguid"]];
        extras = nil;
        systemBusine = nil;
    }
    else if ([extras objectForKey:@"flag"] != nil &&([[extras objectForKey:@"flag"] intValue] == 101 || [[extras objectForKey:@"flag"] intValue] == 109  || [[extras objectForKey:@"flag"] intValue] == 113  || [[extras objectForKey:@"flag"] intValue] == 202  || [[extras objectForKey:@"flag"] intValue] == 204  || [[extras objectForKey:@"flag"] intValue] == 206  || [[extras objectForKey:@"flag"] intValue] == 209) )
    {
        [[StatusNotificationBar shareNotificationBar] showStatusMessage:[userInfo objectForKey:@"content"]];
        
        if ([[[[UIApplication sharedApplication] delegate] window].rootViewController isKindOfClass:[AppDelegateViewController class]]) {
            AppDelegateViewController *appDelegateVC = (AppDelegateViewController *)[[[UIApplication sharedApplication] delegate] window].rootViewController;
            
            [appDelegateVC setOrderTabBarIcon:1];
            
            appDelegateVC = nil;
            
        }else if([[[[UIApplication sharedApplication] delegate] window].rootViewController isKindOfClass:[ViewController class]]){
            ViewController *VC = (ViewController *)[[[UIApplication sharedApplication] delegate] window].rootViewController;
            
            [VC.AppVC setOrderTabBarIcon:1];
            
            VC = nil;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowTopTipNotification" object:nil];
        
    }
    else if ([extras objectForKey:@"flag"] != nil && [[extras objectForKey:@"flag"] integerValue] == 502)
    {
        Ty_LifeTipsBusine *lifeTipsBusine = [[Ty_LifeTipsBusine alloc]init];
        [lifeTipsBusine getLifeDataFromNet];
        lifeTipsBusine = nil;
    }
    else if ([extras objectForKey:@"flag"] != nil && ([[extras objectForKey:@"flag"] integerValue] == 106 || [[extras objectForKey:@"flag"] integerValue] == 108 || [[extras objectForKey:@"flag"] integerValue] == 114 || [[extras objectForKey:@"flag"] integerValue] == 207 || [[extras objectForKey:@"flag"] integerValue] == 208 || [[extras objectForKey:@"flag"] integerValue] == 1 || [[extras objectForKey:@"flag"] integerValue] == 2))
    {
        
        //设置底部的红点
        [[StatusNotificationBar shareNotificationBar] showStatusMessage:[userInfo objectForKey:@"content"]];
        
        if ([[[[UIApplication sharedApplication] delegate] window].rootViewController isKindOfClass:[AppDelegateViewController class]]) {
            AppDelegateViewController *appDelegateVC = (AppDelegateViewController *)[[[UIApplication sharedApplication] delegate] window].rootViewController;
            
            [appDelegateVC setOrderTabBarIcon:1];
            
            appDelegateVC = nil;
            
        }else if([[[[UIApplication sharedApplication] delegate] window].rootViewController isKindOfClass:[ViewController class]]){
            ViewController *VC = (ViewController *)[[[UIApplication sharedApplication] delegate] window].rootViewController;
            
            [VC.AppVC setOrderTabBarIcon:1];
            
            VC = nil;
        }

        //设置三个筛选的红点
        int flag = [[extras objectForKey:@"flag"] integerValue];
        
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];

        if (106 == flag)
        {
            [objectDic setObject:@"0" forKey:@"index"];
        }
        else if (108 == flag || 114 == flag || 207 == flag || 208 == flag)
        {
            [objectDic setObject:@"2" forKey:@"index"];
        }
        else if (1 == flag || 2 == flag)
        {
            [objectDic setObject:@"1" forKey:@"index"];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WorkerShowTopTip" object:objectDic];
    }

    userInfo = nil;
}

@end
