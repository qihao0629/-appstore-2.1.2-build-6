//
//  My_Registered_busine.m
//  腾云家务
//
//  Created by 艾飞 on 14-5-30.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_Registered_busine.h"
#import <CommonCrypto/CommonDigest.h>

@implementation My_Registered_busine

#pragma mark - 获取验证码
-(void)my_YanZhengMa_busine:(NSMutableDictionary *)_dic{
    
    
    [[Ty_NetRequestService shareNetWork]formRequest:My_YanZheng_Req andParameterDic:_dic andTarget:self andSeletor:@selector(RegisterdReqCode:reqDic:)];
    
}

-(void)RegisterdReqCode:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            

            PostNetDelegate(_dic,@"YanZhengMa");
            
        }else{
            
            PostNetDelegate(_dic,@"YanZhengMa");
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        PostNetDelegate(reqCode,@"YanZhengMa");
        
    }
    
}

//
#pragma mark - 短信验证码验证
-(void)my_CheckYanZhengMa_busine:(NSMutableDictionary *)_dic{
    
    
    [[Ty_NetRequestService shareNetWork]formRequest:My_CheckYanZheng_Req andParameterDic:_dic andTarget:self andSeletor:@selector(CheckReqCode:reqDic:)];
    
}

-(void)CheckReqCode:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            
            
            MyPostNetNotification(_dic);
            
        }else{
            
            MyPostNetNotification(_dic);
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        MyPostNetNotification(reqCode);
        
    }
    
}


#pragma mark - 注册用户信息(新)
-(void)my_Registered_busine:(NSMutableDictionary *)_dic{
    
    [_dic setObject:[self md5HexDigest:[_dic objectForKey:@"userPassword"]] forKey:@"userPassword"];
    
    [[Ty_NetRequestService shareNetWork]formRequest:My_Registered_Req andParameterDic:_dic andTarget:self andSeletor:@selector(RegisteredCode:reqDic:)];
    
}

-(void)RegisteredCode:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            
            NSMutableDictionary * _dicReq = [[NSMutableDictionary alloc]init];
            [_dicReq setObject:@"24200" forKey:@"code"];
            PostNetDelegate(_dicReq,@"MyNewReqistered");
            
        }else{
            
            PostNetDelegate(_dic,@"MyNewReqistered");
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        PostNetDelegate(reqCode,@"MyNewReqistered");
        
    }
    
}

#pragma mark - 注册商户信息
-(void)my_enterpriseRegisterd_busine:(NSMutableDictionary *)_dic{
    
    [_dic setObject:[self md5HexDigest:[_dic objectForKey:@"userPassword"]] forKey:@"userPassword"];
    
    [[Ty_NetRequestService shareNetWork]formRequest:My_Registered_Req andParameterDic:_dic andTarget:self andSeletor:@selector(MyEnetperiseRegisteredCode:reqDic:)];
    
}

-(void)MyEnetperiseRegisteredCode:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            
            
            PostNetDelegate(_dic,@"MyRegisteredShop");
            
        }else{
            
            PostNetDelegate(_dic,@"MyRegisteredShop");
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        PostNetDelegate(reqCode,@"MyRegisteredShop");
        
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
