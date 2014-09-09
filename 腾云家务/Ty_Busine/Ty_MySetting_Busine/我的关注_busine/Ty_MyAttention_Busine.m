//
//  Ty_MyAttention_Busine.m
//  腾云家务
//
//  Created by Xu Zhao on 14-6-3.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_MyAttention_Busine.h"

@implementation Ty_MyAttention_Busine
@synthesize arrAttention;
@synthesize arrSection;
@synthesize arrSectionNum;
- (instancetype)init
{
    self = [super init];
    if (self) {
        arrAttention = [[NSMutableArray alloc]init];
        arrSection = [[NSMutableArray alloc]init];
        arrSectionNum = [[NSMutableArray alloc]init];
    }
    return self;
}
-(void)getMyAttentionFromSqlWithSearch:(NSString *)_search
{
    [arrAttention removeAllObjects];
    [arrSection removeAllObjects];
    [arrSectionNum removeAllObjects];
    
    NSString *sql = [NSString stringWithFormat:@"select CONTACTDATA_ATTENTION_USER_GUID,CONTACTDATA_FANS_USER_GUID,CONTACTDATA_USER_NAME,CONTACTDATA_USER_SPELL,CONTACTDATA_USER_COMPANY,CONTACTDATA_INTERMEDIARY_NAME,CONTACTDATA_USER_PHOTO,CONTACTDATA_USER_BIG_PHOTO,CONTACTDATA_USER_TYPE,CONTACTDATA_USER_SEX,CONTACTDATA_USER_REALNAME,CONTACTDATA_USER_EVALUATEMASTER,CONTACTDATA_USER_EVALUATEEMPLOYEE,CONTACTDATA_USER_POST from CONTACTDATA where CONTACTDATA_ATTENTION_USER_GUID <> '%@' %@ order by CONTACTDATA_USER_SPELL",MyLoginUserGuid,_search];
    FMResultSet *arr = [[Ty_DbMethod shareDbService] selectData:sql];
    
    while ([arr next])
    {
        My_AttentionModel *myAttention = [[My_AttentionModel alloc]init];
        //Ty_MyAttention_Busine *myAttention = [[Ty_MyAttention_Busine alloc]init];
        myAttention.strAttentionGuid = [arr stringForColumn:@"CONTACTDATA_ATTENTION_USER_GUID"];//我关注的人
        myAttention.strFansGuid = [arr stringForColumn:@"CONTACTDATA_FANS_USER_GUID"];//我
        myAttention.strUserName = [arr stringForColumn:@"CONTACTDATA_USER_NAME"];
        myAttention.strUserSpell = [arr stringForColumn:@"CONTACTDATA_USER_SPELL"];
        myAttention.strUserCompany = [arr stringForColumn:@"CONTACTDATA_USER_COMPANY"];
        myAttention.strIntermediaryName = [arr stringForColumn:@"CONTACTDATA_INTERMEDIARY_NAME"];
        myAttention.strUserPhoto = [arr stringForColumn:@"CONTACTDATA_USER_PHOTO"];
        myAttention.strUserBigPhoto = [arr stringForColumn:@"CONTACTDATA_USER_BIG_PHOTO"];
        myAttention.strUserType = [arr stringForColumn:@"CONTACTDATA_USER_TYPE"];
        myAttention.strUserSex = [arr stringForColumn:@"CONTACTDATA_USER_SEX"];
        myAttention.strUserRealName = [arr stringForColumn:@"CONTACTDATA_USER_REALNAME"];
        myAttention.strUserEvaluateMaster = [arr stringForColumn:@"CONTACTDATA_USER_EVALUATEMASTER"];
        myAttention.strUserEvaluateEmployee = [arr stringForColumn:@"CONTACTDATA_USER_EVALUATEEMPLOYEE"];
        myAttention.strUserPost = [arr stringForColumn:@"CONTACTDATA_USER_POST"];
        
        [arrAttention addObject:myAttention];
    }
    
    //分组显示
    int m = 0;//组数
    for(int i=0;i<arrAttention.count;i++)
    {
        NSString *strTemp = [[arrAttention objectAtIndex:i] strUserSpell];
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
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MyAttention_updateTableview" object:nil];
}

-(void)getMyAttentionFromNetwork
{
    NSString *sql = [NSString stringWithFormat:@"select TIMEFRAME_TABLE_TIME from TIMEFRAME where TIMEFRAME_TABLE_NAME = 'CONTACTATTENTION'"];
    FMResultSet *arr = [[Ty_DbMethod shareDbService] selectData:sql];
    strTime = [[NSString alloc]init];
    while ([arr next])
    {
        strTime = [arr stringForColumn:@"TIMEFRAME_TABLE_TIME"];//我关注的人
    }
    
    NSMutableDictionary *dicServer = [[NSMutableDictionary alloc]init];
    [dicServer setValue:MyLoginUserGuid forKey:@"userGuid"];
    [dicServer setValue:strTime forKey:@"updateTime"];
    [[Ty_NetRequestService shareNetWork] formRequest:My_MyAttention_Req andParameterDic:dicServer andTarget:self andSeletor:@selector(getMyAttention: dic:)];
}

-(void)getMyAttention:(NSString *)_result dic:(NSDictionary *)_dic
{
    if(![_result isEqualToString:REQUESTSUCCESS])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MyAttention_updateTableview_fail" object:nil];
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
                NSString *sql = [NSString stringWithFormat:@"select count(*) from CONTACTDATA where CONTACTDATA_ATTENTION_USER_GUID = '%@'",[dicRow objectForKey:@"userGuid"]];
                FMResultSet *arr = [[Ty_DbMethod shareDbService] selectData:sql];
                
                [arr next];
                int n = [arr intForColumnIndex:0];

                if(n)//更新数据
                {
                    NSString *sql_update = [NSString stringWithFormat:@"update CONTACTDATA set CONTACTDATA_USER_NAME = '%@',CONTACTDATA_USER_SPELL = '%@',CONTACTDATA_USER_TYPE = '%@',CONTACTDATA_USER_SEX = '%@',CONTACTDATA_USER_POST = '%@' where CONTACTDATA_ATTENTION_USER_GUID = '%@'",
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
                                     [dicRow objectForKey:@"userGuid"],
                                     MyLoginUserGuid,
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
        
        if(![[_dic objectForKey:@"deletes"] isEqualToString:@""])
        {
            change = YES;
            
            NSArray *arrDelete = [[_dic objectForKey:@"deletes"] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
            NSMutableString *sql_delete = [NSMutableString stringWithFormat:@"delete from CONTACTDATA where"];//搜索语句
            if(arrDelete.count == 0)
            {
                sql_delete = [NSMutableString stringWithFormat:@"%@ CONTACTDATA_ATTENTION_USER_GUID = '%@'",sql_delete,[_dic objectForKey:@"deletes"]];
            }
            else
            {
                sql_delete = [NSMutableString stringWithFormat:@"%@ CONTACTDATA_ATTENTION_USER_GUID = '%@'",sql_delete,[arrDelete objectAtIndex:0]];
                
                for(int i=1;i<arrDelete.count;i++)
                {
                    sql_delete = [NSMutableString stringWithFormat:@"%@ or CONTACTDATA_ATTENTION_USER_GUID = '%@'",sql_delete,[arrDelete objectAtIndex:i]];
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
            NSString *sql_update = [NSString stringWithFormat:@"update TIMEFRAME set TIMEFRAME_TABLE_TIME = '%@' where TIMEFRAME_TABLE_NAME = 'CONTACTATTENTION'",strUpdateDate];
            [[Ty_DbMethod shareDbService] updateData:sql_update];
        }
        
        if(change)
        {
            //获取本地数据
            [self getMyAttentionFromSqlWithSearch:@""];
        }
    }
    else if([[_dic objectForKey:@"code"]intValue] == 203)
        ;
    else
        ;
}

@end
