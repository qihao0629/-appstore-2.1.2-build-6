//
//  XmppManager.h
//  腾云家务
//
//  Created by liu on 14-5-29.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"
#import "XMPPAutoPing.h"

@class Ty_Model_MessageInfo;

@interface XmppManager : NSObject<XMPPStreamDelegate,XMPPReconnectDelegate,XMPPAutoPingDelegate>
{
    XMPPReconnect *_xmppReconnect;
    XMPPAutoPing *_xmppAutoPing;
    
    //用于保存(登陆后续操作)的block
    void (^saveLoginCompletionBlock)(BOOL);
    //用于保存(登出后续操作)的block
    void (^saveLogoutCompletionBlock)(BOOL);
    
   // BOOL _isConnect;
    
}


@property (nonatomic,strong) NSString *password;

@property (nonatomic,strong) XMPPStream *xmppStream;

@property (nonatomic,assign) BOOL isConnect;

//@property (nonatomic,assign) BOOL is


+ (XmppManager *)shareXmppManager;

//登陆
- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password andCompletion:(void (^)(BOOL))cb;
//登出
- (void)logoutWithCompletion:(void (^)(BOOL))cb;
//上线
- (void)goOnline;
//下线
- (void)goOffline;

- (void)sendMessage:(Ty_Model_MessageInfo *)messageInfo;

- (void)reconnect;



@end
