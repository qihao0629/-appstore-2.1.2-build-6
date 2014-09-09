//
//  Ty_DbMethod.m
//  腾云家务
//
//  Created by 齐 浩 on 14-5-29.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_DbMethod.h"
@implementation Ty_DbMethod
static Ty_DbMethod *dbService;

+ (Ty_DbMethod *)shareDbService
{
    
//    static dispatch_once_t  onceToken;
//    
//    dispatch_once(&onceToken, ^{
//        
//        dbService = [[Ty_DbMethod alloc]init];
//        
//    });
    
    if (dbService==nil) {
        dbService=[[Ty_DbMethod alloc]init];
    }
    return dbService;
}
-(NSString*)dataFilePath{
    NSString * doc = PATH_OF_DOCUMENT;
    NSString * path = [[NSString alloc]init];
    
    if(IFLOGINYES)
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        path = [doc stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",MyLoginUserGuid]];
        if (![fileManager fileExistsAtPath:path])
        {
            [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        path = [doc stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@/tengyun.sqlite",MyLoginUserGuid]];
    }
    else
        path = [doc stringByAppendingPathComponent:@"tengyun.sqlite"];
    
    return path;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        dbPath=[self dataFilePath];
        db = [FMDatabase databaseWithPath:dbPath];
        [self creatBaseTable];
    }
    return self;
}
-(void)releaseDbService
{
    dbService=nil;
}
-(void)creatBaseTable
{
    NSString *Timeframe = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ TEXT PRIMARY KEY,%@ TEXT);",TIMEFRAME,
                           TIMEFRAME_TABLE_NAME,
                           TIMEFRAME_TABLE_TIME];
    [self creatTable:Timeframe];

    //我的关注
    NSString *sql_CONTACTDATA = [NSString stringWithFormat:@"insert into TIMEFRAME (TIMEFRAME_TABLE_NAME,TIMEFRAME_TABLE_TIME)values('%@','%@')",
                                 @"CONTACTATTENTION",
                                 @"2000-01-01 00:00:00"];
    [self insertData:sql_CONTACTDATA];
    
    //我的粉丝
    NSString *sql_CONTACTFANS = [NSString stringWithFormat:@"insert into TIMEFRAME (TIMEFRAME_TABLE_NAME,TIMEFRAME_TABLE_TIME)values('%@','%@')",
                                 @"CONTACTFANS",
                                 @"2000-01-01 00:00:00"];
    [self insertData:sql_CONTACTFANS];
    
    //关注粉丝表
    NSString *ContactData = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT);",CONTACTDATA,CONTACTDATA_ID,CONTACTDATA_ATTENTION_USER_GUID,CONTACTDATA_FANS_USER_GUID,CONTACTDATA_USER_NAME,CONTACTDATA_USER_SPELL,CONTACTDATA_USER_COMPANY,CONTACTDATA_INTERMEDIARY_NAME,CONTACTDATA_USER_PHOTO,CONTACTDATA_USER_BIG_PHOTO,CONTACTDATA_USER_TAG,CONTACTDATA_USER_TYPE,CONTACTDATA_USER_SEX,CONTACTDATA_USER_REALNAME,CONTACTDATA_USER_EVALUATEMASTER,CONTACTDATA_USER_EVALUATEEMPLOYEE,CONTACTDATA_ANNEAR,CONTACTDATA_USER_ADDRESS,CONTACTDATA_LNG,CONTACTDATA_LAT,CONTACTDATA_USER_SERVE_QUALITY,CONTACTDATA_USER_SERVE_ATTITUDE,CONTACTDATA_USER_SERVE_SPEED,CONTACTDATA_DETAIL_IDCARD,CONTACTDATA_DETAIL_RECORD,CONTACTDATA_DETAIL_CENSUS,CONTACTDATA_USER_SERVE_SIZE,CONTACTDATA_USER_POST];
    [self creatTable:ContactData];

    [self createSystemMessageTable];
    
    [self creatSearchMarkTable];
    
    [self createMessageTable];
    [self createMessageContactTable];
    [self createLifeTipsTable];
    
    [self createRequirementDetail];
    [self createOrderPerson];
    [self createOrderCoupon];
    [self createEvaluate];
    [self createPhone];
    [self createLifeTipsTimeStampTable];
}
//创建需求详情表
-(void)createRequirementDetail
{
    //创建需求详情表
    NSString * requirementDetailSql =[NSString stringWithFormat:@"CREATE TABLE REQUIREMENT (%@ text primary key,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text)",REQUIREMENT_GUID,REQUIREMENT_NUMBER,REQUIREMENT_STAGE,REQUIREMENT_TYPE,REQUIREMENT_USER_TYPE,REQUIREMENT_CANDIDATE_STATUS,REQUIREMENT_WORK_GUID,REQUIREMENT_EVALUATE_STAGE,REQUIREMENT_WORK_NAME,REQUIREMENT_PUBLISH_USERGUID,REQUIREMENT_PUBLISH_USERNAME,REQUIREMENT_PUBLISH_USERREALNAME,REQUIREMENT_PUBLISH_USERSEX,REQUIREMENT_PUBLISH_USERTYPE,REQUIREMENT_PUBLISH_USERPHOTO,REQUIREMENT_PUBLISH_USEREVALUATE,REQUIREMENT_PUBLISH_USER_ANNEAR,REQUIRELMENT_ADDRESS,REQUIRELMENT_ADDRESS_DETAIL,REQUIREMENT_PUBLISH_TIME,REQUIREMENT_START_TIME,REQUIREMENT_END_TIME,REQUIREMENT_PRICE_UNIT,REQUIREMENT_PAY_STAGE,REQUIREMENT_DEAL_PRICE,REQUIREMENT_WORK_AMOUNT,REQUIREMENT_CONNECT_NAME,REQUIREMENT_CONECT_IPHONE,REQUIREMENT_ASK_PRICE,REQUIREMENT_ASK_AGE,REQUIREMENT_ASK_SEX,REQUIREMENT_ASK_EDUCATION,REQUIREMENT_ASK_NATION,REQUIREMENT_ASK_EXPERIENCE,REQUIREMENT_ASK_CENSUS,REQUIREMENT_ASK_OTHER,REQUIREMENT_OLD_ORDER_USER_REALNAME,REQUIREMENT_UPDATE_TIME];
    [self creatTable: requirementDetailSql];
}
//创建预约人表
-(void)createOrderPerson
{
    //创建预约人的表
    NSString * orderPersonSql = [NSString stringWithFormat:@"CREATE TABLE ORDER_PERSON (%@ INTEGER PRIMARY KEY AUTOINCREMENT,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text)",ORDER_PERSON_ID,ORDER_PERSON_REQUIREMENT_GUID,ORDER_PERSON_USER_GUID,ORDER_PERSON_USER_NAME,ORDER_PERSON_USER_REALNAME,ORDER_PERSON_USER_TYPE,ORDER_PERSON_USER_SEX,ORDER_PERSON_USER_PHOTO,ORDER_PERSON_USER_EVALUATE,ORDER_PERSON_USER_PHONE_NUMBER,ORDER_PERSON_USER_TAG,ORDER_PERSON_QUOTE,ORDER_PERSON_USER_SERVICE_COUNT,ORDER_PERSON_YZ_TIME,ORDER_PERSON_COMPANY_USER_GUID,ORDER_PERSON_COMPANY_USER_NAME,ORDER_PERSON_COMPANY_USER_REALNAME,ORDER_PERSON_COMPANY_USER_PHOTO,ORDER_PERSON_COMPANY_PHONE,ORDER_PERSON_COMPANY_USER_ANNEAR];
    
    [self creatTable:orderPersonSql];
}
//创建评价表
-(void)createEvaluate
{
    //创建评价表
    NSString * evaluateSql =[NSString stringWithFormat:@"CREATE TABLE EVALUATE (%@ text primary key,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text)",EVALUATE_REQUIREMENT_GUID,
                             EVALUATE_FOR_EMPLOYEE,
                             EVALUATE_FOR_EMPLOYEE_OTHER,
                             EVALUATE_SERVE_QUALITY,
                             EVALUATE_SERVE_ATTITUDE,
                             EVALUATE_SERVE_SPEED,
                             EVALUATE_FOR_EMPLOYEE_TIME,
                             EVALUATE_FOR_EMPLOYER,
                             EVALUATE_FOR_EMPLOYER_OTHER,
                             EVALUATE_FOR_EMPLOYER_TIME];
    [self creatTable:evaluateSql];
}
//创建预约的优惠券表
-(void)createOrderCoupon
{
    NSString * orderCouponSql = [NSString stringWithFormat:@"CREATE TABLE ORDER_COUPON (%@ INTEGER PRIMARY KEY AUTOINCREMENT,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text,%@ text)",
                                 ORDER_COUPON_ID,
                                 ORDER_COUPON_REQUIREMENTGUID,
                                 ORDER_COUPON_GUID,
                                 ORDER_COUPON_TYPE,
                                 ORDER_COUPON_TITLE,
                                 ORDER_COUPON_DETAIL,
                                 ORDER_COUPON_NUMBER,
                                 ORDER_COUPON_ENDTIME,
                                 ORDER_COUPON_USEDTIME,
                                 ORDER_COUPON_SUITWORK,
                                 ORDER_COUPON_SUITWORK_TYPE,
                                 ORDER_COUPON_SUITCOMPANY_TYPE,
                                 ORDER_COUPON_PULLPRICE,
                                 ORDER_COUPON_CUTPRICE];
    [self creatTable: orderCouponSql];

}
//创建小贴士数据库
- (void)createLifeTipsTable
{
    NSString *lifeTipsSql = [NSString stringWithFormat:@"create table %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT ,%@ text , %@ text,%@ text,%@ text ,%@ text,%@ text,%@ int)",TBL_LIFETIPS,
                            LifeTips_ID,
                             LifeTips_Guid,
                             LifeTips_Title,
                             LifeTips_Content,
                             LifeTips_ContentImage,
                             LifeTips_Time,
                             LifeTips_TimeStamp,
                             LifeTips_IsRead];
    [self creatTable:lifeTipsSql];
}

#pragma mark ----创建统计电话表
-(void)createPhone
{
    NSString *phoneSql = [NSString stringWithFormat:@"create table %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT ,%@ text , %@ text,%@ text,%@ text)",TBL_Phone,
                             Phone_ID,Phone_MyGuid,Phone_YourGuid,Phone_Number,Phone_Time];
    [self creatTable:phoneSql];
}

//创建小贴士时间戳表
- (void)createLifeTipsTimeStampTable
{
    NSString *sql = [NSString stringWithFormat:@"create table %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT,%@ text)",TBL_TIMESTAMP,@"ID",TimeStamp_LifeTips];
    [self creatTable:sql];
}

//创建系统消息表

-(void)createSystemMessageTable
{
    NSString *systemMessageSql=[NSString stringWithFormat:@"create table %@(%@ INTEGER PRIMARY KEY AUTOINCREMENT,%@ text,%@ text,%@ text,%@ int, %@ int)",SYSTEMMESSAGE,SysTemMessage_ID,SysTemMessage_Time,SysTemMessage_Message,SysTemMessage_ReqGuid,SysTemMessage_ReqType,SysTemMessage_IsRead];
    [self creatTable:systemMessageSql];
}

//创建信息表
- (void)createMessageTable
{
    // 信息表
    NSString *messageSql = [NSString stringWithFormat:@"create table %@ (%@ text , %@ text,%@ text,%@ text,%@ text,%@ text , %@ text,%@ text, %@ text,%@ int ,%@ int,%@ int,%@ int,%@ int ,%@ int,%@ int ,%@ int,%@ int,%@ text) ",TBL_MESSAGE,Message_Guid,Message_Time,Message_ContactGuid,Message_ContactName,Message_ContactRealName,Message_SenderGuid,Message_Content,Message_VoiceServicePath,Message_ContactPhoto,Message_ContactType,Message_ContactSex,Message_Type,Message_IsRead,Message_IsSendSuccess,Message_IsVoiceRead,Message_IsDelete,Message_IsDownloadSuccess,Message_IsGroupDelete,Message_UserAnnear];
    [self creatTable:messageSql];
}

//创建信息相关的人员表
- (void)createMessageContactTable
{
    //与信息关联的联系人信息表
    NSString *messageContactSql = [NSString stringWithFormat:@"create table %@ (%@ text,%@ text,%@ int,%@ text)",TBL_MSG_CONTACTINFO,Msg_ContactGuid,Msg_ContactRealName,Msg_ContactSex,Msg_ContactPhoto];
    [self creatTable:messageContactSql];
}

//创建搜索记录表
-(void)creatSearchMarkTable
{
    NSString* searchMarkString=[NSString stringWithFormat:@"CREATE TABLE %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT,%@ text)",SEARCHMARK,SEARCHMARK_ID,SEARCHMARK_MESSAGE];
    [self creatTable:searchMarkString];

}

-(BOOL)creatTable:(NSString*)_sql
{
    if ([db open]) {
        NSString * sql = _sql;
        BOOL res = [db executeUpdate:sql];
        [db close];
        if (!res) {
            NSLog(@"error when creating db table");
            return NO;
        } else {
            NSLog(@"succ to creating db table");
            return YES;
        }
    } else {
        NSLog(@"error when open db");
        return NO;
    }
    
}

#pragma mark ----常用添删改查
- (BOOL)insertData:(NSString*)_sql {
    if ([db open]) {
        NSString * sql = _sql;
        BOOL res = [db executeUpdate:sql];
        [db close];
        if (!res) {
            NSLog(@"error to insert data");
            return NO;
        } else {
            NSLog(@"succ to insert data");
            return YES;
        }
    }else{
        NSLog(@"error when open db");
        return NO;
    }
}

- (BOOL)deleteData:(NSString*)_sql {
    if ([db open]) {
        NSString * sql = _sql;
        BOOL res = [db executeUpdate:sql];
        [db close];
        if (!res){
            NSLog(@"error to delete data");
            return NO;
        } else {
            NSLog(@"succ to delete data");
            return YES;
        }
    }else{
        NSLog(@"error when open db");
        return NO;
    }
}
- (FMResultSet*)selectData:(NSString*)_sql {
    if ([db open]) {
        NSString * sql = _sql;
        FMResultSet * rs = [db executeQuery:sql];
        return rs;
        [db close];
    }else{
        NSLog(@"error when open db");
    }
    return nil;
}
- (BOOL)updateData:(NSString*)_sql {
    if ([db open]) {
        NSString * sql = _sql;
        BOOL res = [db executeUpdate:sql];
        [db close];
        if (!res) {
            NSLog(@"error to update data");
            return NO;
        } else {
            NSLog(@"succ to update data");
            return YES;
        }
    }else{
        NSLog(@"error when open db");
        return NO;
    }
}



@end
