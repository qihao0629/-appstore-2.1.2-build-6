//
//  My_FansModel.m
//  腾云家务
//
//  Created by Xu Zhao on 14-7-2.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_FansModel.h"

@implementation My_FansModel
@synthesize strAttentionGuid;
@synthesize strFansGuid;
@synthesize strUserName;
@synthesize strUserSpell;
@synthesize strUserCompany;
@synthesize strIntermediaryName;
@synthesize strUserPhoto;
@synthesize strUserBigPhoto;
@synthesize strContactTag;
@synthesize strUserType;
@synthesize strUserSex;
@synthesize strUserRealName;
@synthesize strUserEvaluateMaster;
@synthesize strUserEvaluateEmployee;
@synthesize strUserAnnear;
@synthesize strUserAddressDetail;
@synthesize strLng;
@synthesize strLat;
@synthesize strUserServeQuality;
@synthesize strUserServeAttitude;
@synthesize strUserServeSpeed;
@synthesize strDetailIdcard;
@synthesize strDetailRecord;
@synthesize strDetailCensus;
@synthesize strUserServeSize;
@synthesize strUserPost;

- (id)init
{
    self = [super init];
    if (self)
    {
        strAttentionGuid = @"";
        strFansGuid = @"";
        strUserName = @"";
        strUserSpell = @"";
        strUserCompany = @"";
        strIntermediaryName = @"";
        strUserPhoto = @"";
        strUserBigPhoto = @"";
        strContactTag = @"";
        strUserType = @"";
        strUserSex = @"";
        strUserRealName = @"";
        strUserEvaluateMaster = @"";
        strUserEvaluateEmployee = @"";
        strUserAnnear = @"";
        strUserAddressDetail = @"";
        strLng = @"";
        strLat = @"";
        strUserServeQuality = @"";
        strUserServeAttitude = @"";
        strUserServeSpeed = @"";
        strDetailIdcard = @"";
        strDetailRecord = @"";
        strDetailCensus = @"";
        strUserServeSize = @"";
        strUserPost = @"";
    }
    return self;
}

@end
