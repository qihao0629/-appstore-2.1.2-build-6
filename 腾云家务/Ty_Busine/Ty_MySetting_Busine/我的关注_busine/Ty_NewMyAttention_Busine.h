//
//  Ty_NewMyAttention_Busine.h
//  腾云家务
//
//  Created by liu on 14-7-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Ty_Model_ServiceObject;
@class Ty_Model_WorkNodeInfo;

@interface Ty_NewMyAttention_Busine : NSObject

/**
 *  从网络获取我的关注数据
 */
- (void)getContactDataFromNet;

/**
 *  插数据入库
 *
 *  @param serviceObject
 */
- (void)insertDataIntoTable:(Ty_Model_ServiceObject *)serviceObject;

/**
 *  根据条件查询联系人
 *
 *  @param dic      数据存储
 *  @param workType 条件
 */
- (void)getAllContactData:(NSMutableDictionary *)dic byCondition:(Ty_Model_WorkNodeInfo *)nodeInfo;

/**
 *  根据条件查询联系人
 *
 *  @param dic      数据存储
 *  @param workType 条件
 */
- (void)searchContact:(NSMutableDictionary *)dic byCondition:(NSString *)conditionStr;

@end
