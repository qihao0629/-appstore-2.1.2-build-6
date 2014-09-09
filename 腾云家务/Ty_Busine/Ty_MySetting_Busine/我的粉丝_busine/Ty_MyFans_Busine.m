//
//  Ty_MyFans_Busine.m
//  腾云家务
//
//  Created by Xu Zhao on 14-7-2.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_MyFans_Busine.h"
#import "My_FansModel.h"
#import "Ty_Model_ServiceObject.h"

static Ty_MyFans_Busine * fansBusine;

@implementation Ty_MyFans_Busine
@synthesize arrFans;
@synthesize arrSection;
@synthesize arrSectionNum;

+(Ty_MyFans_Busine *)share_Busine_DataBase
{
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        fansBusine = [[Ty_MyFans_Busine alloc]init];
    });
    return fansBusine;
}

-(BOOL)getMyFansFromSqlWithSearch:(NSString *)_search
{
    [arrFans removeAllObjects];
    [arrSection removeAllObjects];
    [arrSectionNum removeAllObjects];
    
    NSString *sql = [NSString stringWithFormat:@"select CONTACTDATA_FANS_USER_GUID,CONTACTDATA_USER_NAME,CONTACTDATA_USER_SPELL,CONTACTDATA_USER_COMPANY,CONTACTDATA_INTERMEDIARY_NAME,CONTACTDATA_USER_PHOTO,CONTACTDATA_USER_BIG_PHOTO,CONTACTDATA_USER_TYPE,CONTACTDATA_USER_SEX,CONTACTDATA_USER_REALNAME,CONTACTDATA_USER_EVALUATEMASTER,CONTACTDATA_USER_EVALUATEEMPLOYEE,CONTACTDATA_ANNEAR,CONTACTDATA_USER_POST from CONTACTDATA where CONTACTDATA_FANS_USER_GUID <> '%@' %@ order by CONTACTDATA_USER_SPELL",MyLoginUserGuid,_search];
    FMResultSet *arr = [[Ty_DbMethod shareDbService] selectData:sql];
    
    while ([arr next])
    {
//        Ty_Model_ServiceObject * fansObject = [[Ty_Model_ServiceObject alloc]init];
//        fansObject.userGuid = [arr stringForColumn:@"CONTACTDATA_FANS_USER_GUID"];
//        fansObject.userName = [arr stringForColumn:@"CONTACTDATA_USER_NAME"];
        
        My_FansModel *fansModel = [[My_FansModel alloc]init];
        fansModel.strFansGuid = [arr stringForColumn:@"CONTACTDATA_FANS_USER_GUID"];//关注我的人
        fansModel.strUserName = [arr stringForColumn:@"CONTACTDATA_USER_NAME"];
        fansModel.strUserSpell = [arr stringForColumn:@"CONTACTDATA_USER_SPELL"];
        fansModel.strUserCompany = [arr stringForColumn:@"CONTACTDATA_USER_COMPANY"];
        fansModel.strIntermediaryName = [arr stringForColumn:@"CONTACTDATA_INTERMEDIARY_NAME"];
        fansModel.strUserPhoto = [arr stringForColumn:@"CONTACTDATA_USER_PHOTO"];
        fansModel.strUserBigPhoto = [arr stringForColumn:@"CONTACTDATA_USER_BIG_PHOTO"];
        fansModel.strUserType = [arr stringForColumn:@"CONTACTDATA_USER_TYPE"];
        fansModel.strUserSex = [arr stringForColumn:@"CONTACTDATA_USER_SEX"];
        fansModel.strUserRealName = [arr stringForColumn:@"CONTACTDATA_USER_REALNAME"];
        fansModel.strUserEvaluateMaster = [arr stringForColumn:@"CONTACTDATA_USER_EVALUATEMASTER"];
        fansModel.strUserEvaluateEmployee = [arr stringForColumn:@"CONTACTDATA_USER_EVALUATEEMPLOYEE"];
        fansModel.strUserAnnear = [arr stringForColumn:@"CONTACTDATA_ANNEAR"];
        fansModel.strUserPost = [arr stringForColumn:@"CONTACTDATA_USER_POST"];
        
        [arrFans addObject:fansModel];
    }
    
    //分组显示
    int m = 0;//组数
    for(int i=0;i<arrFans.count;i++)
    {
        NSString *strTemp = [[arrFans objectAtIndex:i] strUserSpell];//获取ABC
        if(i == 0)
        {
            [arrSection addObject:[[strTemp substringToIndex:1]uppercaseString]];
            [arrSectionNum addObject:[NSString stringWithFormat:@"%d",i]];
            m++;
        }
        else if(![[arrSection objectAtIndex:m-1] isEqualToString:[[strTemp substringToIndex:1]uppercaseString]])//新分组
        {
            [arrSection addObject:[[strTemp substringToIndex:1]uppercaseString]];
            [arrSectionNum addObject:[NSString stringWithFormat:@"%d",i]];
            m++;
        }
    }
    return YES;
}

-(void)getMyFansFromNetwork
{
    NSString *sql = [NSString stringWithFormat:@"select TIMEFRAME_TABLE_TIME from TIMEFRAME where TIMEFRAME_TABLE_NAME = 'CONTACTFANS'"];
    FMResultSet *arr = [[Ty_DbMethod shareDbService] selectData:sql];
    strTime = [[NSString alloc]init];
    while ([arr next])
    {
        strTime = [arr stringForColumn:@"TIMEFRAME_TABLE_TIME"];//我关注的人
    }
    
    NSMutableDictionary *dicServer = [[NSMutableDictionary alloc]init];
    [dicServer setValue:MyLoginUserGuid forKey:@"userGuid"];
    [dicServer setValue:strTime forKey:@"updateTime"];
    [[Ty_NetRequestService shareNetWork] formRequest:My_MyFans_Req andParameterDic:dicServer andTarget:self andSeletor:@selector(getMyFans: dic:)];
}

-(void)getMyFans:(NSString *)_result dic:(NSDictionary *)_dic
{
    if([_result isEqualToString:REQUESTFAIL])
    {
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:@"0" forKey:@"number"];
        
        PostNetNotification(objectDic, @"Ty_MyFansView");
    }
    else if([[_dic objectForKey:@"code"]intValue] == 200)
    {
        BOOL change=NO;
        
        if([_dic objectForKey:@"rows"])
        {
            change = YES;
            for(int i=0;i<[[_dic objectForKey:@"rows"] count];i++)
            {
                NSMutableDictionary *dicRow = [[NSMutableDictionary alloc]init];
                dicRow = [[_dic objectForKey:@"rows"] objectAtIndex:i];
                
                //保存之前查询是否存在
                NSString *sql = [NSString stringWithFormat:@"select count(*) from CONTACTDATA where CONTACTDATA_FANS_USER_GUID = '%@'",[dicRow objectForKey:@"userGuid"]];
                FMResultSet *arr = [[Ty_DbMethod shareDbService] selectData:sql];
                
                [arr next];
                int n = [arr intForColumnIndex:0];
                
                if(n)//更新数据
                {
                    NSString *sql_update = [NSString stringWithFormat:@"update CONTACTDATA set CONTACTDATA_USER_NAME = '%@',CONTACTDATA_USER_SPELL = '%@',CONTACTDATA_USER_TYPE = '%@',CONTACTDATA_USER_SEX = '%@',CONTACTDATA_USER_POST = '%@' where CONTACTDATA_FANS_USER_GUID = '%@'",
                                            [dicRow objectForKey:@"userName"],
                                            [dicRow objectForKey:@"userSpell"],
                                            [dicRow objectForKey:@"userType"],
                                            [dicRow objectForKey:@"userSex"],
                                            [dicRow objectForKey:@"userPost"],
                                            [dicRow objectForKey:@"userGuid"]];
                    [[Ty_DbMethod shareDbService] updateData:sql_update];
                }
                else//插入数据
                {
                    NSString *sql = [NSString stringWithFormat:@"insert into CONTACTDATA (CONTACTDATA_ATTENTION_USER_GUID,CONTACTDATA_FANS_USER_GUID,CONTACTDATA_USER_NAME,CONTACTDATA_USER_SPELL,CONTACTDATA_USER_COMPANY,CONTACTDATA_INTERMEDIARY_NAME,CONTACTDATA_USER_PHOTO,CONTACTDATA_USER_BIG_PHOTO,CONTACTDATA_USER_TAG,CONTACTDATA_USER_TYPE,CONTACTDATA_USER_SEX,CONTACTDATA_USER_REALNAME,CONTACTDATA_USER_EVALUATEMASTER,CONTACTDATA_USER_EVALUATEEMPLOYEE,CONTACTDATA_ANNEAR,CONTACTDATA_USER_ADDRESS,CONTACTDATA_LNG,CONTACTDATA_LAT,CONTACTDATA_USER_SERVE_QUALITY,CONTACTDATA_USER_SERVE_ATTITUDE,CONTACTDATA_USER_SERVE_SPEED,CONTACTDATA_DETAIL_IDCARD,CONTACTDATA_DETAIL_RECORD,CONTACTDATA_DETAIL_CENSUS,CONTACTDATA_USER_SERVE_SIZE,CONTACTDATA_USER_POST) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",
                                     MyLoginUserGuid,
                                     [dicRow objectForKey:@"userGuid"],
                                     [dicRow objectForKey:@"userName"],
                                     [dicRow objectForKey:@"userSpell"],
                                     [dicRow objectForKey:@"userCompany"],
                                     [dicRow objectForKey:@"intermediaryName"],
                                     [dicRow objectForKey:@"userPhoto"],
                                     [dicRow objectForKey:@"userBigPhoto"],
                                     [dicRow objectForKey:@"contactTag"],
                                     [dicRow objectForKey:@"userType"],
                                     [dicRow objectForKey:@"userSex"],
                                     [dicRow objectForKey:@"userRealName"],
                                     [dicRow objectForKey:@"userEvaluateMaster"],
                                     [dicRow objectForKey:@"userEvaluateEmployee"],
                                     [dicRow objectForKey:@"userAnnear"],
                                     [dicRow objectForKey:@"userAddressDetail"],
                                     [dicRow objectForKey:@"lng"],
                                     [dicRow objectForKey:@"lat"],
                                     [dicRow objectForKey:@"userServeQuality"],
                                     [dicRow objectForKey:@"userServeAttitude"],
                                     [dicRow objectForKey:@"userServeSpeed"],
                                     [dicRow objectForKey:@"detailIdcard"],
                                     [dicRow objectForKey:@"detailRecord"],
                                     [dicRow objectForKey:@"detailCensus"],
                                     [dicRow objectForKey:@"userServeSize"],
                                     [dicRow objectForKey:@"userPost"]];
                    [[Ty_DbMethod shareDbService] insertData:sql];
                }
            }
        }
        
        if([_dic objectForKey:@"deletes"])
        {
            change = YES;
            
            NSArray *arrDelete = [[_dic objectForKey:@"deletes"] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
            NSMutableString *sql_delete = [NSMutableString stringWithFormat:@"delete from CONTACTDATA where"];//搜索语句
            if(arrDelete.count == 0)
            {
                sql_delete = [NSMutableString stringWithFormat:@"%@ CONTACTDATA_FANS_USER_GUID = '%@'",sql_delete,[_dic objectForKey:@"deletes"]];
            }
            else
            {
                sql_delete = [NSMutableString stringWithFormat:@"%@ CONTACTDATA_FANS_USER_GUID = '%@'",sql_delete,[arrDelete objectAtIndex:0]];
                
                for(int i=1;i<arrDelete.count;i++)
                {
                    sql_delete = [NSMutableString stringWithFormat:@"%@ or CONTACTDATA_FANS_USER_GUID = '%@'",sql_delete,[arrDelete objectAtIndex:i]];
                }
            }
            
            //本地数据库删除
            [[Ty_DbMethod shareDbService] deleteData:sql_delete];
        }
        
        //获取时间戳
        NSArray *arrUpdateTime = [[_dic objectForKey:@"updateTime"] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"- :"]];
        NSString *strUpdateDate = [NSString stringWithFormat:@"%@-%@-%@ %d:%@:%@",[arrUpdateTime objectAtIndex:0],[arrUpdateTime objectAtIndex:1],[arrUpdateTime objectAtIndex:2],[[arrUpdateTime objectAtIndex:3]intValue],[arrUpdateTime objectAtIndex:4],[arrUpdateTime objectAtIndex:5]];
        
        BOOL result = [strUpdateDate compare:strTime] == NSOrderedDescending;
        
        if(result)
        {
            //更新时间戳
            NSString *sql_update = [NSString stringWithFormat:@"update TIMEFRAME set TIMEFRAME_TABLE_TIME = '%@' where TIMEFRAME_TABLE_NAME = 'CONTACTFANS'",strUpdateDate];
            [[Ty_DbMethod shareDbService] updateData:sql_update];
        }
        
        if(change)
        {
            //获取本地数据
            [self getMyFansFromSqlWithSearch:@""];
        }
        
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:@"200" forKey:@"number"];
        
        PostNetNotification(objectDic, @"Ty_MyFansView");
    }
    else if([[_dic objectForKey:@"code"]intValue] == 203)
    {
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:@"203" forKey:@"number"];
        
        PostNetNotification(objectDic, @"Ty_MyFansView");
    }
    else
    {
        NSMutableDictionary * objectDic = [[NSMutableDictionary alloc]init];
        [objectDic setObject:[_dic objectForKey:@"code"] forKey:@"number"];
        
        PostNetNotification(objectDic, @"Ty_MyFansView");
    }
}
-(void)freshData
{
    arrFans = [[NSMutableArray alloc]init];
    arrSection = [[NSMutableArray alloc]init];
    arrSectionNum  = [[NSMutableArray alloc]init];
}
@end