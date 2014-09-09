//
//  Ty_News_Busine_Jpush.h
//  腾云家务
//
//  Created by lgs on 14-5-30.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ty_News_Busine_Jpush : TY_BaseBusine
/**初始化JPush类*/
+(Ty_News_Busine_Jpush *)shareJpush;


/**初始化Jpush*/
-(void)setupWithOption:(NSDictionary *)launchingOption;
/**绑定token*/
-(void)registerDeviceToken:(NSData*)_token;
/**存储Jpush相关信息，将token存到本地的plist中*/
-(void)saveTokenToUserDefaultWithDeviceToken:(NSData*)deviceToken;
/**设置别名*/
-(void)setJpush;
/**取消别名*/
-(void)releaseJpush;


@end
