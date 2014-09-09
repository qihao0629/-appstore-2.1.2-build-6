//
//  Ty_Model_LifeTipsInfo.h
//  腾云家务
//
//  Created by liu on 14-8-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ty_Model_LifeTipsInfo : NSObject

@property (nonatomic,strong) NSString *lifeTipsGuid;

@property (nonatomic,strong) NSString *lifeTipsContent;

@property (nonatomic,strong) NSString *lifeTipsTitle;

@property (nonatomic,strong) NSString *lifeTipsDate;

@property (nonatomic,strong) NSString *lifeTipsContentImg;

@property (nonatomic,assign) NSInteger lifeTipsIsRead;



@end
