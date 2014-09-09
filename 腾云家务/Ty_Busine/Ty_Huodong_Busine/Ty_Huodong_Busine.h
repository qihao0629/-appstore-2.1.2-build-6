//
//  Ty_Huodong_Busine.h
//  腾云家务
//
//  Created by Xu Zhao on 14-5-29.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ty_NetRequestService.h"

@interface Ty_Huodong_Busine : NSObject
{
    NSMutableArray *arrHuodongList;
}
@property(nonatomic,strong)NSString *acGuid;
@property(nonatomic,strong)NSString *acTitle;
@property(nonatomic,strong)NSString *acContent;
@property(nonatomic,strong)NSString *acPushTime;
@property(nonatomic,strong)NSString *acStartTime;
@property(nonatomic,strong)NSString *acEndTime;
@property(nonatomic,strong)NSString *acHttpUrl;
@property(nonatomic,strong)NSString *acPhoto;
-(void)getHuodongInfo;
@end
