//
//  Ty_News_busine_Order_DataBase.m
//  腾云家务
//
//  Created by lgs on 14-5-29.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_News_busine_Order_DataBase.h"
#import "Ty_DbMethod.h"
#import "My_CouponDetailedModel.h"

static Ty_News_busine_Order_DataBase *busine_Order_DataBase;

@implementation Ty_News_busine_Order_DataBase
@synthesize dataBaseServiceObject;
@synthesize dataBaseXuQiu;

+(Ty_News_busine_Order_DataBase *)share_Busine_DataBase
{
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
    busine_Order_DataBase = [[Ty_News_busine_Order_DataBase alloc]init];
    });

    return busine_Order_DataBase;
}
#pragma mark 需求详情表

-(NSString *)getRequirementUpdateTime:(NSString *)_requirementGuid
{
    NSString * updateTime = @"2000-01-01 00:00:00";
    
    FMResultSet * rs =  [[Ty_DbMethod shareDbService] selectData:[NSString stringWithFormat:@"select * from REQUIREMENT where REQUIREMENT_GUID = '%@'",_requirementGuid]];
    while ([rs next])
    {
        updateTime = [rs stringForColumn:@"REQUIREMENT_UPDATE_TIME"];
    }
    return updateTime;
}
/**保存到数据库中*/
-(void)saveRequirementDetail:(NSMutableDictionary *)_dic andUserType:(NSString *)_userType
{
    NSString * priceString;
    if ([_dic objectForKey:@"rMoney"] == nil || [[_dic objectForKey:@"rMoney"] isEqualToString:@"0"] || [[_dic objectForKey:@"rMoney"]isEqualToString:@"" ] || [[_dic objectForKey:@"rMoney"] isEqualToString:@"(null)"] || [[_dic objectForKey:@"rMoney"] isEqualToString:@"null"])
    {
        priceString = [_dic objectForKey:@"rPostSalary"];
    }
    else
        priceString = [_dic objectForKey:@"rMoney"];

    
    NSString * sql  =[NSString stringWithFormat:@"INSERT INTO REQUIREMENT (%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",
                      REQUIREMENT_GUID,
                      REQUIREMENT_NUMBER,
                      REQUIREMENT_STAGE,
                      REQUIREMENT_TYPE,
                      REQUIREMENT_USER_TYPE,
                      REQUIREMENT_CANDIDATE_STATUS,
                      REQUIREMENT_EVALUATE_STAGE,
                      REQUIREMENT_WORK_GUID,
                      REQUIREMENT_WORK_NAME,
                      REQUIREMENT_PUBLISH_USERGUID,
                      REQUIREMENT_PUBLISH_USERNAME,
                      REQUIREMENT_PUBLISH_USERREALNAME,
                      REQUIREMENT_PUBLISH_USERSEX,
                      REQUIREMENT_PUBLISH_USERTYPE,
                      REQUIREMENT_PUBLISH_USERPHOTO,
                      REQUIREMENT_PUBLISH_USEREVALUATE,
                      REQUIREMENT_PUBLISH_USER_ANNEAR,
                      REQUIRELMENT_ADDRESS,
                      REQUIRELMENT_ADDRESS_DETAIL,
                      REQUIREMENT_PUBLISH_TIME,
                      REQUIREMENT_START_TIME,
                      REQUIREMENT_END_TIME,
                      REQUIREMENT_PRICE_UNIT,
                      REQUIREMENT_PAY_STAGE,
                      REQUIREMENT_DEAL_PRICE,
                      REQUIREMENT_WORK_AMOUNT,
                      REQUIREMENT_CONNECT_NAME,
                      REQUIREMENT_CONECT_IPHONE,
                      REQUIREMENT_ASK_PRICE,
                      REQUIREMENT_ASK_AGE,
                      REQUIREMENT_ASK_SEX,
                      REQUIREMENT_ASK_EDUCATION,
                      REQUIREMENT_ASK_NATION,
                      REQUIREMENT_ASK_EXPERIENCE,
                      REQUIREMENT_ASK_CENSUS,
                      REQUIREMENT_ASK_OTHER,
                      REQUIREMENT_OLD_ORDER_USER_REALNAME,
                      REQUIREMENT_UPDATE_TIME,
                       [_dic objectForKey:@"requirementGuid"],
                       [_dic objectForKey:@"requirementNumber"],
                       [_dic objectForKey:@"requirementStage"],
                       [_dic objectForKey:@"requirementType"],
                      _userType,
                      [_dic objectForKey:@"requirementCandidateStatus"],
                       [_dic objectForKey:@"evaluateState"],
                       [_dic objectForKey:@"requirementWorkGuid"],
                       [_dic objectForKey:@"workName"],
                       [_dic objectForKey:@"userGuid"],
                       [_dic objectForKey:@"userName"],
                       [_dic objectForKey:@"userRealName"],
                       [_dic objectForKey:@"userSex"],/*上个版本没有*/
                       @"2",/*上个版本没有*/
                       [_dic objectForKey:@"userPhoto"],
                      [_dic objectForKey:@"userEvaluate"],//雇主的星级
                      [_dic objectForKey:@"userAnnear"],//锤炼号userAnnear
                       [_dic objectForKey:@"requirementAddress"],
                       [_dic objectForKey:@"requirementAddressDetail"],
                       [_dic objectForKey:@"requirementPublishTime"],
                       [_dic objectForKey:@"requirementStartTime"],
                       [_dic objectForKey:@"requirementEndTime"],
//                       [_dic objectForKey:@"rMoney"],/*没有*/
                      priceString,
                       [_dic objectForKey:@"rIsPay"],//支付状态
                        [_dic objectForKey:@"rDealMoney"],//最后成交价格
                       [_dic objectForKey:@"requirementTimeStage"],
                       [_dic objectForKey:@"requirementContactName"],
                       [_dic objectForKey:@"requirementContactPhone"],
                       [_dic objectForKey:@"requirementSalary"],
                       [_dic objectForKey:@"requirementAskAge"],
                       [_dic objectForKey:@"requirementAskSex"],
                       [_dic objectForKey:@"requirementAskRecord"],
                       [_dic objectForKey:@"requirementAskNation"],
                       [_dic objectForKey:@"requirementAskWork"],
                       [_dic objectForKey:@"requirementAskCensus"],
                       [_dic objectForKey:@"requirementAskOther"],
                      [_dic objectForKey:@"oldEmpName"],
                       [_dic objectForKey:@"requirementUpdateTime"]];
    
    [[Ty_DbMethod shareDbService] insertData:sql];
    
}
/**得到这条需求的详情*/
-(BOOL)getRequirementDetailWithGuid:(NSString *)_requirementGuid
{
    NSString * selectSql = [NSString stringWithFormat:@"SELECT * FROM REQUIREMENT WHERE REQUIREMENT_GUID = '%@'",_requirementGuid];
    FMResultSet * rs =  [[Ty_DbMethod shareDbService] selectData:selectSql];
    [rs stringForColumnIndex:0];
    
    if ([rs next])
    {
//        NSMutableDictionary * requirementDetailDic = [[NSMutableDictionary alloc]init];
//        
//        [requirementDetailDic setObject:[rs stringForColumnIndex:0] forKey:@"requirementGuid"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:1] forKey:@"requirementNumber"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:2] forKey:@"requirementStage"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:3] forKey:@"requirementType"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:4] forKey:@"requirementUserType"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:5] forKey:@"requirementCandidateStatus"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:6] forKey:@"requirementWorkGuid"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:7] forKey:@"evaluateState"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:8]  forKey:@"workName"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:9] forKey:@"userGuid"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:10] forKey:@"userName"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:11] forKey:@"userRealName"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:12] forKey:@"userSex"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:13] forKey:@"userType"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:14] forKey:@"userPhoto"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:15] forKey:@"userEvaluate"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:16] forKey:@"requirementAddress"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:17] forKey:@"requirementAddressDetail"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:18] forKey:@"requirementPublishTime"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:19] forKey:@"requirementStartTime"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:20] forKey:@"requirementEndTime"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:21] forKey:@"requirementUnitPrice"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:22] forKey:@"requirementTimeTotalPrice"];//总价
//        [requirementDetailDic setObject:[rs stringForColumnIndex:23] forKey:@"workAmount"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:24] forKey:@"requirementContactName"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:25] forKey:@"requirementContactPhone"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:26] forKey:@"requirementAskSalary"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:27] forKey:@"requirementAskAge"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:28] forKey:@"requirementAskSex"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:29] forKey:@"requirementAskRecord"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:30] forKey:@"requirementAskNation"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:31] forKey:@"requirementAskWork"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:32] forKey:@"requirementAskCensus"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:33] forKey:@"requirementAskOther"];
//        [requirementDetailDic setObject:[rs stringForColumnIndex:34] forKey:@"requirementUpdateTime"];
        
        if (!dataBaseXuQiu)
        {
            dataBaseXuQiu = [[Ty_Model_XuQiuInfo alloc]init];
        }
        
        dataBaseXuQiu.requirementGuid = [rs stringForColumnIndex:0];
        dataBaseXuQiu.requirementNumber = [rs stringForColumnIndex:1];
        dataBaseXuQiu.requirement_Stage = [rs stringForColumnIndex:2];
        dataBaseXuQiu.requirement_Type = [rs stringForColumnIndex:3];
        dataBaseXuQiu.userTypeBaseOnRequirement = [rs stringForColumnIndex:4];//不对，不过我们可以理解成，基于这条需求，我的身份
        dataBaseXuQiu.candidateStatus = [rs stringForColumnIndex:5];
        dataBaseXuQiu.workGuid = [rs stringForColumnIndex:6];
        dataBaseXuQiu.evaluateStage = [rs stringForColumnIndex:7];
        dataBaseXuQiu.workName = [rs stringForColumnIndex:8];
        dataBaseXuQiu.publishUserGuid = [rs stringForColumnIndex:9];
        dataBaseXuQiu.publishUserName = [rs stringForColumnIndex:10];
        dataBaseXuQiu.publishUsrRealName = [rs stringForColumnIndex:11];
        dataBaseXuQiu.publishUserSex = [rs stringForColumnIndex:12];
        dataBaseXuQiu.publishUserType = [rs stringForColumnIndex:13];
        dataBaseXuQiu.publishUserPhoto = [rs stringForColumnIndex:14];
        dataBaseXuQiu.publishUserEvaluate = [rs stringForColumnIndex:15];
        dataBaseXuQiu.publishUserAnnear = [rs stringForColumnIndex:16];
        
        NSArray * tempAddressArray = [[rs stringForColumnIndex:17]componentsSeparatedByString:@"  "];
        /*
        if ([tempAddressArray count] >=5)
        {
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:0]]))
            {
                dataBaseXuQiu.province = [tempAddressArray objectAtIndex:0];
            }
            else
            {
                dataBaseXuQiu.province = @"";
            }
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:1]]))
            {
                dataBaseXuQiu.city = [tempAddressArray objectAtIndex:1];
            }
            else
            {
                dataBaseXuQiu.city = @"";
            }
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:2]]))
            {
                dataBaseXuQiu.area = [tempAddressArray objectAtIndex:2];
            }
            else
            {
                dataBaseXuQiu.area = @"";
            }
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:3]]))
            {
                dataBaseXuQiu.region = [tempAddressArray objectAtIndex:3];
            }
            else
            {
                dataBaseXuQiu.region = @"";
            }
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:4]]))
            {
                dataBaseXuQiu.addressDetail = [tempAddressArray objectAtIndex:4];
            }
            else
            {
                dataBaseXuQiu.addressDetail = @"";
            }
        }
         */
        
        if ([tempAddressArray count] == 5)
        {
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:0]]))
            {
                dataBaseXuQiu.province = [tempAddressArray objectAtIndex:0];
            }
            else
            {
                dataBaseXuQiu.province = @"";
            }
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:1]]))
            {
                dataBaseXuQiu.city = [tempAddressArray objectAtIndex:1];
            }
            else
            {
                dataBaseXuQiu.city = @"";
            }
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:2]]))
            {
                dataBaseXuQiu.area = [tempAddressArray objectAtIndex:2];
            }
            else
            {
                dataBaseXuQiu.area = @"";
            }
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:3]]))
            {
                dataBaseXuQiu.region = [tempAddressArray objectAtIndex:3];
            }
            else
            {
                dataBaseXuQiu.region = @"";
            }
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:4]]))
            {
                dataBaseXuQiu.addressDetail = [tempAddressArray objectAtIndex:4];
            }
            else
            {
                dataBaseXuQiu.addressDetail = @"";
            }
        }
        else if ([tempAddressArray count] == 4)
        {
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:0]]))
            {
                dataBaseXuQiu.province = [tempAddressArray objectAtIndex:0];
            }
            else
            {
                dataBaseXuQiu.province = @"";
            }
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:1]]))
            {
                dataBaseXuQiu.city = [tempAddressArray objectAtIndex:1];
            }
            else
            {
                dataBaseXuQiu.city = @"";
            }
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:2]]))
            {
                dataBaseXuQiu.area = [tempAddressArray objectAtIndex:2];
            }
            else
            {
                dataBaseXuQiu.area = @"";
            }
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:3]]))
            {
                dataBaseXuQiu.addressDetail = [tempAddressArray objectAtIndex:3];
            }
            else
            {
                dataBaseXuQiu.addressDetail = @"";
            }
        }
        else if ([tempAddressArray count] == 1)
        {//活动预约的bug
            if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:0]]))
            {
                dataBaseXuQiu.addressDetail = [tempAddressArray objectAtIndex:0];
            }
            else
            {
                dataBaseXuQiu.addressDetail = @"";
            }
        }
        else
        {
            dataBaseXuQiu.province = @"";
            dataBaseXuQiu.city = @"";
            dataBaseXuQiu.area = @"";
            dataBaseXuQiu.region = @"";
            dataBaseXuQiu.addressDetail = @"";
        }
        dataBaseXuQiu.submitTime = [rs stringForColumnIndex:19];
        dataBaseXuQiu.startTime = [NSString stringWithFormat:@"%@:00",[rs stringForColumnIndex:20]];
        
        dataBaseXuQiu.priceUnit = [rs stringForColumnIndex:22];
        dataBaseXuQiu.isApply = [rs stringForColumnIndex:23];
        dataBaseXuQiu.realMoney = [rs stringForColumnIndex:24];
        dataBaseXuQiu.workAmount = [rs stringForColumnIndex:25];
        
        dataBaseXuQiu.contact = [rs stringForColumnIndex:26];
        dataBaseXuQiu.contactPhone = [rs stringForColumnIndex:27];
        dataBaseXuQiu.ask_Price = [rs stringForColumnIndex:28];
        dataBaseXuQiu.ask_Age = [rs stringForColumnIndex:29];
        dataBaseXuQiu.ask_Sex = [rs stringForColumnIndex:30];
        dataBaseXuQiu.ask_Education = [rs stringForColumnIndex:31];
        dataBaseXuQiu.ask_Ethnic = [rs stringForColumnIndex:32];//需要确定
        dataBaseXuQiu.ask_WorkExperience = [rs stringForColumnIndex:33];
        dataBaseXuQiu.ask_Hometown = [rs stringForColumnIndex:34];//需要确定
        dataBaseXuQiu.ask_Other = [rs stringForColumnIndex:35];
        dataBaseXuQiu.oldOrderPersonRealName = [rs stringForColumnIndex:36];
        dataBaseXuQiu.updateTime = [rs stringForColumnIndex:37];

        //必须的，否则会出现上次的数据
        dataBaseXuQiu.usedCouponInfo = [[My_CouponDetailedModel alloc] init];
        dataBaseServiceObject = [[Ty_Model_ServiceObject alloc]init];
        
        [self getOrderPersonAndRequirementGuid:_requirementGuid];
        [self getOrderCoupon:_requirementGuid];
        return YES;
    }
    else
    {
        return NO;
    }
}
/**修改这条需求*/
-(void)updateRequirementDetailAndGuid:(NSString *)_requirementGuid ankDic:(NSMutableDictionary *)_dic
{
    
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@' where %@ = '%@'",
                     REQUIREMENT,
                     REQUIREMENT_STAGE,
                     [_dic objectForKey:@"requirementStage"],
                     REQUIREMENT_CANDIDATE_STATUS,
                     [_dic objectForKey:@"requirementCandidateStatus"],
                     REQUIREMENT_EVALUATE_STAGE,
                     [_dic objectForKey:@"evaluateState"],
                     REQUIREMENT_UPDATE_TIME,
                     [_dic objectForKey:@"requirementUpdateTime"],
                     REQUIREMENT_PRICE_UNIT,
                     [_dic objectForKey:@"rMoney"],
                     REQUIREMENT_PAY_STAGE,
                     [_dic objectForKey:@"rIsPay"],
                     REQUIREMENT_DEAL_PRICE,
                     [_dic objectForKey:@"rDealMoney"],
                     REQUIREMENT_OLD_ORDER_USER_REALNAME,
                     [_dic objectForKey:@"oldEmpName"],
                    REQUIREMENT_GUID,
                    [_dic objectForKey:@"requirementGuid"]];
    [[Ty_DbMethod shareDbService] updateData:sql];
}
-(void)updateRequirementDetailAndGuid:(NSString *)_requirementGuid andKeys:(NSMutableArray *)_keys andValues:(NSMutableArray *)_values
{
    int count = [_keys count];
    
    NSMutableString * sql_update = [NSMutableString stringWithString:@"update REQUIREMENT set"];
    for (int tempNum = 0; tempNum < count; tempNum ++)
    {
        NSString * tempStr = [NSString stringWithFormat:@" %@ = '%@',",[_keys objectAtIndex:tempNum],[_values objectAtIndex:tempNum]];
        sql_update =[NSMutableString stringWithString:[sql_update stringByAppendingString:tempStr]];
    }
    sql_update = [NSMutableString stringWithString:[sql_update substringToIndex:([sql_update length] -1)]];
    NSString * tempString = [NSString stringWithFormat:@" where REQUIREMENT_GUID = '%@'",_requirementGuid];

    sql_update =[NSMutableString stringWithString:[sql_update stringByAppendingString:tempString]];
    
    [[Ty_DbMethod shareDbService] updateData:sql_update];
}

#pragma mark 订单的优惠券表
-(void)saveOrderCoupon:(NSMutableDictionary *)_dic withRequiremnetGuid:(NSString *)_requirementGuid
{
    NSString * sql  =[NSString stringWithFormat:@"INSERT INTO ORDER_COUPON (%@,%@,%@,%@,%@) VALUES ('%@','%@','%@','%@','%@')",
                      ORDER_COUPON_REQUIREMENTGUID,
                      ORDER_COUPON_NUMBER,
                      ORDER_COUPON_TYPE,
                      ORDER_COUPON_PULLPRICE,
                      ORDER_COUPON_CUTPRICE,
                      _requirementGuid,
                      [_dic objectForKey:@"couponNo"],
                      [_dic objectForKey:@"couponType"],
                      [_dic objectForKey:@"couponPullPrice"],
                      [_dic objectForKey:@"couponCutPrice"]];

    [[Ty_DbMethod shareDbService] insertData:sql];
}

-(BOOL)getOrderCoupon:(NSString *)_requirementGuid
{
    NSString * selectSql = [NSString stringWithFormat:@"SELECT * FROM ORDER_COUPON WHERE ORDER_COUPON_REQUIREMENTGUID = '%@'",_requirementGuid];
    FMResultSet * rs =  [[Ty_DbMethod shareDbService] selectData:selectSql];
    
    if ([rs next])
    {
        dataBaseXuQiu.usedCouponInfo.couponRequiremnetGuid =[rs stringForColumnIndex:1];
        dataBaseXuQiu.usedCouponInfo.couponType = [rs stringForColumnIndex:3];
        dataBaseXuQiu.usedCouponInfo.couponNo = [rs stringForColumnIndex:6];
        dataBaseXuQiu.usedCouponInfo.couponPullPrice = [rs stringForColumnIndex:12];
        dataBaseXuQiu.usedCouponInfo.couponCutPrice = [rs stringForColumnIndex:13];
        return YES;
    }
    else
        return NO;
}


#pragma mark 评价表相关的一些数据

-(BOOL)judgeIfExitEvaluateWithGuid:(NSString *)_requirementGuid
{
    
    FMResultSet * rs =  [[Ty_DbMethod shareDbService] selectData:[NSString stringWithFormat:@"select * from EVALUATE where EVALUATE_REQUIREMENT_GUID = '%@'",_requirementGuid]];
    while ([rs next])
    {
        return YES;
    }
    return NO;
}

/**插入评价*/
-(void)saveEvaluateAndRequirementGuid:(NSString *)_requirementGuid andEvaluateDic:(NSMutableDictionary *)_evaluateDic
{
    NSString * insertSql = [NSString stringWithFormat:@"INSERT INTO EVALUATE (%@,%@,%@,%@,%@,%@,%@,%@,%@,%@) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",
                            EVALUATE_REQUIREMENT_GUID,
                            EVALUATE_FOR_EMPLOYEE,
                            EVALUATE_FOR_EMPLOYEE_OTHER,
                            EVALUATE_SERVE_QUALITY,
                            EVALUATE_SERVE_ATTITUDE,
                            EVALUATE_SERVE_SPEED,
                            EVALUATE_FOR_EMPLOYEE_TIME,
                            EVALUATE_FOR_EMPLOYER,
                            EVALUATE_FOR_EMPLOYER_OTHER,
                            EVALUATE_FOR_EMPLOYER_TIME,
        _requirementGuid,
        [_evaluateDic objectForKey:@"evaluateForEmployee"],
        [_evaluateDic objectForKey:@"evaluateForEmployeeOther"],
        [_evaluateDic objectForKey:@"evaluateServeQuality"],
        [_evaluateDic objectForKey:@"evaluateServeAttitude"],
        [_evaluateDic objectForKey:@"evaluateServeSpeed"],
                            [_evaluateDic objectForKey:@"evaluateForEmployeeTime"],
                            [_evaluateDic objectForKey:@"evaluateForMaster"],
                            [_evaluateDic objectForKey:@"evaluateForMasterOther"],
                            [_evaluateDic objectForKey:@"evaluateForMasterTime"]];
    [[Ty_DbMethod shareDbService] insertData:insertSql];
}

/**得到评价*/
-(NSMutableDictionary *)getEvaluateAndGuid:(NSString *)_requirementGuid
{
    NSString * selectSql = [NSString stringWithFormat:@"SELECT * FROM EVALUATE WHERE EVALUATE_REQUIREMENT_GUID = '%@'",_requirementGuid];
    FMResultSet * rs = [[Ty_DbMethod shareDbService] selectData:selectSql];
    
    NSMutableDictionary * evaluateDic = [[NSMutableDictionary alloc]init];

    if ([rs next])
    {
        [evaluateDic setObject:_requirementGuid forKey:@"requirementGuid"];
        [evaluateDic setObject:[rs stringForColumnIndex:1] forKey:@"evaluateForEmployee"];
        [evaluateDic setObject:[rs stringForColumnIndex:2] forKey:@"evaluateForEmployeeOther"];
        [evaluateDic setObject:[rs stringForColumnIndex:3] forKey:@"evaluateServeQuality"];
        [evaluateDic setObject:[rs stringForColumnIndex:4] forKey:@"evaluateServeAttitude"];
        [evaluateDic setObject:[rs stringForColumnIndex:5] forKey:@"evaluateServeSpeed"];
        [evaluateDic setObject:[rs stringForColumnIndex:6] forKey:@"evaluateForEmployeeTime"];
        [evaluateDic setObject:[rs stringForColumnIndex:7] forKey:@"evaluateForEmployer"];
        [evaluateDic setObject:[rs stringForColumnIndex:8] forKey:@"evaluateForEmployerOther"];
        [evaluateDic setObject:[rs stringForColumnIndex:9] forKey:@"evaluateForEmployerTime"];
    }
    
    return evaluateDic;
}
/**更新评价*/
-(void)updateEvaluateAndGuid:(NSString *)_requirementGuid andDic:(NSMutableDictionary *)_dic
{
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@' where %@ = '%@'",
                     EVALUATE,
                     EVALUATE_FOR_EMPLOYEE,
                     [_dic objectForKey:@"evaluateForEmployee"],
                     EVALUATE_FOR_EMPLOYEE_OTHER,
                     [_dic objectForKey:@"evaluateForEmployeeOther"],
                     EVALUATE_SERVE_QUALITY,
                     [_dic objectForKey:@"evaluateServeQuality"],
                     EVALUATE_SERVE_ATTITUDE,
                     [_dic objectForKey:@"evaluateServeAttitude"],
                     EVALUATE_SERVE_SPEED,
                     [_dic objectForKey:@"evaluateServeSpeed"],
                     EVALUATE_FOR_EMPLOYEE_TIME,
                     [_dic objectForKey:@"evaluateForEmployeeTime"],
                     EVALUATE_FOR_EMPLOYER,
                     [_dic objectForKey:@"evaluateForMaster"],
                     EVALUATE_FOR_EMPLOYER_OTHER,
                     [_dic objectForKey:@"evaluateForMasterOther"],
                     EVALUATE_FOR_EMPLOYER_TIME,
                     [_dic objectForKey:@"evaluateForMasterTime"],
                     EVALUATE_REQUIREMENT_GUID,
                     _requirementGuid];
    [[Ty_DbMethod shareDbService] updateData:sql];
}

#pragma mark 预约人表

-(BOOL)judgeIfExitOrderPersonAndRequirementGuid:(NSString *)_requirementGuid
{
    
    FMResultSet * rs =  [[Ty_DbMethod shareDbService] selectData:[NSString stringWithFormat:@"select * from ORDER_PERSON where ORDER_PERSON_REQUIREMENT_GUID = '%@'",_requirementGuid]];
    while ([rs next])
    {
        return YES;
    }
    return NO;
}

/**预约的人入库*/
-(void)saveOrderPersonAndRequirementGuid:(NSString *)_requirementGuid andOrderUserGuid:(NSString *)_orderUserGuid andServiceObject:(Ty_Model_ServiceObject *)_object
{
    NSString * insertSql = [NSString stringWithFormat:@"INSERT INTO ORDER_PERSON (%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",
                            ORDER_PERSON_REQUIREMENT_GUID,
                            ORDER_PERSON_USER_GUID,
                            ORDER_PERSON_USER_NAME,
                            ORDER_PERSON_USER_REALNAME,
                            ORDER_PERSON_USER_TYPE,
                            ORDER_PERSON_USER_SEX,
                            ORDER_PERSON_USER_PHOTO,
                            ORDER_PERSON_USER_EVALUATE,
                            ORDER_PERSON_USER_PHONE_NUMBER,
                            ORDER_PERSON_USER_TAG,
                            ORDER_PERSON_QUOTE,
                            ORDER_PERSON_USER_SERVICE_COUNT,
                            ORDER_PERSON_YZ_TIME,
                            ORDER_PERSON_COMPANY_USER_GUID,
                            ORDER_PERSON_COMPANY_USER_NAME,
                            ORDER_PERSON_COMPANY_USER_REALNAME,
                            ORDER_PERSON_COMPANY_USER_PHOTO,
                            ORDER_PERSON_COMPANY_PHONE,
                            ORDER_PERSON_COMPANY_USER_ANNEAR,
                            _requirementGuid,
                            _orderUserGuid,
                            _object.userName,
                            _object.userRealName,
                            _object.userType,
                            _object.sex,
                            _object.headPhoto,
                            _object.evaluate,
                            _object.phoneNumber,
                            @"",
                            _object.YZQuote,
                            _object.serviceNumber,
                            _object.YZTime,
                            _object.companiesGuid,
                            _object.companyUserName,
                            _object.respectiveCompanies,
                            _object.companyPhoto,
                            _object.companyPhoneNumber,
                            _object.companyUserAnnear];
                            [[Ty_DbMethod shareDbService] insertData:insertSql];
}
-(void)saveOrderPersonAndRequirementGuid:(NSString *)_requirementGuid andOrderUserGuid:(NSString *)_orderUserGuid andDictionary:(NSDictionary *)_orderPersonDictionary
{
    NSString * insertSql = [NSString stringWithFormat:@"INSERT INTO ORDER_PERSON (%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",
                            ORDER_PERSON_REQUIREMENT_GUID,
                            ORDER_PERSON_USER_GUID,
                            ORDER_PERSON_USER_NAME,
                            ORDER_PERSON_USER_REALNAME,
                            ORDER_PERSON_USER_TYPE,
                            ORDER_PERSON_USER_SEX,
                            ORDER_PERSON_USER_PHOTO,
                            ORDER_PERSON_USER_EVALUATE,
                            ORDER_PERSON_USER_PHONE_NUMBER,
                            ORDER_PERSON_USER_TAG,
                            ORDER_PERSON_QUOTE,
                            ORDER_PERSON_USER_SERVICE_COUNT,
                            ORDER_PERSON_YZ_TIME,
                            ORDER_PERSON_COMPANY_USER_GUID,
                            ORDER_PERSON_COMPANY_USER_NAME,
                            ORDER_PERSON_COMPANY_USER_REALNAME,
                            ORDER_PERSON_COMPANY_USER_PHOTO,
                            _requirementGuid,
                            _orderUserGuid,
                            [_orderPersonDictionary objectForKey:@"orderPersonUserName"],
                            [_orderPersonDictionary objectForKey:@"orderPersonUserRealName"],
                            [_orderPersonDictionary objectForKey:@"orderPersonUserType"],
                            [_orderPersonDictionary objectForKey:@"orderPersonUserSex"],
                            [_orderPersonDictionary objectForKey:@"orderPersonUserPhoto"],
                            [_orderPersonDictionary objectForKey:@"orderPersonUserEvaluate"],
                            [_orderPersonDictionary objectForKey:@"orderPersonUserPhoneNumber"],
                            [_orderPersonDictionary objectForKey:@"orderPersonUserTag"],
                            [_orderPersonDictionary objectForKey:@"orderPersonQuote"],//应征时候的报价
                            [_orderPersonDictionary objectForKey:@"orderPersonServiceCount"],
                            [_orderPersonDictionary objectForKey:@"orderPersonYZTime"],
                            [_orderPersonDictionary objectForKey:@"orderPersonCompanyUserGuid"],
                            [_orderPersonDictionary objectForKey:@"orderPersonCompanyUserName"],
                            [_orderPersonDictionary objectForKey:@"orderPersonCompanyUserRealName"],
                            [_orderPersonDictionary objectForKey:@"orderPersonComPanyUserPhoto"]];
    [[Ty_DbMethod shareDbService] insertData:insertSql];
}

/**得到预约的人*/
-(BOOL)getOrderPersonAndRequirementGuid:(NSString *)_requirementGuid
{
    NSString * selectSql = [NSString stringWithFormat:@"SELECT * FROM ORDER_PERSON WHERE ORDER_PERSON_REQUIREMENT_GUID = '%@'",_requirementGuid];
    FMResultSet * rs = [[Ty_DbMethod shareDbService] selectData:selectSql];
    
    if ([rs next])
    {
//        NSMutableDictionary * orderPersonDic = [[NSMutableDictionary alloc]init];
//        
//        [orderPersonDic setObject:_requirementGuid forKey:@"requirementGuid"];
//        [orderPersonDic setObject:[rs stringForColumnIndex:2] forKey:@"orderPersonUserGuid"];
//        [orderPersonDic setObject:[rs stringForColumnIndex:3] forKey:@"orderPersonUserName"];//预约人的userName
//        [orderPersonDic setObject:[rs stringForColumnIndex:4] forKey:@"orderPersonUserRealName"];//预约人的realName
//        [orderPersonDic setObject:[rs stringForColumnIndex:5] forKey:@"orderPersonUserType"];//预约人用户类型
//        [orderPersonDic setObject:[rs stringForColumnIndex:6] forKey:@"orderPersonUserSex"];//预约人性别
//        [orderPersonDic setObject:[rs stringForColumnIndex:7] forKey:@"orderPersonUserPhoto"];//预约头像
//        [orderPersonDic setObject:[rs stringForColumnIndex:8] forKey:@"orderPersonUserEvaluate"];//星级
//        [orderPersonDic setObject:[rs stringForColumnIndex:9] forKey:@"orderPersonUserPhoneNumber"];//预约人联系电话
//        [orderPersonDic setObject:[rs stringForColumnIndex:10] forKey:@"orderPersonUserTag"];//预约人的标签
//        [orderPersonDic setObject:[rs stringForColumnIndex:11] forKey:@"orderPersonQuote"];//预约人报价
//        [orderPersonDic setObject:[rs stringForColumnIndex:12] forKey:@"orderPersonServiceCount"];//预约人接货次数
//        [orderPersonDic setObject:[rs stringForColumnIndex:13] forKey:@"orderPersonYZTime"];//预约人抢单时间
//        [orderPersonDic setObject:[rs stringForColumnIndex:14] forKey:@"orderPersonCompanyUserGuid"];//预约人所属公司的guid
//        [orderPersonDic setObject:[rs stringForColumnIndex:15] forKey:@"orderPersonCompanyUserName"];//预约人所属公司的userName
//        [orderPersonDic setObject:[rs stringForColumnIndex:16] forKey:@"orderPersonCompanyUserRealName"];//预约人所属公司的userRealName
//        [orderPersonDic setObject:[rs stringForColumnIndex:17] forKey:@"orderPersonComPanyUserPhoto"];//预约人所属公司的头像
        
        
        dataBaseServiceObject = [[Ty_Model_ServiceObject alloc]init];
        
        dataBaseServiceObject.userGuid = [rs stringForColumnIndex:2];
        dataBaseServiceObject.userName = [rs stringForColumnIndex:3];
        dataBaseServiceObject.userRealName = [rs stringForColumnIndex:4];
        dataBaseServiceObject.userType = [rs stringForColumnIndex:5];
        dataBaseServiceObject.sex = [rs stringForColumnIndex:6];
        dataBaseServiceObject.headPhoto = [rs stringForColumnIndex:7];
        dataBaseServiceObject.evaluate = [rs stringForColumnIndex:8];
        dataBaseServiceObject.phoneNumber = [rs stringForColumnIndex:9];
        //标签没有地方
        dataBaseServiceObject.YZQuote = [rs stringForColumnIndex:11];
        dataBaseServiceObject.serviceNumber = [rs stringForColumnIndex:12];
        dataBaseServiceObject.YZTime = [rs stringForColumnIndex:13];
        dataBaseServiceObject.companiesGuid = [rs stringForColumnIndex:14];
        dataBaseServiceObject.companyUserName = [rs stringForColumnIndex:15];
        dataBaseServiceObject.respectiveCompanies = [rs stringForColumnIndex:16];//备注：这里存着公司的姓名
        dataBaseServiceObject.companyPhoto = [rs stringForColumnIndex:17];
        dataBaseServiceObject.companyPhoneNumber = [rs stringForColumnIndex:18];
        dataBaseServiceObject.companyUserAnnear = [rs stringForColumnIndex:19];
        
        dataBaseXuQiu.serverObject = dataBaseServiceObject;

        return YES;
    }
    else
        return NO;
}

-(void)updateOrderPersonAndRequirementGuid:(NSString *)_requirementGuid andServiceObject:(Ty_Model_ServiceObject *)_object
{
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@' where %@ = '%@'",
                     ORDER_PERSON,
                     ORDER_PERSON_USER_GUID,
                     _object.userGuid,
                     ORDER_PERSON_USER_NAME,
                     _object.userName,
                     ORDER_PERSON_USER_REALNAME,
                     _object.userRealName,
                     ORDER_PERSON_USER_TYPE,
                     _object.userType,
                     ORDER_PERSON_USER_SEX,
                     _object.sex,
                     ORDER_PERSON_USER_PHOTO,
                     _object.headPhoto,
                     ORDER_PERSON_USER_PHONE_NUMBER,
                     _object.phoneNumber,
                     ORDER_PERSON_QUOTE,
                     _object.YZQuote,
                     ORDER_PERSON_USER_SERVICE_COUNT,
                     _object.serviceNumber,
                     ORDER_PERSON_YZ_TIME,
                     _object.YZTime,
                     ORDER_PERSON_REQUIREMENT_GUID,
                     _requirementGuid];
    [[Ty_DbMethod shareDbService] updateData:sql];

}
/**修改预约的人的相关信息*/
-(void)updateOrderPersonAndRequirementGuid:(NSString *)_requirementGuid andDic:(NSMutableDictionary *)_dic
{
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@' where %@ = '%@'",
                     ORDER_PERSON,
                     ORDER_PERSON_USER_GUID,
                     [_dic objectForKey:@"orderPersonUserName"],
                     ORDER_PERSON_USER_NAME,
                     [_dic objectForKey:@"orderPersonUserName"],
                     ORDER_PERSON_USER_REALNAME,
                     [_dic objectForKey:@"orderPersonUserRealName"],
                     ORDER_PERSON_USER_TYPE,
                     [_dic objectForKey:@"orderPersonUserType"],
                     ORDER_PERSON_USER_SEX,
                     [_dic objectForKey:@"orderPersonUserSex"],
                     ORDER_PERSON_USER_PHOTO,
                     [_dic objectForKey:@"orderPersonUserPhoto"],
                     ORDER_PERSON_USER_PHONE_NUMBER,
                     [_dic objectForKey:@"orderPersonUserPhoneNumber"],
                     ORDER_PERSON_QUOTE,
                     [_dic objectForKey:@"orderPersonQuote"],//应征时候的报价
                     ORDER_PERSON_USER_SERVICE_COUNT,
                     [_dic objectForKey:@"orderPersonServiceCount"],
                     ORDER_PERSON_YZ_TIME,
                     [_dic objectForKey:@"orderPersonYZTime"],
                     ORDER_PERSON_REQUIREMENT_GUID,
                     _requirementGuid];
    [[Ty_DbMethod shareDbService] updateData:sql];
}

/*
#pragma mark 将需求详情导入到model中
-(void)saveDataToXuQiuModel:(NSMutableDictionary *)_requirementDic
{
    dataBaseXuQiu.requirementGuid = [_requirementDic objectForKey:@"requirementGuid"];
    dataBaseXuQiu.requirementNumber = [_requirementDic objectForKey:@"requirementNumber"];
    dataBaseXuQiu.requirement_Stage = [_requirementDic objectForKey:@"requirementStage"];
    dataBaseXuQiu.requirement_Type = [_requirementDic objectForKey:@"requirementType"];
    dataBaseXuQiu.userTypeBaseOnRequirement = [_requirementDic objectForKey:@"requirementUserType"];//不对，不过我们可以理解成，基于这条需求，我的身份
    dataBaseXuQiu.candidateStatus = [_requirementDic objectForKey:@"requirementCandidateStatus"];
    dataBaseXuQiu.evaluateStage = [_requirementDic objectForKey:@"evaluateState"];
    dataBaseXuQiu.workGuid = [_requirementDic objectForKey:@"requirementWorkGuid"];
    dataBaseXuQiu.workName = [_requirementDic objectForKey:@"workName"];
    dataBaseXuQiu.publishUserGuid = [_requirementDic objectForKey:@"userGuid"];
    dataBaseXuQiu.publishUserName = [_requirementDic objectForKey:@"userName"];
    dataBaseXuQiu.publishUsrRealName = [_requirementDic objectForKey:@"userRealName"];
    dataBaseXuQiu.publishUserSex = [_requirementDic objectForKey:@"userSex"];
    dataBaseXuQiu.publishUserType = [_requirementDic objectForKey:@"userType"];
    dataBaseXuQiu.publishUserPhoto = [_requirementDic objectForKey:@"userPhoto"];
    dataBaseXuQiu.publishUserEvaluate = [_requirementDic objectForKey:@"userEvaluate"];
    
    NSArray * tempAddressArray = [[_requirementDic objectForKey:@"requirementAddress"]componentsSeparatedByString:@"  "];
    if ([tempAddressArray count] >=5)
    {
        if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:0]]))
        {
            dataBaseXuQiu.province = [tempAddressArray objectAtIndex:0];
        }
        else
        {
            dataBaseXuQiu.province = @"";
        }
        if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:1]]))
        {
            dataBaseXuQiu.city = [tempAddressArray objectAtIndex:1];
        }
        else
        {
            dataBaseXuQiu.city = @"";
        }
        if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:2]]))
        {
            dataBaseXuQiu.area = [tempAddressArray objectAtIndex:2];
        }
        else
        {
            dataBaseXuQiu.area = @"";
        }
        if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:3]]))
        {
            dataBaseXuQiu.region = [tempAddressArray objectAtIndex:3];
        }
        else
        {
            dataBaseXuQiu.region = @"";
        }
        if (!ISNULLSTR([NSString stringWithString:[tempAddressArray objectAtIndex:4]]))
        {
            dataBaseXuQiu.addressDetail = [tempAddressArray objectAtIndex:4];
        }
        else
        {
            dataBaseXuQiu.addressDetail = @"";
        }
    }
    else
    {
        dataBaseXuQiu.province = @"";
        dataBaseXuQiu.city = @"";
        dataBaseXuQiu.area = @"";
        dataBaseXuQiu.region = @"";
        dataBaseXuQiu.addressDetail = @"";
    }
    dataBaseXuQiu.submitTime = [_requirementDic objectForKey:@"requirementPublishTime"];
    dataBaseXuQiu.startTime = [_requirementDic objectForKey:@"requirementStartTime"];
    dataBaseXuQiu.endTime = [_requirementDic objectForKey:@"requirementEndTime"];
    
    dataBaseXuQiu.priceUnit = [_requirementDic objectForKey:@"requirementUnitPrice"];
    dataBaseXuQiu.priceTotal = [_requirementDic objectForKey:@"requirementTimeTotalPrice"];
    dataBaseXuQiu.workAmount = [_requirementDic objectForKey:@"workAmount"];
    
    dataBaseXuQiu.contact = [_requirementDic objectForKey:@"requirementContactName"];
    dataBaseXuQiu.contactPhone = [_requirementDic objectForKey:@"requirementContactPhone"];
    dataBaseXuQiu.ask_Price = [_requirementDic objectForKey:@"requirementAskSalary"];
    dataBaseXuQiu.ask_Age = [_requirementDic objectForKey:@"requirementAskAge"];
    dataBaseXuQiu.ask_Sex = [_requirementDic objectForKey:@"requirementAskSex"];
    dataBaseXuQiu.ask_Education = [_requirementDic objectForKey:@"requirementAskRecord"];
    dataBaseXuQiu.ask_Ethnic = [_requirementDic objectForKey:@"requirementAskNation"];//需要确定
    dataBaseXuQiu.ask_WorkExperience = [_requirementDic objectForKey:@"requirementAskWork"];
    dataBaseXuQiu.ask_Hometown = [_requirementDic objectForKey:@"requirementAskCensus"];//需要确定
    dataBaseXuQiu.ask_Other = [_requirementDic objectForKey:@"requirementAskOther"];
    dataBaseXuQiu.updateTime = [_requirementDic objectForKey:@"requirementUpdateTime"];
}
*/
#pragma mark 将预约人导入到model中
-(void)saveDataToServiceObjectModel:(NSMutableDictionary*)_orderPersonDic
{
    dataBaseServiceObject = [[Ty_Model_ServiceObject alloc]init];
    
    dataBaseServiceObject.userGuid = [_orderPersonDic objectForKey:@"orderPersonUserGuid"];
    dataBaseServiceObject.userName = [_orderPersonDic objectForKey:@"orderPersonUserName"];
    dataBaseServiceObject.userRealName = [_orderPersonDic objectForKey:@"orderPersonUserRealName"];
    dataBaseServiceObject.userType = [_orderPersonDic objectForKey:@"orderPersonUserType"];
    dataBaseServiceObject.sex = [_orderPersonDic objectForKey:@"orderPersonUserSex"];
    dataBaseServiceObject.headPhoto = [_orderPersonDic objectForKey:@"orderPersonUserPhoto"];
    dataBaseServiceObject.evaluate = [_orderPersonDic objectForKey:@"orderPersonUserEvaluate"];
    dataBaseServiceObject.phoneNumber = [_orderPersonDic objectForKey:@"orderPersonUserPhoneNumber"];
    //标签没有地方
    dataBaseServiceObject.YZQuote = [_orderPersonDic objectForKey:@"orderPersonQuote"];
    dataBaseServiceObject.serviceNumber = [_orderPersonDic objectForKey:@"orderPersonServiceCount"];
    dataBaseServiceObject.YZTime = [_orderPersonDic objectForKey:@"orderPersonYZTime"];
    dataBaseServiceObject.companiesGuid = [_orderPersonDic objectForKey:@"orderPersonCompanyUserGuid"];
    dataBaseServiceObject.companyUserName = [_orderPersonDic objectForKey:@"orderPersonCompanyUserName"];
    dataBaseServiceObject.respectiveCompanies = [_orderPersonDic objectForKey:@"orderPersonCompanyUserRealName"];//备注：这里存着公司的姓名
    dataBaseServiceObject.companyPhoto = [_orderPersonDic objectForKey:@"orderPersonComPanyUserPhoto"];
    dataBaseXuQiu.serverObject = dataBaseServiceObject;
}

@end
