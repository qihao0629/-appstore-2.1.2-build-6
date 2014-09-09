//
//  Ty_MyAttentionWork_Busine.h
//  腾云家务
//
//  Created by Xu Zhao on 14-6-9.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Ty_MyAttentionWork_Busine : NSObject
{
    NSMutableArray *arrWork;
    NSMutableArray *arrWorkName;
    NSMutableArray *arrWorkKind;
}
-(NSMutableArray *)getWorkName;
-(void)getMyAttentionFromSql:(int)_selectRow;

@end


Class a;