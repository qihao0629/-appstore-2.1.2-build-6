//
//  Ty_NetResultBean.h
//  腾云家务
//
//  Created by 齐 浩 on 14-5-26.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ty_NetResultBean : NSObject
@property(strong,nonatomic)id target;
@property(assign,nonatomic)SEL seletor;
@property (nonatomic,assign) BOOL isVoiceRequest;/**是否为发送语音请求*/

@property (nonatomic,assign) BOOL isDownloadVoiceRequest;/**是否为下载语音请求标志*/

@property (nonatomic,strong) id symbolObject;

-(void)requestCallBack;
@end
