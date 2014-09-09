//
//  Ty_NetRequestService.m
//  腾云家务
//
//  Created by 齐 浩 on 14-5-26.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
#define TYRESULTSELETOR @"ResultSeletor"
#define TYREQUESTINDEX @"TYrequestIndex"



#import "Ty_NetRequestService.h"
#import "Ty_Model_MessageInfo.h"
#import "My_LoginViewController.h"
#import "XmppManager.h"
#import "Ty_DbMethod.h"
#import "AppDelegateViewController.h"
#import "Share_MainVC.h"

@implementation Ty_NetRequestService
static Ty_NetRequestService *netService;

+ (Ty_NetRequestService *)shareNetWork
{
    static dispatch_once_t  onceToken;
    
    dispatch_once(&onceToken, ^{
        
        netService = [[Ty_NetRequestService alloc]init];
        
    });
    return netService;
}

- (id)init
{
    if(self = [super init])
    {
        requestPoolDic=[[NSMutableDictionary alloc] initWithCapacity:10];
        
    }
    return self;
}

-(void)formRequest:(NSString *)urlStr  andParameterDic:(NSMutableDictionary *)paraDic andfileDic:(NSMutableDictionary *)fileDic andTarget:(id) target andSeletor:(SEL)seletor{
    
    ++index;
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOSTLOCATION,urlStr]];
    
    ASIFormDataRequest * request=[[ASIFormDataRequest alloc] initWithURL:url];
    [request setShouldAttemptPersistentConnection:NO];
    [request setTimeOutSeconds:30];
    NSArray * paraArray=[paraDic allKeys];
    NSArray * fileArray=[fileDic allKeys];
    for (NSString * parameter in paraArray) {
        
        NSString * value=[paraDic objectForKey:parameter];
        [request setPostValue:value forKey:parameter];
        
    }
    
    for (NSString* fileString in fileArray) {
        // NSData* dataValue=[fileDic objectForKey:fileString];
        // [request setData:dataValue forKey:fileString];
        [request setFile:[fileDic objectForKey:fileString] forKey:fileString];
    }
    paraArray=nil;
    fileArray=nil;
    Ty_NetResultBean * bean=[[Ty_NetResultBean alloc] init];
    [bean setTarget:target];
    [bean setSeletor:seletor];
    request.delegate=self;
    request.userInfo=[NSDictionary dictionaryWithObjectsAndKeys:bean,TYRESULTSELETOR,[NSString stringWithFormat:@"%d",index],TYREQUESTINDEX,nil];
    
    bean=nil;
    
    [requestPoolDic setObject:request forKey:[NSString stringWithFormat:@"%d",index]];
    [self startAsynchronousHttpRequest:request];
    
}



-(void)formRequest:(NSString *)urlStr andParameterDic:(NSMutableDictionary *)paraDic andTarget:(id) target andSeletor:(SEL)seletor{
    
    ++index;
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOSTLOCATION,urlStr]];
    
    ASIFormDataRequest * request=[[ASIFormDataRequest alloc] initWithURL:url];
    [request setShouldAttemptPersistentConnection:NO];
    [request setTimeOutSeconds:30];
    NSArray * paraArray=[paraDic allKeys];
    
    for (NSString * parameter in paraArray) {
        
        NSString * value=[paraDic objectForKey:parameter];
        [request setPostValue:value forKey:parameter];
    }
    paraArray=nil;

    Ty_NetResultBean * bean=[[Ty_NetResultBean alloc] init];
    [bean setTarget:target];
    [bean setSeletor:seletor];
    request.delegate=self;
    request.userInfo=[NSDictionary dictionaryWithObjectsAndKeys:bean,TYRESULTSELETOR,[NSString stringWithFormat:@"%d",index],TYREQUESTINDEX,nil];
    
    bean=nil;
    
    [requestPoolDic setObject:request forKey:[NSString stringWithFormat:@"%d",index]];
    [self startAsynchronousHttpRequest:request];
    
}


-(void)formRequest:(NSString *)urlStr andParameterDic:(NSMutableDictionary *)paraDic  andfileDic:(NSMutableDictionary*)fileDic andSymbolParameter:(id)object  andTarget:(id) target andSeletor:(SEL)seletor
{
    ++index;
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOSTLOCATION,urlStr]];
    
    ASIFormDataRequest * request=[[ASIFormDataRequest alloc] initWithURL:url];
    [request setShouldAttemptPersistentConnection:NO];
    [request setTimeOutSeconds:30];
    NSArray * paraArray=[paraDic allKeys];
    NSArray * fileArray=[fileDic allKeys];
    for (NSString * parameter in paraArray) {
        
        NSString * value=[paraDic objectForKey:parameter];
        [request setPostValue:value forKey:parameter];
        
    }
    
    for (NSString* fileString in fileArray) {
       // NSData* dataValue=[fileDic objectForKey:fileString];
       // [request setData:dataValue forKey:fileString];
        [request setFile:[fileDic objectForKey:fileString] forKey:fileString];
    }
    paraArray=nil;
    fileArray=nil;
    
    Ty_NetResultBean * bean=[[Ty_NetResultBean alloc] init];
    bean.isVoiceRequest = YES;
    [bean setTarget:target];
    [bean setSeletor:seletor];
    bean.symbolObject = object;
    request.delegate=self;
    request.userInfo=[NSDictionary dictionaryWithObjectsAndKeys:bean,TYRESULTSELETOR,[NSString stringWithFormat:@"%d",index],TYREQUESTINDEX,nil];
    
    bean=nil;
    
    [requestPoolDic setObject:request forKey:[NSString stringWithFormat:@"%d",index]];
    [self startAsynchronousHttpRequest:request];
}

-(void)request:(NSString *)urlStr  andTarget:(id) target andSeletor:(SEL)seletor{
    ++index;
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOSTLOCATION,urlStr]];
    
    ASIHTTPRequest * request=[[ASIHTTPRequest alloc] initWithURL:url];
    [request setShouldAttemptPersistentConnection:NO];
    [request setTimeOutSeconds:30];
    
    Ty_NetResultBean * bean=[[Ty_NetResultBean alloc] init];
    [bean setTarget:target];
    [bean setSeletor:seletor];
    request.delegate=self;
    request.userInfo=[NSDictionary dictionaryWithObjectsAndKeys:bean,TYRESULTSELETOR,[NSString stringWithFormat:@"%d",index],TYREQUESTINDEX,nil];
    
    bean=nil;
    
    [requestPoolDic setObject:request forKey:[NSString stringWithFormat:@"%d",index]];
    [self startAsynchronousHttpRequest:request];
}

#pragma mark --- 下载语音请求
- (void)downLoadVoiceMessage:(id)object target:(id)target seletor:(SEL)seletor
{
    ++index;
    
    Ty_Model_MessageInfo *messageInfo = (Ty_Model_MessageInfo *)object;
    NSURL *url = [NSURL URLWithString:messageInfo.messageVoiceServicePath];
    
    // 创建录音存放的路径
    [[NSFileManager defaultManager] createDirectoryAtPath:VoicePath withIntermediateDirectories:YES attributes:nil error:nil];
    
    ASIHTTPRequest *httpRequest = [ASIHTTPRequest requestWithURL:url];
    httpRequest.delegate=self;
    
    NSString *Path=[NSString stringWithFormat:@"%@%@.amr",VoicePath,messageInfo.messageGuid];
    [httpRequest setDownloadDestinationPath:Path];
    [httpRequest setDownloadProgressDelegate:self];
    [httpRequest setShouldAttemptPersistentConnection:NO];
    
    
    Ty_NetResultBean * bean=[[Ty_NetResultBean alloc] init];
    
    [bean setTarget:target];
    [bean setSeletor:seletor];
    bean.isDownloadVoiceRequest = YES;
    bean.symbolObject = object;
    
 //   NSLog(@"%@\n%@",object,bean.symbolObject);
    
    httpRequest.delegate = self;
    httpRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:bean,TYRESULTSELETOR,[NSString stringWithFormat:@"%d",index],TYREQUESTINDEX,nil];
    [self startAsynchronousHttpRequest:httpRequest];
    
}

-(void)startAsynchronousHttpRequest:(ASIHTTPRequest*)_request
{
    if (IFLOGINYES) {
        [_request setRequestHeaders:[[NSMutableDictionary alloc] initWithObjectsAndKeys:MyLoginUserGuid,@"loginGuid",[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"],@"phoneId",@"ios",@"phoneType", nil]];
    }else{
        [_request setRequestHeaders:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"],@"phoneId",@"ios",@"phoneType", nil]];
    }
    
    [_request startAsynchronous];
}

-(void) requestFinished:(ASIHTTPRequest *)_request
{
 //   NSLog(@"%@",_request.responseString);
    NSData* response=[_request responseData];
    NSError *error = nil;
    NSLog(@"requestFinished : %@",[[NSString alloc]initWithData:response encoding:NSUTF8StringEncoding]);
    NSString*jsonString=[[NSString alloc]initWithData:response encoding:NSUTF8StringEncoding];
    
    jsonString =[jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    jsonString =[jsonString stringByReplacingOccurrencesOfString:@"\\n" withString:@"\\n"];
    jsonString =[jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@"\\n"];
    jsonString =[jsonString stringByReplacingOccurrencesOfString:@"\\r" withString:@"\\n"];
//    NSLog(@"success==%@",jsonString);
    
    NSDictionary *weatherDic;
    NSData *responseData=[jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if (response != nil)
    {
        weatherDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    }
    if ([[weatherDic objectForKey:@"code"] intValue]==205) {
        
        
        
//        NSRange range;
//        range.length=[[TYNAVIGATION viewControllerArray] count]-2;
//        range.location=1;
//        NSArray* array=[[TYNAVIGATION viewControllerArray] subarrayWithRange:range];
//        
//        [TYNAVIGATION removeViewControllersFromWindow:array];
        
        
        
        if ([[[[UIApplication sharedApplication] delegate] window].rootViewController isKindOfClass:[AppDelegateViewController class]]) {
            
            
            [[XmppManager shareXmppManager] logoutWithCompletion:nil];
            [[Ty_DbMethod shareDbService] releaseDbService];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"MyEmployeeHead"];
            [TYJPush releaseJpush];
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"MyLoginYes"];
            if ([[[UIApplication sharedApplication] keyWindow].rootViewController isKindOfClass:[AppDelegateViewController class]])
            {
                AppDelegateViewController *appDelegateVC = (AppDelegateViewController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
                [appDelegateVC setTabBarIcon:0 atIndex:1];
            }
            
            SETUSERADDRESSDETAIL(@"");
            SETUSERAREA(@"");
            SETUSERREGION(@"");
            SetReq_WorkAmount(@"");
            SetReq_WorkGuid(@"");
            SetReq_WorkName(@"");
            
            AppDelegateViewController* app=(AppDelegateViewController*)[[TYNAVIGATION viewControllerArray] objectAtIndex:0];
            
            
            if (app.appNavigation==app.my_home) {
            }else{
                [app transitionFromViewController:[app appNavigation] toViewController:[app my_home] duration:0 options:UIViewAnimationOptionLayoutSubviews  animations:^{
                    
                    
                } completion:^(BOOL finished) {
                    
                    if (finished) {
                        
                        app.appNavigation = app.my_home;
                        [app.but_home setImage:JWImageName(@"service_2") forState:UIControlStateNormal];
                        [app.but_corder setImage:JWImageName(@"private_letter_1") forState:UIControlStateNormal];
                        [app.but_order setImage:JWImageName(@"order_list_1") forState:UIControlStateNormal];
                        [app.but_my setImage:JWImageName(@"management_1") forState:UIControlStateNormal];
                        
                        app._currentIndex = 0;
                        
                    }else{
                        
                        
                    }
                    
                }];
            }
            My_LoginViewController* loginVC=[[My_LoginViewController alloc] init];
            [TYNAVIGATION pushViewController:loginVC withAnimation:YES];
        }
        
        
    }
    
    
    Ty_NetResultBean * bean=[[_request userInfo] objectForKey:TYRESULTSELETOR];
    
    if (bean) {
        
        if ([bean.target respondsToSelector:bean.seletor]) {
            
            
            if (bean.isVoiceRequest || bean.isDownloadVoiceRequest) //发送语音及下载语音执行
            {
                //  NSLog(@"%@",bean.symbolObject);
                [bean.target performSelector:bean.seletor withObject:bean.symbolObject withObject:weatherDic];
            }
            else //除发送语音及下载语音之外的网络请求回调
            {
                [bean.target performSelector:bean.seletor withObject:REQUESTSUCCESS withObject:weatherDic];
            }
            
            
        }
        
    }
    bean=nil;
    
    NSString * indexStr = [[_request userInfo] objectForKey:TYREQUESTINDEX];
    
    [requestPoolDic removeObjectForKey:indexStr];
}

-(void)requestFailed:(ASIHTTPRequest *)_request
{

    Ty_NetResultBean * bean=[[_request userInfo] objectForKey:TYRESULTSELETOR];
    if (bean) {
        if (bean.isVoiceRequest || bean.isDownloadVoiceRequest)
        {
            if (bean.isDownloadVoiceRequest)
            {
                Ty_Model_MessageInfo *messageInfo = (Ty_Model_MessageInfo *)bean.symbolObject;
                //删除之前的临时路径
                NSString *Path=[NSString stringWithFormat:@"%@%@.amr",VoicePath,messageInfo.messageGuid];
                [[NSFileManager defaultManager] removeItemAtPath:Path error:nil];
                
            }
            
            [bean.target performSelector:bean.seletor withObject:bean.symbolObject withObject:nil];
        }
        else //除发送语音及下载语音之外的网络请求回调
        {
            [bean.target performSelector:bean.seletor withObject:REQUESTFAIL withObject:nil];
        }
    }
    bean=nil;
    
    NSString * indexStr = [[_request userInfo] objectForKey:TYREQUESTINDEX];
    [requestPoolDic removeObjectForKey:indexStr];
}


@end
