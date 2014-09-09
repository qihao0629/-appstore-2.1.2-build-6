//
//  My_login_busine.m
//  腾云家务
//
//  Created by 艾飞 on 14-5-28.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_login_busine.h"
#import <CommonCrypto/CommonDigest.h>
#import "XmppManager.h"
#import "Ty_LifeTipsBusine.h"
#import "Ty_DbMethod.h"

@implementation My_login_busine


-(void)my_login_busine:(NSMutableDictionary *)_dic{

    [_dic setObject:[self md5HexDigest:[_dic objectForKey:@"userPassword"]] forKey:@"userPassword"];
    
    [[Ty_NetRequestService shareNetWork]formRequest:My_Login_Req andParameterDic:_dic andTarget:self andSeletor:@selector(loginReqCode:reqDic:)];

}

-(void)loginReqCode:(NSString *)reqCode reqDic:(NSDictionary*)_dic{

    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            
#if TARGET_SHOP_OPEN
            
            if ([[[[_dic objectForKey:@"rows"] objectAtIndex:0] objectForKey:@"userType"] isEqualToString:@"0"]) {
                
                PostNetDelegate(_dic,@"MyLogIn");
                
            }else {

            
                [[Ty_DbMethod shareDbService] releaseDbService];
                
                //保存登录信息  33615798
                [[NSUserDefaults standardUserDefaults]setObject:[[_dic objectForKey:@"rows"] objectAtIndex:0] forKey:@"MyLogin"];
                
                [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"MyLoginYes"];//登录状态
                
                [self xmppLogin];
                
                [self getLifeTips];
                
                [TYJPush setJpush];
                
                PostNetDelegate(_dic,@"MyLogIn");
                
            }
                

#else
            
            [[Ty_DbMethod shareDbService] releaseDbService];
            
            //保存登录信息  33615798
            [[NSUserDefaults standardUserDefaults]setObject:[[_dic objectForKey:@"rows"] objectAtIndex:0] forKey:@"MyLogin"];
            
            [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"MyLoginYes"];//登录状态
            
            [self xmppLogin];
            
            [self getLifeTips];
            
            [TYJPush setJpush];
            
            PostNetDelegate(_dic,@"MyLogIn");
            
#endif
    
        }else{
        
            PostNetDelegate(_dic,@"MyLogIn");

        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
    
        PostNetDelegate(reqCode,@"MyLogIn");

    }

}

#pragma mark --- XmppLogin
- (void)xmppLogin
{
    //登录成功后，调用XMPPManager登录xmpp
    NSString *password_md5 = [MyLoginInformation objectForKey:@"userpassword"];
    NSString *password = [NSString stringWithFormat:@"%@%@",[password_md5 substringToIndex:3],[password_md5 substringWithRange:NSMakeRange(29, 3)]];
    [[XmppManager shareXmppManager] loginWithUsername:[MyLoginInformation  objectForKey:@"userName"]  andPassword:password andCompletion:^(BOOL ret)
     {
         if (ret)
         {
             //登录成功
             NSLog(@"xmpp登录成功~");
         }
         else
         {
             //失败
             NSLog(@"xmpp登录失败~~");
         }
     }];
}

- (void)getLifeTips
{
    Ty_LifeTipsBusine *lifeTipsBusine = [[Ty_LifeTipsBusine alloc]init];
    [lifeTipsBusine getLifeDataFromNet];
    lifeTipsBusine = nil;
}

-(void)my_loginSucceed_busine:(NSMutableDictionary *)_dic{
    
    [_dic setObject:[self md5HexDigest:[_dic objectForKey:@"userPassword"]] forKey:@"userPassword"];
    
    [[Ty_NetRequestService shareNetWork]formRequest:My_Login_Req andParameterDic:_dic andTarget:self andSeletor:@selector(loginSucceedReqCode:reqDic:)];
    
}

-(void)loginSucceedReqCode:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            
            //登录成功将数据库单例置为nil
            [[Ty_DbMethod shareDbService] releaseDbService];
            
            //保存登录信息  33615798
            [[NSUserDefaults standardUserDefaults]setObject:[[_dic objectForKey:@"rows"] objectAtIndex:0] forKey:@"MyLogin"];
            
            [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"MyLoginYes"];//登录状态
            
            [self xmppLogin];
            
            [TYJPush setJpush];

            [[NSNotificationCenter defaultCenter] postNotificationName:@"MyLogInSucceed" object:_dic];
            
        }else{
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MyLogInSucceed" object:_dic];
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MyLogInSucceed" object:reqCode];

    }
    
}



#pragma mark - MD5
- (NSString *)md5HexDigest:(NSString*)password

{

    const char *original_str = [password UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(original_str, strlen(original_str), result);
    
    NSMutableString *hash = [NSMutableString string];
    
    for (int i = 0; i < 16; i++)
        
    {
        
        [hash appendFormat:@"%02X", result[i]];
        
    }
    
    NSString *mdfiveString = [hash uppercaseString];
    

    NSLog(@"Encryption Result = %@",mdfiveString);
    return mdfiveString;
}

@end
