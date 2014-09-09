//
//  WorkListInfo.m
//  短工平台1.0
//
//  Created by liu on 13-7-22.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "Ty_Model_WorkListInfo.h"

@implementation Ty_Model_WorkListInfo

@synthesize workGuid;
@synthesize workID;
@synthesize workName;
@synthesize postSalary;
@synthesize experience;
@synthesize specialty;
@synthesize postRealSalary;
- (id)init
{
    if (self = [super init] )
    {
        workID = @"";
        
        workGuid = @"";
        
        workName = @"";
        
        postSalary=@"";
        
        experience=@"";
        
        specialty=@"";
        
        postRealSalary = @"";
    }
    
    return self;
}

@end
