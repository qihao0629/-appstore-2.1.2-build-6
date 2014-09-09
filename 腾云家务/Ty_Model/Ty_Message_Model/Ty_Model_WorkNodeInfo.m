//
//  Ty_Model_WorkNodeInfo.m
//  腾云家务
//
//  Created by liu on 14-7-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Model_WorkNodeInfo.h"

@implementation Ty_Model_WorkNodeInfo

@synthesize workNodeLevel = _workNodeLevel;
@synthesize workNodeName = _workNodeName;
@synthesize childNodeArr = _childNodeArr;

- (id)init
{
    if (self = [super init])
    {
        _workNodeName = @"";
        _workNodeLevel = 0;
        _childNodeArr = [[NSMutableArray alloc]init];
    }
    
    return self;
}

@end
