//
//  Ty_MyAttentionWork_Busine.m
//  腾云家务
//
//  Created by Xu Zhao on 14-6-9.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_MyAttentionWork_Busine.h"

@implementation Ty_MyAttentionWork_Busine
-(NSMutableArray *)getWorkName
{
    arrWork = [[NSMutableArray alloc]init];
    arrWorkName = [[NSMutableArray alloc]init];
    arrWorkKind = [[NSMutableArray alloc]init];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:AddWorkTypefileForPath])
    {
        NSArray *arrTemp = [NSArray arrayWithContentsOfFile:AddWorkTypefileForPath];
        
        for(int i=0;i<arrTemp.count;i++)
        {
            [arrWorkName addObject:[[arrTemp objectAtIndex:i] objectForKey:@"workName"]];
            [arrWorkKind addObject:@"0"];
            
            NSArray *arrTemp_ = [NSArray arrayWithArray:[[arrTemp objectAtIndex:i] objectForKey:@"ChildrenWrok"]];
            for(int j=0;j<arrTemp_.count;j++)
            {
                NSDictionary *dicTemp_ = [arrTemp_ objectAtIndex:j];
                [arrWorkName addObject:[dicTemp_ objectForKey:@"workName"]];
                [arrWorkKind addObject:@"1"];
            }
        }
        
        [arrWorkName insertObject:@"全部" atIndex:0];
        [arrWorkKind insertObject:@"0" atIndex:0];
        
        [arrWork addObject:arrWorkName];
        [arrWork addObject:arrWorkKind];
        
        return arrWork;
    }
    
    return arrWork;
}

-(void)getMyAttentionFromSql:(int)_selectRow
{
    //搜索数据库
    NSString *sql = [[NSString alloc]initWithFormat:@""];
    
    if(_selectRow == 0)
        sql = @"";
    else if([[arrWorkKind objectAtIndex:_selectRow] isEqualToString:@"0"])//大工种搜索
    {
        for(int i=_selectRow+1;i<arrWorkKind.count && [[arrWorkKind objectAtIndex:i] isEqualToString:@"1"];i++)
        {
            if([sql isEqualToString:@""])
                sql = [[NSString alloc]initWithFormat:@"%@ and (CONTACTDATA_USER_POST like '%@%%' or CONTACTDATA_USER_POST like '%%%@' or CONTACTDATA_USER_POST like '%%%@%%')",sql,[arrWorkName objectAtIndex:i],[arrWorkName objectAtIndex:i],[arrWorkName objectAtIndex:i]];
            else
                sql = [[NSString alloc]initWithFormat:@"%@ or (CONTACTDATA_USER_POST like '%@%%' or CONTACTDATA_USER_POST like '%%%@' or CONTACTDATA_USER_POST like '%%%@%%')",sql,[arrWorkName objectAtIndex:i],[arrWorkName objectAtIndex:i],[arrWorkName objectAtIndex:i]];
        }
    }
    else//小工种搜索
    {
        sql = [NSString stringWithFormat:@"and (CONTACTDATA_USER_POST like '%@%%' or CONTACTDATA_USER_POST like '%%%@' or CONTACTDATA_USER_POST like '%%%@%%')",[arrWorkName objectAtIndex:_selectRow],[arrWorkName objectAtIndex:_selectRow],[arrWorkName objectAtIndex:_selectRow]];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"searchWithWork" object:sql];
    
    /*SqliteFuction *sqlSearch = [[SqliteFuction alloc]init];
    NSMutableArray *arrResult = [sqlSearch SearchContactDataWithRelationship:@"CONTACTDATA_ATTENTION_USER_GUID" and:arrSearch];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"alltagBack" object:arrResult];*/
}
@end
