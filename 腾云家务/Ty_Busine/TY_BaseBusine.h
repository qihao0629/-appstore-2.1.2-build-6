//
//  TY_BaseBusine.h
//  腾云家务
//
//  Created by 齐 浩 on 14-8-20.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol Ty_BaseBusineDelegate <NSObject>
@optional
-(void)netRequestReceived:(NSNotification *)_notification;

@end
@interface TY_BaseBusine : NSObject
@property(nonatomic,strong)id<Ty_BaseBusineDelegate>delegate;
@end
