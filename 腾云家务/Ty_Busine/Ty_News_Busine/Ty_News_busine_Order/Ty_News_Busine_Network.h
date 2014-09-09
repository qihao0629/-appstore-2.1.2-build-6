//
//  Ty_News_Busine_Network.h
//  腾云家务
//
//  Created by lgs on 14-6-4.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ty_Model_ServiceObject.h"
#import "Ty_Model_XuQiuInfo.h"
#import "My_AddEmployeeModel.h"

@interface Ty_News_Busine_Network : TY_BaseBusine
{
    int currentPage;//当前的页数
    int lastPage;//上一次的页数
    
    int userType;//这个人身份
    int buttonNumber;//按钮
    
    int hirePersonPage;//查看应征人个数的page
    int lastHirePersonPage;//上一个page
    
    int canYZPage;//待应征的page
    int canYZLastPage;//待应征的上一个page
    int waitServicePage;//待服务的page
    int waitServiceLastPage;//待服务的上一个page;
    int serviceRecordPage;//服务记录的page
    int serviceRecordLastPage;//服务记录的上一个Page;
    
    int filterButtonTag;//订单那筛选的tag -1 代表雇主 0 待应征 1待服务  2服务记录
}
@property (nonatomic,strong) NSMutableArray * xuQiuInfoArray;
@property (nonatomic,strong) NSMutableArray * serviceObjectArray;
@property (nonatomic,strong) Ty_Model_ServiceObject * YZServiceObject;
@property (nonatomic,strong) NSMutableArray * canYZxuQiuInfoArray;
@property (nonatomic,strong) NSMutableArray * waitServiceXuQiuInfoArray;
@property (nonatomic,strong) NSMutableArray * serviceRecordXuQiuInfoArray;
/*
 取消抢单的网络方法和回调,抢单和预约通知中的取消
 参数:requiremengGuid，userGuid
 */
-(void)notificationCloseRequiremengAndRequirementGuid:(NSString *)_requirementGuid;
//预约中的取消
-(void)masterOrderCloseRequiremengAndRequirementGuid:(NSString *)_requirementGuid;
//发布需求中的取消
-(void)masterPublishCloseRequiremengAndRequirementGuid:(NSString *)_requirementGuid;
/*
 查看应征的人
 */
-(void)checkYZPeopleWithRequirementGuid:(NSString *)_requirementGuid;


/*
 雇主查看需求详情
 参数：需要requriementGuid,userGuid,还有一个在数据库查看的时间点
 */
-(void)masterOrderCheckRequirementDetailAndRequirementGuid:(NSString *)_requirementGuid;
-(void)masterPublishCheckRequirementDetailAndRequirementGuid:(NSString *)_requirementGuid;

/*
 雇主确定人选
 参数：需求的guid,userguid，确定人的guid
 */
-(void)masterPublishSurePersonWithRequirementGuid:(NSString *)_requirementGuid andSurePersonGuid:(NSString *)_surePersonGuid;

/*
 雇主评价雇工
 参数：需求guid,userGuid,xuqiu
 */
-(void)masterEvaluateWorkerWithRequirementGuid:(NSString *)_requirementGuid andUserGuid:(NSString *)_userGuid andXuQiu:(Ty_Model_XuQiuInfo *)_xuQiu;

/*
 雇工查看需求详情
 参数：需求的guid,userGuid,还有一个时间点
 */
-(void)workerOrderCheckRequirementDetailAndRequirementGuid:(NSString *)_requirementGuid;
-(void)workerPublishCheckRequirementDetailAndRequirementGuid:(NSString *)_requirementGuid;

/*
 雇工应征某条需求
 参数:需求的guid,userguid,备注，价格
 */
-(void)workerYZRequirementWithRequirementGuid:(NSString *)_requirementGuid andRemark:(NSString *)_remark andPrice:(NSString *)_price;

/*
 雇工取消应征
 参数：需求guid,userguid
 */
-(void)workerQuitYZRequirementWithRequirementGuid:(NSString *)_requirementGuid;

/*
 雇工对直接预约的回应
 参数：需求guid,userGuid,什么回应
 */
-(void)workerRespondToRequirementWithRequiremnetGuid:(NSString *)_requirementGuid withRespondString:(NSString *)_respond;

/*
 雇工查看自己应征的相关信息
 参数：需求的guid,userGuid
 */
-(void)workerCheckSelfYZDataWithRequirementGuid:(NSString *)_requirementGuid;

/**
 商户查看自己手下的短工
 参数：userguid，pagesize，currentPange
 **/
-(void)workerLookEmployeesWithWorkGuid:(NSString *)_workGuid;

/*
 商户派遣员工成功
 参数：需求的guid,员工的guid
 */
-(void)workerSendEmployeeWithRequirementGuid:(NSString *)_requirementGuid andEmployeeUserGuid:(NSString *)_employeeUserGuid;

/*
 商户创建新的员工
 参数:model,workGuid,价格
 */
-(void)workerNewEmployeeWithWorkGuid:(NSString *)_workGuid andModel:(My_AddEmployeeModel *)_model andServiceModel:(Ty_Model_ServiceObject *)_serviceModel andPostSalary:(NSString *)_postSalary andWorkName:(NSString *)_workName;

/*
 雇工评价雇主
 参数：需求的guid,userGuid,整体评价，评价备注
 */
-(void)workerEvaluateMasterWithRequirementGuid:(NSString *)_requirementGuid andtotalEvaluate:(int)_totalEvaluate andOtherEvaluate:(NSString *)_otherString;

/*
 抢单和预约通知
 参数：当前的页数currentPage,我的userGuid,pageSize tag -1代表雇主的，0待应征，1待服务，2服务记录
 */
-(void)publishAndOrderNotificationWithButtonTag:(int)tag;
//-(void)publishAndOrderNotificationNetCallBackWithStatus:(NSString*)_status dic:(NSMutableDictionary *)_dic;/**对应的回调*/

/*
 我是服务商或者雇主
 “我”界面，上面两个的网络请求
 */
-(void)searchMyAllKindsOfRequirementWithType:(int)_type andUserType:(int)_userType;//第一个type 是抢单还是预约  第二个是用户类型
//-(void)searchMyAllKindsOfRequirementNetCallBackWithStatus:(NSString *)_status dic:(NSMutableDictionary *)_dic;/*对应的回调*/

/*
 我是服务商或者雇主
 "我"界面，我的所有的订单
 */
-(void)searchAllRequirementWithType:(int)_type;//雇主的所有的type 4;雇工的是5
//-(void)searchAllRequirementNetCallBackWithStatus:(NSString*)_status dic:(NSMutableDictionary *)_dic;/*对应的回调*/

/*
 处理相同类似的网络回调
 */
-(BOOL)handleNetWorkCallBack:(NSMutableDictionary *)_dic;

/*
 进入消息界面
 */
-(UIViewController*)privateButtonPressedandXuQiu:(Ty_Model_XuQiuInfo *)_xuInfo;


//刷新所有
-(void)freshData;
//当前
-(void)freshPage;
//刷新对应的数组
-(void)freshArrayWithButtonTag:(int)tag;
@end
