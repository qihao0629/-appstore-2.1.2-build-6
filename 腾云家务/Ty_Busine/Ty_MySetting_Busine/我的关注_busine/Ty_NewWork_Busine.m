//
//  Ty_NewWork_Busine.m
//  腾云家务
//
//  Created by liu on 14-7-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_NewWork_Busine.h"

@implementation Ty_NewWork_Busine

- (id)init
{
    if (self = [super init])
    {
        
    }
    
    return self;
}

- (void)getAllWorkList:(Ty_Model_WorkNodeInfo *)workNodeInfo
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:AddWorkTypefileForPath])
    {
        NSArray *allWorkArr = [NSArray arrayWithContentsOfFile:AddWorkTypefileForPath];
        
        workNodeInfo.workNodeName = @"全部";
        workNodeInfo.workNodeLevel = 1;
        
        for(int i = 0;i < allWorkArr .count; i++)
        {
            NSMutableDictionary *dic = [allWorkArr objectAtIndex:i];
            Ty_Model_WorkNodeInfo *workNodeInfo_level1 = [[Ty_Model_WorkNodeInfo alloc]init];
            workNodeInfo_level1.workNodeName = [dic objectForKey:@"workName"];
            workNodeInfo_level1.workNodeLevel = 1;
            
            NSArray *tempArr = [dic objectForKey:@"ChildrenWrok"];
            for (int j = 0; j < tempArr.count; j ++)
            {
                NSMutableDictionary *dic1 = [tempArr objectAtIndex:j];
                Ty_Model_WorkNodeInfo *workNodeInfo_level2 = [[Ty_Model_WorkNodeInfo alloc]init];
                workNodeInfo_level2.workNodeName = [dic1 objectForKey:@"workName"];
                workNodeInfo_level2.workNodeLevel = 2;
                
                [workNodeInfo_level1.childNodeArr addObject:workNodeInfo_level2];
                workNodeInfo_level2 = nil;
            }
            
            
            [workNodeInfo.childNodeArr addObject:workNodeInfo_level1];
            workNodeInfo_level1 = nil;
        }
        
        
    }
}

@end
