//
//  Ty_NetResultBean.m
//  腾云家务
//
//  Created by 齐 浩 on 14-5-26.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_NetResultBean.h"

@implementation Ty_NetResultBean

@synthesize isVoiceRequest = _isVoiceRequest;
@synthesize symbolObject = _symbolObject;
@synthesize isDownloadVoiceRequest = _isDownloadVoiceRequest;

- (id)init
{
    if (self = [super init])
    {
        _isVoiceRequest = NO;
        _symbolObject = nil;
        _isDownloadVoiceRequest = NO;
    }
    return self;
}

-(void)requestCallBack{
    
    if ([self.target respondsToSelector:self.seletor]) {
        
        
    }
    
}
@end
