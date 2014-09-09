//
//  My_SetUpHelp_busine.m
//  腾云家务
//
//  Created by 齐 浩 on 14-7-18.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_SetUpHelp_busine.h"

@implementation My_SetUpHelp_busine
- (instancetype)init
{
    self = [super init];
    if (self) {
    
    }
    return self;
}
-(void)sendHelpcontent:(NSString *)_content
{
    NSMutableDictionary* dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[Guid share] getGuid],@"feedbackGuid",_content,@"content", nil];
    [[Ty_NetRequestService shareNetWork]formRequest:My_Help andParameterDic:dic andTarget:self andSeletor:@selector(receiveHelp:dic:)];
}
-(void)receiveHelp:(NSString*)_isSuccess dic:(NSMutableDictionary*)_dic
{
    if ([_isSuccess isEqualToString:REQUESTSUCCESS]) {
        if ([[_dic objectForKey:@"code"] intValue]==200) {
            NSDictionary* dic=[[NSDictionary alloc]initWithObjectsAndKeys:@"200",@"code", nil];
            PostNetNotification(dic, @"My_SetUpHelpVC");
        }else{
            NSDictionary* dic=[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",[[_dic objectForKey:@"code"] intValue]],@"code", nil];
            PostNetNotification(dic, @"My_SetUpHelpVC");
        }
    }else{
        NSDictionary* dic=[[NSDictionary alloc]init];
        PostNetNotification(dic, @"My_SetUpHelpVC");
    }
}
@end
