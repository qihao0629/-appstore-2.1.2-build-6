//
//  Ty_MyAttention_Busine.h
//  腾云家务
//
//  Created by Xu Zhao on 14-6-3.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ty_NetRequestService.h"
#import "My_AttentionModel.h"
#import "Ty_DbMethod.h"

@interface Ty_MyAttention_Busine : NSObject
{
    My_AttentionModel *attentionModel;
    
    NSString *strTime;
}
@property(nonatomic,strong)NSMutableArray *arrAttention;
@property(nonatomic,strong)NSMutableArray *arrSection;
@property(nonatomic,strong)NSMutableArray *arrSectionNum;
-(void)getMyAttentionFromSqlWithSearch:(NSString *)_search;
-(void)getMyAttentionFromNetwork;

@end
