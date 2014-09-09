//
//  Ty_News_Busine_HandlePlist.m
//  腾云家务
//
//  Created by lgs on 14-5-29.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_News_Busine_HandlePlist.h"

@implementation Ty_News_Busine_HandlePlist

-(NSString* )findWorkNameAndworkTypeLevel:(int)_workTypeLevel andWorkGuid:(NSString *)_workGuid
{
    //得到完整的文件名
    NSString *filename=[PATH_OF_DOCUMENT stringByAppendingPathComponent:@"AddworkType.plist"];
    
    NSMutableArray * array =[[NSMutableArray alloc]initWithContentsOfFile:filename];
    NSMutableString * workName = [[NSMutableString alloc]init];
    if (_workTypeLevel == 1)
    {
        for (int i = 0; i < [array count]; i ++)
        {
            if ([[[array objectAtIndex:i] objectForKey:@"workGuid"] isEqualToString:_workGuid])
            {
                workName = [[array objectAtIndex:i] objectForKey:@"workName"];
                break;
            }
        }
        return workName;
    }
    else
    {
        for (int i = 0; i < [array count]; i ++)
        {
            NSMutableArray * tempWorkArray = [[NSMutableArray alloc] initWithArray:[[array objectAtIndex:i] objectForKey:@"ChildrenWrok"]];
            for (int j = 0; j < [tempWorkArray count]; j ++)
            {
                if ([[[tempWorkArray objectAtIndex:j] objectForKey:@"workGuid"] isEqualToString:_workGuid])
                {
                    workName = [[tempWorkArray objectAtIndex:j] objectForKey:@"workName"];
                    break;
                }
            }
        }
        return workName;
    }
}
-(NSString *)findWorkUnitAndWorkName:(NSString *)_workName
{
    //得到完整的文件名
    NSString *filename=[PATH_OF_DOCUMENT stringByAppendingPathComponent:@"UnitPList.plist"];
    
    NSMutableDictionary * unitDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:filename];
    NSMutableString * workUnit = [[NSMutableString alloc]init];
    
    workUnit = [unitDictionary objectForKey:_workName];
    return workUnit;
}
-(NSString *)findWorkPhotoAddress:(NSString *)_workName
{
    NSString *filename=[PATH_OF_DOCUMENT stringByAppendingPathComponent:@"AddworkType.plist"];
    NSMutableArray * array =[[NSMutableArray alloc]initWithContentsOfFile:filename];
    NSMutableString * addressString;
    for(int i=0;i<array.count;i++)
    {
        for(int j=0;j<[[[array objectAtIndex:i]objectForKey:@"ChildrenWrok"] count];j++)
        {
            if([[[[[array objectAtIndex:i]objectForKey:@"ChildrenWrok"]objectAtIndex:j]objectForKey:@"workName"] isEqualToString:_workName])
                addressString = [NSMutableString stringWithFormat:@"%@.png",[[array objectAtIndex:i]objectForKey:@"workName"]];
        }
    }
    return addressString;
}

@end
