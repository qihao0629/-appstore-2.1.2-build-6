//
//  Ty_NetDefine_Message.h
//  腾云家务
//
//  Created by liu on 14-6-6.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#ifndef _____Ty_NetDefine_Message_h
#define _____Ty_NetDefine_Message_h


#define URL_GetMsgContactInfo @"user/SearchSimpleUserInfo.action"
#define URL_SendVoiceMsg @"message/SendMessageGetAddress.action"

/**
 * requirementGuid 订单GUID
 * requirementPayMoney 支付金额
 */
#define URL_UPPay @"upmp/UnionPayMoney.action"

/**
 *  线下支付
 */

#define URL_UPPayDirect @"requirement/OfflinePayMoney.action"


/**
 *  系统消息
 */
#define URL_SystemMessage @"requirement/QueryNoticeMessage.action"


/**
 *  小贴士
 */
#define URL_LifeTips @"liveTips/getLatestLiveTips.action"



#endif
