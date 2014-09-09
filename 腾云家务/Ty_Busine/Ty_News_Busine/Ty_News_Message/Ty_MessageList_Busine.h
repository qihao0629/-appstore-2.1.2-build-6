//
//  Ty_MessageList_Busine.h
//  腾云家务
//
//  Created by liu on 14-6-5.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Ty_Model_MessageInfo;

@interface Ty_MessageList_Busine : NSObject

@property (nonatomic,strong) NSMutableArray *allMessageArr;


- (void)getAllMessageList;



- (void)insertMessageIntoTable:(Ty_Model_MessageInfo *)messageInfo;


/**
 *  查询与信息相关的人员表里是否有此联系人
 *
 *  @param contactGuid 联系人guid
 *
 *  @return yes ： 有该人员信息  no:无该人员信息
 */
- (BOOL)isMsgContactInfoExist:(NSString *)contactGuid;


/**
 *  根据guid向服务器请求人员简单信息
 *
 *  @param contactGuid 联系人guid
 */
- (void)getMsgContactInfoFromNetWithContactGuid:(NSString *)contactGuid;

- (void)createQDataIntoTable;

- (NSInteger)getAllUnreadMessageNum;

- (void)updateGroupDeleteByContactGuid:(NSString *)contactGuid;

@end
