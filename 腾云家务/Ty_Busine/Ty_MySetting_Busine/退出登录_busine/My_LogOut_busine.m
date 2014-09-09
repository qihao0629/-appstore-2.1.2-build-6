//
//  My_LogOut_busine.m
//  腾云家务
//
//  Created by 艾飞 on 14/6/11.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_LogOut_busine.h"
#import "Ty_DbMethod.h"
#import "XmppManager.h"
#import "AppDelegateViewController.h"

@implementation My_LogOut_busine

#pragma mark - 用户退出登录
-(void)my_LogOut_busine{
    
    [[Ty_NetRequestService shareNetWork]formRequest:My_LogOut_Req andParameterDic:nil andTarget:self andSeletor:@selector(RegisteredCode:reqDic:)];
    
}

-(void)RegisteredCode:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            
            [[XmppManager shareXmppManager] logoutWithCompletion:nil];
            [[Ty_DbMethod shareDbService] releaseDbService];
            [TYJPush releaseJpush];
            [self setIcon];
             
            SETUSERADDRESSDETAIL(@"");
            SETUSERAREA(@"");
            SETUSERREGION(@"");
            
            SetReq_WorkAmount(@"");
            SetReq_WorkGuid(@"");
            SetReq_WorkName(@"");
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"MyEmployeeHead"];

            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"MyLoginYes"];
            
            PostNetDelegate(_dic,@"MyLogOut");
            
        }else{
            
            PostNetDelegate(_dic,@"MyLogOut");
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        PostNetDelegate(reqCode,@"MyLogOut");
        
    }
    
}

- (void)setIcon
{
    if ([[[UIApplication sharedApplication] keyWindow].rootViewController isKindOfClass:[AppDelegateViewController class]])
    {
        AppDelegateViewController *appDelegateVC = (AppDelegateViewController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
        [appDelegateVC setTabBarIcon:0 atIndex:1];
    }
}
@end
