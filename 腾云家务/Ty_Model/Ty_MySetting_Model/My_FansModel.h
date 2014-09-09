//
//  My_FansModel.h
//  腾云家务
//
//  Created by Xu Zhao on 14-7-2.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface My_FansModel : NSObject
@property(nonatomic,strong)NSString *strAttentionGuid;//被关注人的guid
@property(nonatomic,strong)NSString *strFansGuid;//粉丝的guid
@property(nonatomic,strong)NSString *strUserName;//粉丝的userName
@property(nonatomic,strong)NSString *strUserSpell;//拼音
@property(nonatomic,strong)NSString *strUserCompany;
@property(nonatomic,strong)NSString *strIntermediaryName;
@property(nonatomic,strong)NSString *strUserPhoto;
@property(nonatomic,strong)NSString *strUserBigPhoto;
@property(nonatomic,strong)NSString *strContactTag;
@property(nonatomic,strong)NSString *strUserType;
@property(nonatomic,strong)NSString *strUserSex;
@property(nonatomic,strong)NSString *strUserRealName;
@property(nonatomic,strong)NSString *strUserEvaluateMaster;
@property(nonatomic,strong)NSString *strUserEvaluateEmployee;
@property(nonatomic,strong)NSString *strUserAnnear;
@property(nonatomic,strong)NSString *strUserAddressDetail;
@property(nonatomic,strong)NSString *strLng;
@property(nonatomic,strong)NSString *strLat;
@property(nonatomic,strong)NSString *strUserServeQuality;
@property(nonatomic,strong)NSString *strUserServeAttitude;
@property(nonatomic,strong)NSString *strUserServeSpeed;
@property(nonatomic,strong)NSString *strDetailIdcard;
@property(nonatomic,strong)NSString *strDetailRecord;
@property(nonatomic,strong)NSString *strDetailCensus;
@property(nonatomic,strong)NSString *strUserServeSize;
@property(nonatomic,strong)NSString *strUserPost;

@end
