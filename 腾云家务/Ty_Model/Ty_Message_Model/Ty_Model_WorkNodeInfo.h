//
//  Ty_Model_WorkNodeInfo.h
//  腾云家务
//
//  Created by liu on 14-7-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ty_Model_WorkNodeInfo : NSObject

@property (nonatomic,assign) NSInteger workNodeLevel;

@property (nonatomic,strong) NSString *workNodeName;

@property (nonatomic,strong) NSMutableArray *childNodeArr;

@end
