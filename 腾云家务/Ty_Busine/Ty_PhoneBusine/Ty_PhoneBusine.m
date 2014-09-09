//
//  Ty_PhoneBusine.m
//  腾云家务
//
//  Created by 齐 浩 on 14-8-20.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_PhoneBusine.h"
#import "Ty_DbMethod.h"


@implementation Ty_PhoneBusine
static Ty_PhoneBusine *phoneService;
+(Ty_PhoneBusine *)sharePhone
{
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        phoneService = [[Ty_PhoneBusine alloc]init];
    });
    return phoneService;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)savePhoneData:(Ty_Phone_Model *)_phone_Model
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    _phone_Model.PhoneTime = [dateFormatter stringFromDate:[NSDate date]];
    
    if (!ISNULLSTR(_phone_Model.myGuid) && !ISNULLSTR(_phone_Model.yourGuid) &&
        !ISNULLSTR(_phone_Model.phoneNumber) && !ISNULLSTR(_phone_Model.PhoneTime) ) {
        NSString * insert = [NSString stringWithFormat:@"insert into %@ (%@,%@,%@,%@) values ('%@','%@','%@','%@')",
                             TBL_Phone,
                             Phone_MyGuid,
                             Phone_YourGuid,
                             Phone_Number,
                             Phone_Time,
                             _phone_Model.myGuid,
                             _phone_Model.yourGuid,
                             _phone_Model.phoneNumber,
                             _phone_Model.PhoneTime];
        [[Ty_DbMethod shareDbService] insertData:insert];
    }
}
-(void)deletePhoneData:(Ty_Phone_Model *)_phone_Model
{
    NSString *deleteSql = [NSString stringWithFormat:@"delete from %@ where %@ = '%@'",
                           TBL_Phone,
                           Phone_Time,
                           _phone_Model.PhoneTime];
    [[Ty_DbMethod shareDbService] deleteData:deleteSql];
}

-(void)sendPhoneData
{
    NSString* selectSql=[NSString stringWithFormat:@"select * from %@",TBL_Phone];
    
    FMResultSet* resultSet=[[Ty_DbMethod shareDbService] selectData:selectSql];
    
    ASINetworkQueue* netQueue=[[ASINetworkQueue alloc] init];
    [netQueue reset];
    [netQueue setDownloadProgressDelegate:self];
    [netQueue setRequestDidFinishSelector: @selector(Success:)];
    [netQueue setRequestDidFailSelector: @selector(Falid:)];
    [netQueue setShowAccurateProgress: YES];
    [netQueue setQueueDidFinishSelector:@selector(netQueueFinish:)];
    [netQueue setDelegate:self];
    
    while (resultSet.next)
    {
        ASIFormDataRequest * formDataRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOSTLOCATION,PhoneUrl]]];
        [formDataRequest setDelegate:self];
        Ty_Phone_Model * phoneModel = [[Ty_Phone_Model alloc] init];
        phoneModel.myGuid = [resultSet stringForColumn:Phone_MyGuid];
        phoneModel.yourGuid = [resultSet stringForColumn:Phone_YourGuid];
        phoneModel.phoneNumber = [resultSet stringForColumn:Phone_Number];
        phoneModel.PhoneTime = [resultSet stringForColumn:Phone_Time];

        [formDataRequest setUserInfo:[[NSDictionary alloc] initWithObjectsAndKeys:phoneModel,@"Phone", nil]];
        [formDataRequest setPostValue:phoneModel.myGuid forKey:@"userGuid"];
        [formDataRequest setPostValue:phoneModel.yourGuid forKey:@"intermediaryGuid"];
        [formDataRequest setPostValue:phoneModel.phoneNumber forKey:@"phoneNum"];
        [formDataRequest setPostValue:phoneModel.PhoneTime forKey:@"nowTime"];
        [formDataRequest setPostValue:@"ios" forKey:@"os"];
        
        phoneModel = nil;

        [netQueue addOperation:formDataRequest];
    }
    if (netQueue.requestsCount > 0) {
        [netQueue go];
    }else{
        netQueue = nil;
    }
    
}
-(void)netQueueFinish:(ASINetworkQueue *)_netQueue
{

}
-(void)Success:(ASIHTTPRequest *)request
{
//    NSData* response=[request responseData];
//    NSError *error = nil;
//    NSDictionary *weatherDic;
//    if (response != nil)
//    {
//        weatherDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//    }
//    if ([[weatherDic objectForKey:@"code"] intValue] == 200) {
//        Ty_Phone_Model * phoneModel = [[Ty_Phone_Model alloc] init];
//        phoneModel.myGuid = [request valueForKey:@"userGuid"];
//        
//        phoneModel.yourGuid = [request valueForKey:@"intermediaryGuid"];
//        phoneModel.phoneNumber = [request valueForKey:@"phoneNum"];
//        phoneModel.PhoneTime = [request valueForKey:@"nowTime"];
//        
//        [self deletePhoneData:phoneModel];
//    }
}
-(void)Falid:(ASIHTTPRequest *)request
{
    
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSData* response=[request responseData];
    NSError *error = nil;
    NSDictionary *weatherDic;
    if (response != nil)
    {
        weatherDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    }
    if ([[weatherDic objectForKey:@"code"] intValue] == 200) {
        
        Ty_Phone_Model * phoneModel = [request.userInfo objectForKey:@"Phone"];
        [self deletePhoneData:phoneModel];
    }
}
-(void)requestFailed:(ASIHTTPRequest *)request
{

}

@end
