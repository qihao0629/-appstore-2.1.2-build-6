//
//  Ty_MyFans_Busine.h
//  腾云家务
//
//  Created by Xu Zhao on 14-7-2.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ty_DbMethod.h"


@interface Ty_MyFans_Busine : TY_BaseBusine
{
    NSString *strTime;
}

@property(nonatomic,strong)NSMutableArray *arrFans;
@property(nonatomic,strong)NSMutableArray *arrSection;
@property(nonatomic,strong)NSMutableArray *arrSectionNum;

+ (Ty_MyFans_Busine *)share_Busine_DataBase;


-(BOOL)getMyFansFromSqlWithSearch:(NSString *)_search;
-(void)getMyFansFromNetwork;

-(void)freshData;
@end
