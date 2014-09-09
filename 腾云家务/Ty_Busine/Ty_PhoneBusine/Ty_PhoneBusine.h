//
//  Ty_PhoneBusine.h
//  腾云家务
//
//  Created by 齐 浩 on 14-8-20.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ty_Phone_Model.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"

@interface Ty_PhoneBusine : NSObject<ASIHTTPRequestDelegate>
+(Ty_PhoneBusine *)sharePhone;
-(void)savePhoneData:(Ty_Phone_Model *)_phone_Model;//存电话记录
-(void)sendPhoneData;//上传电话记录
@end
