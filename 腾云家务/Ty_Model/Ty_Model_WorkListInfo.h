//
//  WorkListInfo.h
//  短工平台1.0
//
//  Created by ; on 13-7-22.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ty_Model_WorkListInfo : NSObject

@property (nonatomic,retain) NSString *workGuid;
@property (nonatomic,retain) NSString *workID;
@property (nonatomic,retain) NSString *workName;
@property (nonatomic,retain) NSString *postSalary;
@property (nonatomic,retain) NSString *experience;//经验
@property (nonatomic,retain) NSString *specialty;//特长
/**实际技能价格*/
@property (nonatomic,retain) NSString *postRealSalary;

@end
