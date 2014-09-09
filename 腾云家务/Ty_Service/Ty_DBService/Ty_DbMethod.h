//
//  Ty_DbMethod.h
//  腾云家务
//
//  Created by 齐 浩 on 14-5-29.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ty_DbMethod : NSObject
{
    NSString* dbPath;
    FMDatabase* db;
}
+ (Ty_DbMethod *)shareDbService;

-(BOOL)creatTable:(NSString*)_sql;/**创建表*/
- (BOOL)insertData:(NSString*)_sql;/**插入数据*/
- (BOOL)deleteData:(NSString*)_sql;/**删除数据*/
- (FMResultSet*)selectData:(NSString*)_sql;/**查找数据*/
- (BOOL)updateData:(NSString*)_sql;/**修改数据*/

-(void)releaseDbService;

@end
