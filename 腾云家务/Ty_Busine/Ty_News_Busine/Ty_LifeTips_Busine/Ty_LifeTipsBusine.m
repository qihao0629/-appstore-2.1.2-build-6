//
//  Ty_LifeTipsBusine.m
//  腾云家务
//
//  Created by liu on 14-8-14.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_LifeTipsBusine.h"
#import "Ty_DbMethod.h"
#import "Ty_Model_LifeTipsInfo.h"
#import "AppDelegateViewController.h"

@implementation Ty_LifeTipsBusine

@synthesize lifeTipsArr = _lifeTipsArr;

-(id)init
{
    if (self = [super init])
    {
        _lifeTipsArr = [[NSMutableArray alloc]init];
    }
    
    return self;
}

- (void)dealloc
{
    _lifeTipsArr = nil;
}

#pragma mark -- 从数据库获取数据
- (void)getLifeMessageDataByPageNum:(NSInteger)pageNum
{
    NSString *sql = [NSString stringWithFormat:@"select * from %@ order by %@ desc",TBL_LIFETIPS,LifeTips_Time];
    
    FMResultSet *resultSet = [[Ty_DbMethod shareDbService] selectData:sql];
    while (resultSet.next)
    {
        Ty_Model_LifeTipsInfo *lifeTipsInfo = [[Ty_Model_LifeTipsInfo alloc]init];
        
        lifeTipsInfo.lifeTipsTitle = [resultSet stringForColumn:LifeTips_Title];
        lifeTipsInfo.lifeTipsContent = [resultSet stringForColumn:LifeTips_Content];
        lifeTipsInfo.lifeTipsContentImg = [resultSet stringForColumn:LifeTips_ContentImage];
        lifeTipsInfo.lifeTipsDate = [resultSet stringForColumn:LifeTips_Time];
        lifeTipsInfo.lifeTipsGuid = [resultSet stringForColumn:LifeTips_Guid];
        
        [_lifeTipsArr addObject:lifeTipsInfo];
        
        lifeTipsInfo = nil;
    }
}

-(void)setAllLifeTipsStatusRead
{
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ = '1' where %@ = '0'",TBL_LIFETIPS,LifeTips_IsRead,LifeTips_IsRead];
    [[Ty_DbMethod shareDbService] updateData:sql];
}
#pragma mark -- 插入网络数据
- (void)insertLifeTipsData:(NSMutableDictionary *)dic
{
    NSString *timeStampStr = [dic objectForKey:@"currentTime"];
    NSMutableArray *array = [dic objectForKey:@"Info"];
    for (NSDictionary *dic  in array)
    {
        NSString *sql = [NSString stringWithFormat:@"insert into %@ (%@,%@,%@,%@,%@,%@) values ('%@','%@','%@','%@','%@',0)",TBL_LIFETIPS,
                         LifeTips_Guid,
                         LifeTips_Content,
                         LifeTips_ContentImage,
                         LifeTips_Time,
                         LifeTips_TimeStamp,
                         LifeTips_IsRead,
                         [dic objectForKey:@"Id"],
                         [dic objectForKey:@"Content"],
                         [dic objectForKey:@"ImgPath"],
                         [dic objectForKey:@"Time"],
                         timeStampStr];
        [[Ty_DbMethod shareDbService]insertData:sql];
    }
    
}

- (NSInteger)getAllUnreadMessageNum
{
    int num = 0;
    
    NSString *sql = [NSString stringWithFormat:@"select count (*) from %@ where %@ = 0 and %@ = 0 and %@ = 1 and %@ = 0 ",TBL_MESSAGE,
                     Message_IsRead,
                     Message_IsDelete,
                     Message_IsDownloadSuccess,
                     Message_IsGroupDelete];
    FMResultSet *resultSet = [[Ty_DbMethod shareDbService]selectData:sql];
    while (resultSet.next)
    {
        num = [resultSet intForColumnIndex:0];
    }
    
    
    int systemNum = 0;
    NSString *sql1 = [NSString stringWithFormat:@"select count (*) from %@ where %@ = 0 ",SYSTEMMESSAGE,SysTemMessage_IsRead];
    FMResultSet *resultSet1 = [[Ty_DbMethod shareDbService] selectData:sql1];
    while (resultSet1.next)
    {
        systemNum = [resultSet1 intForColumnIndex:0];
    }
    
    int lifeTipsNum = 0;
    NSString *sql2 = [NSString stringWithFormat:@"select count (*) from %@ where %@ = 0 ",TBL_LIFETIPS,LifeTips_IsRead];
    FMResultSet *resultSet2 = [[Ty_DbMethod shareDbService] selectData:sql2];
    while (resultSet2.next)
    {
        lifeTipsNum = [resultSet2 intForColumnIndex:0];
    }
    
    return num + systemNum + lifeTipsNum;
}

- (BOOL)isDataExist
{
    BOOL isExist = NO;
    NSString *sql = [NSString stringWithFormat:@"select * from %@ ",TBL_TIMESTAMP];
    FMResultSet *resultSet = [[Ty_DbMethod shareDbService] selectData:sql];
    while (resultSet.next)
    {
        isExist = YES;
    }
    
    return isExist;
}

- (void)updateTimeStamp:(NSString *)timeStamp
{
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ = '%@'",TBL_TIMESTAMP,TimeStamp_LifeTips,timeStamp];
    [[Ty_DbMethod shareDbService] updateData:sql];
}

#pragma mark -- 获取数据
- (void)getLifeDataFromNet
{
    NSString *timeStamp = @"";
    NSString *sql = [NSString stringWithFormat:@"select * from %@ ",TBL_TIMESTAMP];
    FMResultSet *resultSet = [[Ty_DbMethod shareDbService] selectData:sql];
   
    
    
    
//    NSString *sql = [NSString stringWithFormat:@"select %@ from %@ limit 0,1",LifeTips_TimeStamp,TBL_LIFETIPS];
    
    
   // FMResultSet *resultSet = [[Ty_DbMethod shareDbService]selectData:sql];
    while (resultSet.next)
    {
        timeStamp = [resultSet stringForColumn:TimeStamp_LifeTips];
    }
    
    if ([timeStamp isEqualToString:@""])
    {
        timeStamp = [self getCurrentTime];
        NSString *sql = [NSString stringWithFormat:@"insert into %@ (%@) values ('%@')",TBL_TIMESTAMP,TimeStamp_LifeTips,timeStamp];
        [[Ty_DbMethod shareDbService] insertData:sql];
    }

    
    [[Ty_NetRequestService shareNetWork] formRequest:URL_LifeTips andParameterDic:[NSMutableDictionary dictionaryWithObjectsAndKeys:timeStamp,@"latestTime", nil] andTarget:self andSeletor:@selector(getLifeTipsMsgRequest:data:)];
}

- (void)getLifeTipsMsgRequest:(NSString *)result data:(NSMutableDictionary *)dic
{
    NSLog(@"%@",dic);
    if ([[dic objectForKey:@"code"] intValue] == 200)
    {
        NSMutableDictionary *dataDic = [dic objectForKey:@"rows"];
        
        NSString *time = [dataDic objectForKey:@"currentTime"];
        if (time.length > 0)
        {
            [self updateTimeStamp:time];
        }
        
        [self insertLifeTipsData:dataDic];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetLifeTipMessage" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshMsgList" object:nil];
        
        if ([[[UIApplication sharedApplication] keyWindow].rootViewController isKindOfClass:[AppDelegateViewController class]])
        {
            
            AppDelegateViewController *appDelegateVC = (AppDelegateViewController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
            [appDelegateVC setTabBarIcon:[self getAllUnreadMessageNum] atIndex:1];
        }
    }
    
}

#pragma mark --- 辅助信息-获取时间
- (NSString *)getCurrentTime
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *current = [dateFormatter stringFromDate:currentDate];
    dateFormatter = nil;
    return current;
}

@end
