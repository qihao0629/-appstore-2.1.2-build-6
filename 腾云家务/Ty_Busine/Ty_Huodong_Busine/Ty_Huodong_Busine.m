//
//  Ty_Huodong_Busine.m
//  腾云家务
//
//  Created by Xu Zhao on 14-5-29.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Huodong_Busine.h"

@implementation Ty_Huodong_Busine
@synthesize acTitle;
@synthesize acContent;
@synthesize acPushTime;
@synthesize acStartTime;
@synthesize acEndTime;
@synthesize acHttpUrl;
@synthesize acPhoto;

- (instancetype)init
{
    self = [super init];
    if (self) {
        arrHuodongList = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)getHuodongInfo
{
    NSMutableDictionary *dicServer = [[NSMutableDictionary alloc]init];
    [dicServer setValue:@"0" forKey:@"currentPage"];
    [dicServer setValue:@"20" forKey:@"pageSize"];
    [[Ty_NetRequestService shareNetWork] formRequest:Huodong_searchActivitieList andParameterDic:dicServer andTarget:self andSeletor:@selector(getHuodongInfoReturn: dic:)];
    //[[Ty_NetRequestService shareNetWork] request:Huodong_searchActivitieList andTarget:self andSeletor:@selector(getHuodongInfoReturn: dic:)];
}

-(void)getHuodongInfoReturn:(NSString* )_result dic:(NSDictionary *)_dic
{
    if(![_result isEqualToString:REQUESTSUCCESS])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Huodong_updateTableview_fail" object:nil];
    }
    //else if([[_dic objectForKey:@"code"] isEqualToString:@"200"])
    else if([[_dic objectForKey:@"code"]intValue] == 200)
    {
        NSArray *arrHuodong = [_dic objectForKey:@"rows"];
        //NSMutableArray *arrHuodongList = [[NSMutableArray alloc]init];
        
        for(int i=0;i<arrHuodong.count;i++)
        {
            NSDictionary *dicHuodong = [arrHuodong objectAtIndex:i];
            Ty_Huodong_Busine *huodongInfo = [[Ty_Huodong_Busine alloc]init];
            huodongInfo.acGuid = [dicHuodong objectForKey:@"acGuid"];
            huodongInfo.acTitle = [dicHuodong objectForKey:@"acTitle"];
            huodongInfo.acContent = [dicHuodong objectForKey:@"acContent"];
            huodongInfo.acPushTime = [dicHuodong objectForKey:@"acPushTime"];
            //huodongInfo.acStartTime = [dicHuodong objectForKey:@"acStartTime"];
            huodongInfo.acEndTime = [dicHuodong objectForKey:@"acEndTime"];
            huodongInfo.acHttpUrl = [dicHuodong objectForKey:@"acHttpUrl"];
            huodongInfo.acPhoto = [dicHuodong objectForKey:@"acPhoto"];
            
            NSArray *arrDateTemp = [[NSArray alloc]initWithArray:[[dicHuodong objectForKey:@"acStartTime"] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"- :"]]];
            NSString *strDate = [NSString stringWithFormat:@"%@-%@-%@",[arrDateTemp objectAtIndex:0],[arrDateTemp objectAtIndex:1],[arrDateTemp objectAtIndex:2]];
            huodongInfo.acStartTime = strDate;
            
            [arrHuodongList addObject:huodongInfo];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Huodong_updateTableview" object:arrHuodongList];
    }
    else
        ;
}
@end
