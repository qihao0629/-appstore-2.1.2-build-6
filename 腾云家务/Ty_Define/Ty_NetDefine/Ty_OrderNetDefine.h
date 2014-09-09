//
//  Ty_OrderNetDefine.h
//  腾云家务
//
//  Created by lgs on 14-6-4.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#ifndef _____Ty_OrderNetDefine_h
#define _____Ty_OrderNetDefine_h

//雇主
#define _masterDirectlyInfoURL [NSString stringWithFormat:@"requirement/SearchMyPublishRequirement.action"]//雇主直接预约和直接发布
#define _masterOrderHirePersonURL [NSString stringWithFormat:@"requirement/UpdateRequirementOrderByTrue.action"]//雇主确定人选-应征者
#define _masterEvaluateWorkerURL [NSString stringWithFormat:@"evaluate/EvaluateForEmployee.action"]//雇主评价雇工


//雇工
#define _workerDirectlyAndSystemInfoURL [NSString stringWithFormat:@"requirement/SearchMyCandidateRequirement.action"]//雇工的直接被预约和系统推送
#define _quitYZOrderURL [NSString stringWithFormat:@"candidate/DeleteCandidate.action"]//取消应征
#define _workApplyRequirementURL [NSString stringWithFormat:@"candidate/AddCandidate.action"]//雇工应征某个需求
#define _workerEvaluateMasterURL [NSString stringWithFormat:@"evaluate/EvaluateForMaster.action"]//雇工评价雇主
#define _workerReplyDirectlyOrderURL [NSString stringWithFormat:@"requirement/UpdateOrderRequirementTrue.action"]//雇工对被直接预约的回复，接单或者拒绝
#define _workerSendEmployeeURL [NSString stringWithFormat:@"requirement/DispatchEmployee.action"]//商户派遣员工

#define _userAddEmpURL [NSString stringWithFormat:@"user/AddEmp.action"]//新建员工


//需求
#define _requirementInfoURL [NSString stringWithFormat:@"requirement/SearchDetailRequirement.action"]//需求信息
#define _requirementHirePeopleInfoURL [NSString stringWithFormat:@"candidate/SearchCandidate.action"]//雇主发布的查询需求应征者
#define _requirementYZNumberAndOtherURL [NSString stringWithFormat:@"candidate/SearchCandidateNumber.action"]//系统推送的，查询应征的人数和我的应征的信息。
#define _closeRequirementURL [NSString stringWithFormat:@"requirement/CloseRequirement.action"]//关闭这个需求

#define _publishAndOrderNotificationURL [NSString stringWithFormat:@"requirement/SearchRelevantRequirement.action"]//抢单和预约通知
#define _searchMyAllKindsOfRequirementURL [NSString stringWithFormat:@"requirement/SearchMyAllKindsOfRequirement.action"]//我的各类需求
#define _searchAllRequirementURL [NSString stringWithFormat:@"requirement/SearchRelevantAllRequirement.action"]//我的所有的需求和预约订单
#endif
