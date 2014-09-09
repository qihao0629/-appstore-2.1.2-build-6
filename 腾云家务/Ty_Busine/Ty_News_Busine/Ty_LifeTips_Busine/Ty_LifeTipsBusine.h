//
//  Ty_LifeTipsBusine.h
//  腾云家务
//
//  Created by liu on 14-8-14.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ty_LifeTipsBusine : NSObject

@property (nonatomic,strong) NSMutableArray *lifeTipsArr;

- (void)getLifeDataFromNet;


/**
 *  从数据库查询信息数据
 *
 *  @param pageNum 当前页
 */
- (void)getLifeMessageDataByPageNum:(NSInteger)pageNum;

-(void)setAllLifeTipsStatusRead;

@end
