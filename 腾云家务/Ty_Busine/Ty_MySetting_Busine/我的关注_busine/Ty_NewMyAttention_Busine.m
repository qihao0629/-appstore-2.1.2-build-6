//
//  Ty_NewMyAttention_Busine.m
//  腾云家务
//
//  Created by liu on 14-7-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_NewMyAttention_Busine.h"
#import "Ty_DbMethod.h"
#import "Ty_Model_ServiceObject.h"
#import "Ty_Model_WorkNodeInfo.h"

@implementation Ty_NewMyAttention_Busine

- (id)init
{
    if (self =[super init])
    {
        
    }
    
    return self;
}

- (void)insertDataIntoTable:(Ty_Model_ServiceObject *)serviceObject
{
    
    
    NSString *sql1 = [NSString stringWithFormat:@"insert into %@ (%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",CONTACTDATA,
                     CONTACTDATA_ATTENTION_USER_GUID,
                     CONTACTDATA_FANS_USER_GUID,
                     CONTACTDATA_USER_NAME,
                     CONTACTDATA_USER_SPELL,
                     CONTACTDATA_USER_COMPANY,
                     CONTACTDATA_INTERMEDIARY_NAME,
                     CONTACTDATA_USER_PHOTO,
                     CONTACTDATA_USER_BIG_PHOTO,
                     CONTACTDATA_USER_TAG,
                     CONTACTDATA_USER_TYPE,
                     CONTACTDATA_USER_SEX,
                     CONTACTDATA_USER_REALNAME,
                     CONTACTDATA_USER_EVALUATEMASTER,
                     CONTACTDATA_USER_EVALUATEEMPLOYEE,
                     CONTACTDATA_ANNEAR,
                     CONTACTDATA_USER_ADDRESS,
                     CONTACTDATA_LNG,
                     CONTACTDATA_LAT,
                     CONTACTDATA_USER_SERVE_QUALITY,
                     CONTACTDATA_USER_SERVE_ATTITUDE,
                     CONTACTDATA_USER_SERVE_SPEED,
                     CONTACTDATA_DETAIL_IDCARD,
                     CONTACTDATA_DETAIL_RECORD,
                     CONTACTDATA_DETAIL_CENSUS,
                     CONTACTDATA_USER_SERVE_SIZE,
                     CONTACTDATA_USER_POST,
                      
                      serviceObject.userGuid,
                      MyLoginUserGuid,
                      serviceObject.userName,
                      serviceObject.userNameSpell,
                      serviceObject.respectiveCompanies,
                      serviceObject.respectiveCompanies,
                      serviceObject.headPhoto,
                      serviceObject.headPhotoGaoQing,
                      @"",
                      serviceObject.userType,
                      serviceObject.sex,
                      serviceObject.userRealName,
                      @"",
                      @"",
                      @"",
                      serviceObject.addressDetail,
                      serviceObject.longitude,
                      serviceObject.latitude,
                      serviceObject.quality,
                      serviceObject.attitude,
                      serviceObject.speedStr,
                      serviceObject.idCard,
                      serviceObject.evaluate,
                      serviceObject.hometown,
                      @"",
                      serviceObject.userPost];
    
    [[Ty_DbMethod shareDbService]insertData:sql1];
}

- (void)getAllContactData:(NSMutableDictionary *)dic byCondition:(Ty_Model_WorkNodeInfo *)nodeInfo
{
    
    NSString *sql ;
    if (nodeInfo == nil)
    {
        sql = [NSString stringWithFormat:@"select * from %@ ",CONTACTDATA];
    }
    else
    {
        if (nodeInfo.childNodeArr.count == 0)
        {
            sql = [NSString stringWithFormat:@"select * from %@ where %@ like '%%%@%%'",CONTACTDATA,CONTACTDATA_USER_POST,nodeInfo.workNodeName];
        }
        else
        {
            NSString *conditionStr = @"";
            for (int i = 0 ; i < nodeInfo.childNodeArr.count; i ++)
            {
                Ty_Model_WorkNodeInfo *node = [nodeInfo.childNodeArr objectAtIndex:i];
                conditionStr = [conditionStr stringByAppendingFormat:@" %@ like '%%%@%%'  ",CONTACTDATA_USER_POST,node.workNodeName];
                if (i != nodeInfo.childNodeArr.count - 1)
                {
                    conditionStr = [conditionStr stringByAppendingString:@" or"];
                }
            }
            sql = [NSString stringWithFormat:@"select * from %@ where  %@",CONTACTDATA,
                   conditionStr];
            
            
        }
    }
    
    NSMutableArray *array = [NSMutableArray array];
    FMResultSet *resultSet = [[Ty_DbMethod shareDbService]selectData:sql];
    
    while (resultSet.next)
    {
        Ty_Model_ServiceObject *serviceObject = [[Ty_Model_ServiceObject alloc]init];
        
        serviceObject.userGuid = [resultSet stringForColumn:CONTACTDATA_ATTENTION_USER_GUID];
        serviceObject.userName = [resultSet stringForColumn:CONTACTDATA_USER_NAME];
        serviceObject.userPost = [resultSet stringForColumn:CONTACTDATA_USER_POST];
        serviceObject.sex = [resultSet stringForColumn:CONTACTDATA_USER_SEX];
        serviceObject.userNameSpell = [resultSet stringForColumn:CONTACTDATA_USER_SPELL];
        serviceObject.userType = [resultSet stringForColumn:CONTACTDATA_USER_TYPE];
        serviceObject.headPhoto = [resultSet stringForColumn:CONTACTDATA_USER_PHOTO];
        serviceObject.respectiveCompanies = [resultSet stringForColumn:CONTACTDATA_USER_COMPANY];
        serviceObject.userRealName = [resultSet stringForColumn:CONTACTDATA_USER_REALNAME];
        
        [array addObject:serviceObject];
        serviceObject = nil;
    }
    
    for (Ty_Model_ServiceObject *serviceObject in array)
    {
        NSString *contactPinyin = [serviceObject.userNameSpell substringToIndex:1];
        contactPinyin = [contactPinyin uppercaseString];
        
        if ([dic objectForKey:contactPinyin] == nil)
        {
            [dic setObject:[NSMutableArray array] forKey:contactPinyin];
        }
        
        NSMutableArray *contactArr = [dic objectForKey:contactPinyin];
        if (![contactArr containsObject:serviceObject])
        {
            [contactArr addObject:serviceObject];
        }
        
    }
    
}

- (void)searchContact:(NSMutableDictionary *)dic byCondition:(NSString *)conditionStr
{
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where %@ like '%%%@%%' or %@ like '%%%@%%' or %@ like '%%%@%%' or %@ like '%%%@%%' ",CONTACTDATA,
                     CONTACTDATA_USER_REALNAME,conditionStr,
                     CONTACTDATA_USER_COMPANY,conditionStr,
                     CONTACTDATA_USER_SPELL,conditionStr,
                     CONTACTDATA_USER_POST,conditionStr];
    
    NSMutableArray *array = [NSMutableArray array];
    FMResultSet *resultSet = [[Ty_DbMethod shareDbService]selectData:sql];
    
    while (resultSet.next)
    {
        Ty_Model_ServiceObject *serviceObject = [[Ty_Model_ServiceObject alloc]init];
        
        serviceObject.userGuid = [resultSet stringForColumn:CONTACTDATA_ATTENTION_USER_GUID];
        serviceObject.userName = [resultSet stringForColumn:CONTACTDATA_USER_NAME];
        serviceObject.userPost = [resultSet stringForColumn:CONTACTDATA_USER_POST];
        serviceObject.sex = [resultSet stringForColumn:CONTACTDATA_USER_SEX];
        serviceObject.userNameSpell = [resultSet stringForColumn:CONTACTDATA_USER_SPELL];
        serviceObject.userType = [resultSet stringForColumn:CONTACTDATA_USER_TYPE];
        serviceObject.headPhoto = [resultSet stringForColumn:CONTACTDATA_USER_PHOTO];
        serviceObject.respectiveCompanies = [resultSet stringForColumn:CONTACTDATA_USER_COMPANY];
        serviceObject.userRealName = [resultSet stringForColumn:CONTACTDATA_USER_REALNAME];
        
        [array addObject:serviceObject];
        serviceObject = nil;
    }
    
    for (Ty_Model_ServiceObject *serviceObject in array)
    {
        NSString *contactPinyin = [serviceObject.userNameSpell substringToIndex:1];
        contactPinyin = [contactPinyin uppercaseString];
        
        if ([dic objectForKey:contactPinyin] == nil)
        {
            [dic setObject:[NSMutableArray array] forKey:contactPinyin];
        }
        
        NSMutableArray *contactArr = [dic objectForKey:contactPinyin];
        if (![contactArr containsObject:serviceObject])
        {
            [contactArr addObject:serviceObject];
        }
        
    }

    
}

- (void)deleteContactData:(NSArray *)deleteArr
{
    for (NSString *userGuid in deleteArr)
    {
        NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@ = '%@'",CONTACTDATA,
                         CONTACTDATA_ATTENTION_USER_GUID,
                         userGuid];
        [[Ty_DbMethod shareDbService] deleteData:sql];
    }
    
}

- (void)updateContactData:(Ty_Model_ServiceObject *)serviceObject
{
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@' where %@ = '%@' ",CONTACTDATA,
                     CONTACTDATA_USER_NAME,serviceObject.userName,
                     CONTACTDATA_USER_SPELL,serviceObject.userNameSpell,
                     CONTACTDATA_USER_SEX,serviceObject.sex,
                     CONTACTDATA_USER_POST,serviceObject.userPost,
                     CONTACTDATA_USER_PHOTO,serviceObject.headPhoto,
                     CONTACTDATA_USER_BIG_PHOTO,serviceObject.headPhotoGaoQing,
                     CONTACTDATA_USER_ADDRESS,serviceObject.addressDetail,
                     CONTACTDATA_USER_COMPANY,serviceObject.respectiveCompanies,
                     CONTACTDATA_INTERMEDIARY_NAME,serviceObject.respectiveCompanies,
                     CONTACTDATA_USER_REALNAME,serviceObject.userRealName,
                     CONTACTDATA_ATTENTION_USER_GUID,serviceObject.userGuid];
    
    [[Ty_DbMethod shareDbService] updateData:sql];
}

- (void)updateContactTime:(NSString *)time
{
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ = '%@' where %@ = '%@'",TIMEFRAME,
                     TIMEFRAME_TABLE_TIME,time,
                     TIMEFRAME_TABLE_NAME,@"CONTACTATTENTION"];
    [[Ty_DbMethod shareDbService] updateData:sql];
}

- (BOOL)isExist:(NSString *)contactGuid
{
    BOOL isExist = NO;
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where %@ = '%@'",CONTACTDATA,
                     CONTACTDATA_ATTENTION_USER_GUID,
                     contactGuid];
    FMResultSet *resultSet = [[Ty_DbMethod shareDbService] selectData:sql];
    while (resultSet.next)
    {
        isExist = YES;
    }
    
    return isExist;
}

#pragma mark -- 从网络获取数据
- (void)getContactDataFromNet
{
    NSString *sql = [NSString stringWithFormat:@"select %@ from %@ where %@ = '%@'",TIMEFRAME_TABLE_TIME,
                     TIMEFRAME,
                     TIMEFRAME_TABLE_NAME,
                     @"CONTACTATTENTION"];
    NSString *timeStr = @"";
    FMResultSet *resultSet = [[Ty_DbMethod shareDbService] selectData:sql];
    while (resultSet.next)
    {
        timeStr = [resultSet stringForColumn:TIMEFRAME_TABLE_TIME];
    }
    
    if (timeStr.length == 0)
    {
        timeStr = @"2010-07-01 00:00:00";
    }
    
    [[Ty_NetRequestService shareNetWork] formRequest:My_MyAttention_Req andParameterDic:[NSMutableDictionary dictionaryWithObjectsAndKeys:timeStr,@"updateTime",MyLoginUserGuid,@"userGuid", nil] andTarget:self andSeletor:@selector(getMyAttention:dic:)];
    
}
-(void)getMyAttention:(NSString *)result dic:(NSDictionary *)dic
{
    if ([result isEqualToString:REQUESTFAIL])//请求失败
    {
        
    }
    else
    {
        if ([[dic objectForKey:@"code"]integerValue] == 200)//成功
        {
            Ty_Model_ServiceObject *serviceObject = [[Ty_Model_ServiceObject alloc]init];
            
            
            for (NSMutableDictionary *contactDic in [dic objectForKey:@"rows"])
            {
                
                [self dealWithContactData:contactDic intoContainer:serviceObject];
                
                if ([self isExist:[contactDic objectForKey:@"userGuid"]])//原来存在，更新数据
                {
                    [self updateContactData:serviceObject];
                }
                else//不存在，添加
                {
                    [self insertDataIntoTable:serviceObject];
                }
            }
            
            if (![[dic objectForKey:@"deletes"] isEqualToString:@""])
            {
                NSArray *deleteArr = [[dic objectForKey:@"deletes"] componentsSeparatedByString:@","];
                [self deleteContactData:deleteArr];
            }
            
            
            NSString *updateTime = [dic objectForKey:@"updateTime"];
            [self updateContactTime:updateTime];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"RefreshContactData" object:nil];
        }
        
        
        
    }
}

- (void)dealWithContactData:(NSDictionary *)dic intoContainer:(Ty_Model_ServiceObject *)serviceObject
{
   // intermediaryName
    serviceObject.hometown = [dic objectForKey:@"detailCensus"];
    serviceObject.idCard = [dic objectForKey:@"detailIdcard"];
    serviceObject.education = [dic objectForKey:@"detailRecord"];
    serviceObject.respectiveCompanies = [dic objectForKey:@"intermediaryName"];
    serviceObject.latitude = [dic objectForKey:@"lat"];
    serviceObject.longitude = [dic objectForKey:@"lng"];
    serviceObject.intermediary_AddressDetail = [dic objectForKey:@"userAddressDetail"];
    serviceObject.headPhotoGaoQing = [dic objectForKey:@"userBigPhoto"];
    serviceObject.headPhoto = [dic objectForKey:@"userPhoto"];
    // serviceObject.companyUserName
    serviceObject.userGuid = [dic objectForKey:@"userGuid"];
    serviceObject.userName = [dic objectForKey:@"userName"];
    
    if (serviceObject.respectiveCompanies.length == 0)
    {
        serviceObject.respectiveCompanies = [dic objectForKey:@"userCompany"];
    }
    
    serviceObject.userRealName = [dic objectForKey:@"userRealName"];
    serviceObject.attitude = [dic objectForKey:@"userServeAttitude"];
    serviceObject.quality = [dic objectForKey:@"userServeQuality"];
    serviceObject.userNameSpell = [dic objectForKey:@"userSpell"];
    serviceObject.userType = [dic objectForKey:@"userType"];
    serviceObject.sex = [dic objectForKey:@"userSex"];
    
    serviceObject.userPost = [dic objectForKey:@"userPost"];
    //serviceObject.speedStr = [dic objectForKey:<#(id)#>];
}

@end
