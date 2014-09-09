//
//  Ty_Model_SystemMsgInfo.h
//  腾云家务
//
//  Created by liu on 14-7-12.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ty_Model_SystemMsgInfo : NSObject

@property (nonatomic,strong) NSString *systemMsgGuid;

@property (nonatomic,strong) NSString *systemMsgContent;

@property (nonatomic,strong) NSString *systemMsg_ReqGuid;

@property (nonatomic,assign) NSInteger systemMsg_ReqType;

@property (nonatomic,assign) NSInteger systemMsg_IsRead;

@property (nonatomic,strong) NSString *systemMsg_Time;

@property (nonatomic,strong) NSMutableArray *systemRedNumArr;

@end
