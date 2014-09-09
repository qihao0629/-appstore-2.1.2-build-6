//
//  Ty_NetRequestService.h
//  腾云家务
//
//  Created by 齐 浩 on 14-5-26.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ty_NetResultBean.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface Ty_NetRequestService : NSObject
{
    NSMutableDictionary * requestPoolDic;//管理请求对象  及时持有 及时释放
    int index;//请求对象的唯一标示
}
+ (Ty_NetRequestService *)shareNetWork;/**实例化*/


/**post请求*/
-(void)formRequest:(NSString *)urlStr andParameterDic:(NSMutableDictionary *)paraDic andTarget:(id) target andSeletor:(SEL)seletor;

/**post请求
 *带有文件的请求
 *@param object: 一个区分的参数，主要用于区分语音私信
 */
-(void)formRequest:(NSString *)urlStr andParameterDic:(NSMutableDictionary *)paraDic andfileDic:(NSMutableDictionary*)fileDic andSymbolParameter:(id)object andTarget:(id) target andSeletor:(SEL)seletor;

/**post请求
 *下载语音文件
 */
-(void)formRequestParameterDic:(NSMutableDictionary *)paraDic andfileDic:(NSMutableDictionary*)fileDic andTarget:(id) target andSeletor:(SEL)seletor;

/**
 *  下载语音信息
 *
 *  @param object  MessageInfo信息类
 */
- (void)downLoadVoiceMessage:(id)object target:(id)target seletor:(SEL)seletor;

/**get请求*/
-(void)request:(NSString *)urlStr  andTarget:(id) target andSeletor:(SEL)seletor;


/**上传头像 图文混搭上传*/
-(void)formRequest:(NSString *)urlStr  andParameterDic:(NSMutableDictionary *)paraDic andfileDic:(NSMutableDictionary *)fileDic andTarget:(id) target andSeletor:(SEL)seletor;


@end
