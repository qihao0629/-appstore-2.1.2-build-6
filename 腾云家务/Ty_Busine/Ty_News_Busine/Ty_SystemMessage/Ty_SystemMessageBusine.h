//
//  Ty_SystemMessageBusine.h
//  腾云家务
//
//  Created by 齐 浩 on 14-7-12.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ty_SystemMessageBusine : NSObject

@property(nonatomic,strong)NSMutableArray* messageArray;

-(void)getMessageFromNet:(NSString *)flag reqGuid:(NSString *)_reqGuid;

-(void)selectSystemMsgByPageNum:(NSInteger)currentPageNum;

/**
 *  将系统消息设为已读
 */
- (void)setSystemMsgIsRead;

@end
