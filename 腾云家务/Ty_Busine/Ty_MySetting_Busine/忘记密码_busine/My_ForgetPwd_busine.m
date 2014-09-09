//
//  My_ForgetPwd_busine.m
//  腾云家务
//
//  Created by AF on 14-7-21.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_ForgetPwd_busine.h"
#import <CommonCrypto/CommonDigest.h>

@implementation My_ForgetPwd_busine

#pragma mark - 验证手机号码
-(void)MyYanzhengUserPhone:(NSString *)userPhone{
    
    NSMutableDictionary * _dic = [[NSMutableDictionary alloc]init];
    [_dic setValue:userPhone forKey:@"userPhone"];
    [[Ty_NetRequestService shareNetWork]formRequest:My_UserPhone_Req andParameterDic:_dic andTarget:self andSeletor:@selector(MyUserPhone:reqDic:)];
}

#pragma mark - 请求回调方法
-(void)MyUserPhone:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            
            
            PostNetDelegate(_dic,@"MyYanzhengPhone");
            
        }else{
            
            PostNetDelegate(_dic,@"MyYanzhengPhone");
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        PostNetDelegate(reqCode,@"MyYanzhengPhone");
        
    }
}


#pragma mark - 重置密码
-(void)MyChongzhiPwdPhone:(NSString *)userPhone userPassword:(NSString *)userPassword{
    
    NSMutableDictionary * _dic = [[NSMutableDictionary alloc]init];
    [_dic setValue:userPhone forKey:@"userPhone"];
    [_dic setValue:[self md5HexDigest:userPassword] forKey:@"userPassword"];
    [[Ty_NetRequestService shareNetWork]formRequest:My_ChongZhiUserPwd_Req andParameterDic:_dic andTarget:self andSeletor:@selector(MyUserPwd:reqDic:)];
}

#pragma mark - 请求回调方法
-(void)MyUserPwd:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            
            
            PostNetDelegate(_dic,@"MyUpdateUserPwd");
            
        }else{
            
            PostNetDelegate(_dic,@"MyUpdateUserPwd");
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        PostNetDelegate(reqCode,@"MyUpdateUserPwd");
        
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
