//
//  Ty_Map_Model.h
//  腾云家务
//
//  Created by AF on 14-7-24.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ty_Map_Model : NSObject
/**用户Guid*/
@property (nonatomic,strong) NSString * userGuid;
/**用户头像*/
@property (nonatomic,strong) NSString * userPhoto;
/**家政名称*/
@property (nonatomic,strong) NSString * intermediaryName;
/**评价*/
@property (nonatomic,strong) NSString * userEvaluate;
/**商户多少位阿姨*/
@property (nonatomic,strong) NSString * intermediarySize;

@end
