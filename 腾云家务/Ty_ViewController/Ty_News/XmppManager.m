//
//  XmppManager.m
//  腾云家务
//
//  Created by liu on 14-5-29.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "XmppManager.h"
#import "Ty_Model_MessageInfo.h"
#import "Ty_Message_Busine.h"
#import "Ty_MessageList_Busine.h"
#import "StatusNotificationBar.h"
#import "AppDelegateViewController.h"
#import "Ty_NewsVC.h"
#import "MessageVC.h"
#import "SBJSON.h"
#import "SBJsonParser.h"


static XmppManager *_shareXmppManager = nil;

@implementation XmppManager

@synthesize password = _password;
@synthesize xmppStream = _xmppStream;
@synthesize isConnect = _isConnect;

+ (XmppManager *)shareXmppManager
{
    if ( nil == _shareXmppManager)
    {
        _shareXmppManager = [[XmppManager alloc]init];
    }
    
    return _shareXmppManager;
}

- (id)init
{
    if (self = [super init])
    {
        _isConnect = NO;
        
        //初始化xmppstream
        _xmppStream = [[XMPPStream alloc] init];
        //[_xmppStream setHostName:@"118.192.98.175"];
        
        [_xmppStream setHostName:XMPPHostName];
        [_xmppStream setHostPort:5222];
        _xmppStream.enableBackgroundingOnSocket = NO;
        [_xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
        
        _xmppReconnect = [[XMPPReconnect alloc] init];
        [_xmppReconnect activate:_xmppStream];
        [_xmppReconnect autoReconnect];
        _xmppReconnect.autoReconnect = YES;
        _xmppReconnect.reconnectTimerInterval = 1;
        _xmppReconnect.usesOldSchoolSecureConnect = YES;
        [_xmppReconnect addDelegate:self delegateQueue:dispatch_get_main_queue()];
        
        
        _xmppAutoPing = [[XMPPAutoPing alloc]init];
        [_xmppAutoPing activate:_xmppStream];
        [_xmppAutoPing addDelegate:self delegateQueue:dispatch_get_main_queue()];
        _xmppAutoPing.respondsToQueries= YES;
        _xmppAutoPing.pingInterval = 4;
        _xmppAutoPing.pingTimeout = 5;
        _xmppAutoPing.targetJID = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@",@"jidisec",@"family"]];
       // _xmppAutoPing.targetJID = [XMPPJID jidWithString:nil];
        
        
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reconnect) userInfo:nil repeats:YES];
        
    }
    
    return self;
}

#pragma mark --- login

/**
 *  登录
 *
 *  @param username 用户名
 *  @param password 密码
 *  @param cb       登录信息
 */
- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password andCompletion:(void (^)(BOOL))cb
{
    //保存登陆信息
    saveLoginCompletionBlock = [cb copy];
    self.password = password;
    
    XMPPJID *myJid = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@_%@@%@",username,@"family",@"jidisec"]];
    
    //给_xmppStream设置一个账号
    [_xmppStream setMyJID:myJid];
    if ([_xmppStream isConnected])
    {
        [_xmppStream disconnect];
    }
    NSError *err = nil;
    //不能连接服务器两次
    [_xmppStream connectWithTimeout:-1 error:&err];
}

#pragma mark ---Logout---
//登出
- (void)logoutWithCompletion:(void (^)(BOOL))cb
{
    //保存登出信息
    saveLogoutCompletionBlock = [cb copy];
    //下线
    [self goOffline];
    //断开连接
    [_xmppStream disconnect];
}

#pragma mark ---Online And Offline---
- (void)goOnline
{
    /*
     *XMPPPresence *presence = [XMPPPresence presence] 和
     *XMPPPresence *presence = [XMPPPresence presenceWithType:@"available"] 的意思是一样的
     */
    _isConnect = YES;
    
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"available"];
    //向服务器发送XML请求
    [_xmppStream sendElement:presence];
}

- (void)goOffline
{
    _isConnect = NO;
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    //向服务器发送XML请求
    [_xmppStream sendElement:presence];
    
}

#pragma mark --- xmppStreamDelegate

- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq
{
    
	return YES;
}
//发送状态成功调用此方法
- (void)xmppStream:(XMPPStream *)sender didSendPresence:(XMPPPresence *)presence
{
    if ([[presence type] isEqualToString:@"unavailable"])
    {
        if (saveLogoutCompletionBlock)
        {
            saveLogoutCompletionBlock(YES);
        }
    }
}

//发送状态失败调用此方法
- (void)xmppStream:(XMPPStream *)sender didFailToSendPresence:(XMPPPresence *)presence error:(NSError *)error
{

    //NSLog(@"%@",error);
    if ([[presence type] isEqualToString:@"unavailable"])
    {
        if (saveLogoutCompletionBlock)
        {
            saveLogoutCompletionBlock(NO);
        }
    }
    _isConnect = NO;
   
}

//连接成功调用此方法
- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    NSError *err = nil;
    //利用密码授权
    [_xmppStream authenticateWithPassword:_password error:&err];
}



//授权登陆成功调用此方法
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    if (saveLoginCompletionBlock)
    {
        saveLoginCompletionBlock(YES);
    }
    //上线
    [self goOnline];
    
}

//授权登陆失败调用此方法
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
    /******
     <failure xmlns="urn:ietf:params:xml:ns:xmpp-sasl">
     <not-authorized/>
     </failure>
     ******/

  
    if (saveLoginCompletionBlock)
    {
        saveLoginCompletionBlock(NO);
    }
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    //将离线状态保存在NSUserDefaults
    // [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"IsLogin"];
    // [[NSUserDefaults standardUserDefaults] synchronize];
    //_isConnect = NO;
    
}
- (void)xmppStreamConnectDidTimeout:(XMPPStream *)sender
{
    //NSLog(@"xmppStreamConnectDidTimeout");
    _isConnect = NO;
}

- (void)xmppStreamWasToldToDisconnect:(XMPPStream *)sender
{
  //  NSLog(@"服务器通知重连~");
    //[self goOffline];
    _isConnect = NO;
    
   // [self reconnect];
}


#pragma mark --- 重连协议 reconnect delegate

- (void)xmppReconnect:(XMPPReconnect *)sender didDetectAccidentalDisconnect:(SCNetworkReachabilityFlags)connectionFlags
{
  //  NSLog(@"didDetectAccidentalDisconnect:%u",connectionFlags);
    _isConnect = NO;
}
- (BOOL)xmppReconnect:(XMPPReconnect *)sender shouldAttemptAutoReconnect:(SCNetworkReachabilityFlags)reachabilityFlags
{
 // NSLog(@"shouldAttemptAutoReconnect:%u",reachabilityFlags);
    _isConnect = NO;
    return YES;
}


#pragma mark --- xmppautoping
- (void)xmppAutoPingDidSendPing:(XMPPAutoPing *)sender
{
    
  //  NSLog(@"%d: %s",__LINE__, __FUNCTION__);
    
}

- (void)xmppAutoPingDidReceivePong:(XMPPAutoPing *)sender
{
    
  //  NSLog(@"%d: %s",__LINE__, __FUNCTION__);
    
}



- (void)xmppAutoPingDidTimeout:(XMPPAutoPing *)sender
{
    
   // NSLog(@"%d: %s",__LINE__, __FUNCTION__);
    [self goOffline];
    _isConnect = NO;
    
    [self reconnect];
    
}



#pragma mark ---- 发送消息相关
- (void)sendMessage:(Ty_Model_MessageInfo *)messageInfo
{
    
    NSString *detailIntermediaryName = [MyLoginInformation objectForKey:@"detailIntermediaryName"];
    NSString *selfName = ISNULLSTR(detailIntermediaryName) ?  [MyLoginInformation objectForKey:@"userRealName"] : [MyLoginInformation objectForKey:@"detailIntermediaryName"] ;

    //处理发出消息的xml格式
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:selfName,XmppMessageContactRealName,[NSString stringWithFormat:@"%d",messageInfo.messageType],XmppMessageType,messageInfo.messageGuid,XmppMessageGuid,messageInfo.messageSenderGuid,XmppMessageSendUserGuid,messageInfo.messageTime,XmppMessageTime,messageInfo.messageContactGuid,XmppMessageReceiveGuid,[NSString stringWithFormat:@"%d",messageInfo.messageContactType],XmppMessageContactType,[NSString stringWithFormat:@"%d",messageInfo.messageContactSex],XmppMessageContactSex, nil];
    
    NSXMLElement *message1 = [NSXMLElement elementWithName:@"message"];
    [message1 addAttributeWithName:@"type" stringValue:@"chat"];
    [message1 addAttributeWithName:@"to" stringValue:[NSString stringWithFormat:@"%@@jidisec",messageInfo.messageContactJIDName]];
    [message1 addAttributeWithName:@"from" stringValue:[NSString stringWithFormat:@"%@_family@jidisec/Smack",[MyLoginInformation objectForKey:@"userName"]]];
    
    
    /**
     *  a代表消息guid
     *  b代表消息发送人的真名
     *  c代表消息类型
     *  d代表消息的时间
     *  e代表消息发送人的头像
     *  f代表消息内容
     *  g消息发出人guid
     *  h消息接收人guid
     */
    NSMutableDictionary *jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:messageInfo.messageGuid,@"a",selfName,@"b",[NSString stringWithFormat:@"%d",messageInfo.messageType],@"c",messageInfo.messageTime,@"d",messageInfo.messageType == -1 ? messageInfo.messageContent :messageInfo.messageVoiceServicePath,@"f",messageInfo.messageSenderGuid,@"g",messageInfo.messageContactGuid,@"h", nil];
    
    NSString *photoStr = [MyLoginInformation objectForKey:@"userPhoto"];
    if (photoStr.length > PhotoUrl.length)
    {
        photoStr = [photoStr substringFromIndex:PhotoUrl.length];
        //photoStr = [photoStr substringToIndex:32];
      //  photoStr = [photoStr stringByAppendingString:@".png"];
        [jsonDic setObject:photoStr forKey:@"e"];
    }
    if ([[MyLoginInformation objectForKey:@"userAnnear"] length] > 0)
    {
        [jsonDic setObject:[MyLoginInformation objectForKey:@"userAnnear"] forKey:@"i"];
    }
   
    SBJSON *json = [[SBJSON alloc]init];
    NSString *jsonStr = [json stringWithObject:jsonDic];
    json = nil;
    
    
  //  [message1 addAttributeWithName:@"type" stringValue:@"chat"];
    
    
    NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
    [body setStringValue:jsonStr];
    
    [message1 addChild:body];
    NSLog(@"%@",message1);
    [_xmppStream sendElement:message1];
    
    /*
    [body setStringValue:messageInfo.messageType == -1 ? messageInfo.messageContent :messageInfo.messageVoiceServicePath];
    
    
    NSXMLElement *addtionProperty = [NSXMLElement elementWithName:@"properties"];
    [addtionProperty addAttributeWithName:@"xmlns" stringValue:@"http://www.jivesoftware.com/xmlns/xmpp/properties"];
    
    for (NSString *key in dic.allKeys)
    {

        
        NSXMLElement *ele1 = [NSXMLElement elementWithName:@"name"];
        [ele1 setStringValue:key];
        NSXMLElement *ele2 = [NSXMLElement elementWithName:@"value"];
        [ele2 addAttributeWithName:@"type" stringValue:@"string"];
        [ele2 setStringValue:[dic objectForKey:key]];
        NSXMLElement *ele3 = [NSXMLElement elementWithName:@"property"];
        [ele3 addChild:ele1];
        [ele3 addChild:ele2];
        
        [addtionProperty addChild:ele3];
    }
    */
     
//    [message1 addChild:body];
//    NSLog(@"%@",message1);
  //  [message1 addChild:addtionProperty];
    
  //  [_xmppStream sendElement:message1];
    
}

#pragma mark -- 发送状态回调
//发送信息成功调用此方法
- (void)xmppStream:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message
{
    NSLog(@"发送成功");
    Ty_Model_MessageInfo *messageInfo = [[Ty_Model_MessageInfo alloc]init];
    [self dealReceivedMessage:message  data:messageInfo];

    //通知气泡页
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GetMessage_SendMsgSuccess" object:messageInfo];
    messageInfo = nil;
    
}

//发送消息失败调用此方法
- (void)xmppStream:(XMPPStream *)sender didFailToSendMessage:(XMPPMessage *)message error:(NSError *)error
{
    _isConnect = NO;
    
    Ty_Model_MessageInfo *messageInfo = [[Ty_Model_MessageInfo alloc]init];
    [self dealReceivedMessage:message  data:messageInfo];
    
    Ty_Message_Busine *messageBusine = [[Ty_Message_Busine alloc]init];
    [messageBusine updateMessageSendStatusByMessageGuid:messageInfo.messageGuid];
    messageBusine = nil;
    
    //通知气泡页
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GetMessage_SendMsgFail" object:messageInfo];
    messageInfo = nil;
    
    NSLog(@"发送失败");
}

#pragma mark ---  收消息
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    
    NSLog(@"%@",message);
    
    
    Ty_Model_MessageInfo *messageInfo = [[Ty_Model_MessageInfo alloc]init];
    
    [self dealReceivedMessage:message  data:messageInfo];
    
    Ty_MessageList_Busine *messageListBusine = [[Ty_MessageList_Busine alloc]init];
    
    if (![messageListBusine isMsgContactInfoExist:messageInfo.messageContactGuid])
    {
        //无此联系人信息，先从服务器查询
        [messageListBusine getMsgContactInfoFromNetWithContactGuid:messageInfo.messageContactGuid];
    }
    
    if (messageInfo.messageType == -1)
    {
        [messageListBusine insertMessageIntoTable:messageInfo];
        [self checkCurrentVC:messageInfo];
    }
    else
    {
        Ty_Message_Busine *messageBusine = [[Ty_Message_Busine alloc]init];
        [messageBusine downLoadVoiceMessage:messageInfo];
        messageBusine = nil;
    }
    
    
    /*
    if (messageInfo.messageType == -1)
    {
        [messageListBusine insertMessageIntoTable:messageInfo];
     
     
        //通知气泡页
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetMessage" object:messageInfo];
        
        //通知列表页
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshMsgList" object:nil];
        
        [[StatusNotificationBar shareNotificationBar] showStatusMessage:[NSString stringWithFormat:@"%@发来一条消息",messageInfo.messageContactRealName]];
        
        if ([[[UIApplication sharedApplication] keyWindow].rootViewController isKindOfClass:[AppDelegateViewController class]])
        {
            AppDelegateViewController *appDelegateVC = (AppDelegateViewController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
            [appDelegateVC setTabBarIcon:[messageListBusine getAllUnreadMessageNum] atIndex:1];
        }
        
    }
    else
    {
        Ty_Message_Busine *messageBusine = [[Ty_Message_Busine alloc]init];
        [messageBusine downLoadVoiceMessage:messageInfo];
        messageBusine = nil;
    }
    
    */
    
}

- (void)dealReceivedMessage:(XMPPMessage *)message data:(Ty_Model_MessageInfo *)messageInfo
{
    
    
    /**
     *  a代表消息guid
     *  b代表消息发送人的真名
     *  c代表消息类型
     *  d代表消息的时间
     *  e代表消息发送人的头像
     *  f代表消息内容
     *  g消息发出人guid
     *  h消息接收人guid
     */
    NSString *contentJsonStr = [NSString stringWithString:[[message elementForName:@"body"] stringValue]];
   // NSLog(@"%@",content);
    SBJsonParser *jsonPaser = [[SBJsonParser alloc]init];
    
    NSMutableDictionary *dic = [jsonPaser objectWithString:contentJsonStr];
    
    messageInfo.messageContactRealName = [dic objectForKey:@"b"];
    messageInfo.messageTime = [dic objectForKey:@"d"];
    messageInfo.messageType = [[dic objectForKey:@"c"] integerValue];
    messageInfo.messageGuid = [dic objectForKey:@"a"];
    messageInfo.messageSenderGuid = [dic objectForKey:@"g"];
    messageInfo.messageContactGuid = [dic objectForKey:@"g"];
    messageInfo.messageContent = [dic objectForKey:@"f"];
    messageInfo.messageContactPhoto = [dic objectForKey:@"e"];
    messageInfo.messageContactAnnear = [dic objectForKey:@"i"];
    
    NSString *string = [[message attributeForName:@"from"] stringValue];
    NSString *contactName  = [[string componentsSeparatedByString:@"@"] objectAtIndex:0];
    messageInfo.messageContactJIDName = contactName;
   
    

   // DDXMLDocument *xmlDoc = [[DDXMLDocument alloc] initWithXMLString:[message elementForName:@"properties"].description options:0 error:nil];
   // NSLog(@"%@",xmlDoc);
  //  NSArray *users = [xmlDoc nodesForXPath:@"/*/*" error:nil];
    
    
    /*
    for (DDXMLElement *user in users)
    {
        NSString *name = [[user elementForName:@"name"] stringValue];
     //   NSLog(@"%@",name);
        
        if ([name isEqualToString:XmppMessageContactRealName])
        {
            messageInfo.messageContactRealName = [[user elementForName:@"value"] stringValue];
        }
        else if ([name isEqualToString:XmppMessageContactSex])
        {
            messageInfo.messageContactSex = [[[user elementForName:@"value"] stringValue] integerValue];
        }
        else if ([name isEqualToString:XmppMessageGuid])
        {
            messageInfo.messageGuid = [[user elementForName:@"value"] stringValue];
        }
        else if ([name isEqualToString:XmppMessageSendUserGuid])
        {
            messageInfo.messageContactGuid = [[user elementForName:@"value"] stringValue];
            messageInfo.messageSenderGuid = [[user elementForName:@"value"] stringValue];
        }
        else if ([name isEqualToString:XmppMessageTime])
        {
            messageInfo.messageTime = [[user elementForName:@"value"]stringValue];
        }
        else if ([name isEqualToString:XmppMessageType])
        {
            messageInfo.messageType = [[[user elementForName:@"value"] stringValue] integerValue];
        }
        
        
    }
    */
     
    
    if (messageInfo.messageType == -1)
    {
        //messageInfo.messageContent = content;
    }
    else
    {
        messageInfo.messageVoiceServicePath = messageInfo.messageContent;
        messageInfo.messageContent = @"";
      
    }
    

}

- (void)checkCurrentVC:(Ty_Model_MessageInfo *)messageInfo
{
    if ([[[UIApplication sharedApplication] keyWindow].rootViewController isKindOfClass:[AppDelegateViewController class]])
    {
        AppDelegateViewController *appDelegateVC = (AppDelegateViewController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
        NSLog(@"%@",appDelegateVC.appNavigation);
        NSLog(@"%@",appDelegateVC.appNavigation.naviGationController.viewControllers);
        NSArray *controllerArr = appDelegateVC.appNavigation.naviGationController.viewControllers;
        /*
        if ([appDelegateVC.appNavigation isKindOfClass:[Ty_NewsVC class]] )
        {
            if (controllerArr.count == 1) //在信息的列表页
            {
                
            }
            else //不在信息的列表页，但是当前页面是从列表页进去的
            {
                if([[controllerArr lastObject] isKindOfClass:[MessageVC class]])//信息的气泡页
                {
                    
                }
                else//既不在气泡页，也不在列表页
                {
                    
                }
            }
        }
        else
        {
            if ([[controllerArr lastObject] isKindOfClass:[MessageVC class]])
            {
                
            }
        }
        */
        
        
        if ([[controllerArr lastObject] isKindOfClass:[MessageVC class]])
        {
            MessageVC *messageVC = (MessageVC *)[controllerArr lastObject];
            if ([messageVC.contactGuid isEqualToString:messageInfo.messageContactGuid])
            {
                //通知气泡页
                [[NSNotificationCenter defaultCenter] postNotificationName:@"GetMessage" object:messageInfo];
            }
            else
            {
                
                [[StatusNotificationBar shareNotificationBar] showStatusMessage:[NSString stringWithFormat:@"%@发来一条消息",messageInfo.messageContactRealName]];
                
                [self refreshIconNum];
            }
        }
        else
        {
            if ([appDelegateVC.appNavigation isKindOfClass:[Ty_NewsVC class]] && controllerArr.count == 1)//列表页
            {
                //通知列表页
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshMsgList" object:nil];
                
                [self refreshIconNum];
            }
            else
            {
                [[StatusNotificationBar shareNotificationBar] showStatusMessage:[NSString stringWithFormat:@"%@发来一条消息",messageInfo.messageContactRealName]];
               [self refreshIconNum];
            }
        }
    }
    else
    {
        [[StatusNotificationBar shareNotificationBar] showStatusMessage:[NSString stringWithFormat:@"%@发来一条消息",messageInfo.messageContactRealName]];
        //通知列表页
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshMsgList" object:nil];
        [self refreshIconNum];
    }

}
- (void)refreshIconNum
{
    if ([[[UIApplication sharedApplication] keyWindow].rootViewController isKindOfClass:[AppDelegateViewController class]])
    {
        Ty_MessageList_Busine *messageListBusine = [[Ty_MessageList_Busine alloc]init];
        AppDelegateViewController *appDelegateVC = (AppDelegateViewController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
        [appDelegateVC setTabBarIcon:[messageListBusine getAllUnreadMessageNum] atIndex:1];
        messageListBusine = nil;
    }
}


#pragma mark -- 重连
- (void)reconnect
{
    
   // if (isLogin != nil )
   // {
        if (IFLOGINYES == 1)
        {
            if (!_isConnect )
            {
                [self logoutWithCompletion:nil];
               // NSLog(@"重连");
                //登录成功后，调用XMPPManager登录xmpp
                NSString *password_md5 = [MyLoginInformation objectForKey:@"userpassword"];
                NSString *password = [NSString stringWithFormat:@"%@%@",[password_md5 substringToIndex:3],[password_md5 substringWithRange:NSMakeRange(29, 3)]];

                
                [self loginWithUsername:[MyLoginInformation  objectForKey:@"userName"]  andPassword:password andCompletion:^(BOOL ret)
                 {
                     if (ret)
                     {
                         //登录成功
                         NSLog(@"xmpp登录成功~");
                     }
                     else
                     {
                         //失败
                         NSLog(@"xmpp登录失败~~");
                     }
                 }];
            }
            
            
        }
    }
    
//}




@end
