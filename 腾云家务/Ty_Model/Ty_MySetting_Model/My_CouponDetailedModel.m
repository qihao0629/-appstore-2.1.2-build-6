//
//  My_CouponDetailedModel.m
//  腾云家务
//
//  Created by 艾飞 on 14/6/18.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_CouponDetailedModel.h"

@implementation My_CouponDetailedModel
@synthesize array_Coupon = _array_Coupon;
@synthesize couponRequiremnetGuid = _couponRequiremnetGuid;
@synthesize couponGuid = _couponGuid;
@synthesize couponPhoto = _couponPhoto;
@synthesize couponType = _couponType;
@synthesize couponDetail = _couponDetail;
@synthesize couponNo = _couponNo;
@synthesize couponSuitWorkType = _couponSuitWorkType;
@synthesize couponTitle = _couponTitle;
@synthesize ucEndTime = _ucEndTime;
@synthesize suitWork = _suitWork;
@synthesize couponSuitCompanyType = _couponSuitCompanyType;
@synthesize suitCompany = _suitCompany;
@synthesize ucUseTime = _ucUseTime;
@synthesize couponPullPrice = _couponPullPrice;
@synthesize couponCutPrice = _couponCutPrice;
@synthesize array_CouponShop = _array_CouponShop;
@synthesize selectBool = _selectBool;
@synthesize suitWorkArray = _suitWorkArray;
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _couponRequiremnetGuid = @"";
        _couponGuid = @"";
        _couponType = @"0";//default0
        _couponDetail = @"";
        _couponPhoto = @"";
        _couponNo = @"";
        _couponSuitWorkType = @"";
        _couponTitle = @"";
        _ucEndTime = @"";
        _suitWork = @"";
        _couponSuitCompanyType = @"";
        _ucUseTime = @"";
        _couponPullPrice = @"";
        _couponCutPrice = @"";
        _selectBool = NO;
        _suitCompany = [[NSArray alloc]init];
        _array_CouponShop = [[NSMutableArray alloc]init];
        _array_Coupon = [[NSMutableArray alloc] init];
        _suitWorkArray = [[NSMutableArray alloc] init];
    }
    return self;
}
/*
 lgs用到了这个model，所以加了一个copy方法
 */
- (id)copyWithZone:(NSZone *)zone
{
    copy = [[[self class] allocWithZone: zone] init];
    copy.couponRequiremnetGuid = [self.couponRequiremnetGuid copyWithZone:zone];
    copy.couponGuid=[self.couponGuid copyWithZone:zone];
    copy.couponType = [self.couponType copyWithZone:zone];
    copy.selectBool = self.selectBool;
    copy.couponDetail=[self.couponDetail copyWithZone:zone];
    copy.couponNo=[self.couponNo copyWithZone:zone];
    copy.couponSuitCompanyType = [self.couponSuitCompanyType copyWithZone:zone];
    copy.couponSuitWorkType=[self.couponSuitWorkType copyWithZone:zone];
    copy.couponTitle=[self.couponTitle copyWithZone:zone];
    copy.ucEndTime=[self.ucEndTime copyWithZone:zone];
    copy.suitWork=[self.suitWork copyWithZone:zone];
    copy.couponPhoto = [self.couponPhoto copyWithZone:zone];
    copy.ucUseTime=[self.ucUseTime copyWithZone:zone];
    copy.couponPullPrice = [self.couponPullPrice copyWithZone:zone];
    copy.couponCutPrice=[self.couponCutPrice copyWithZone:zone];
    copy.array_Coupon = [self.array_Coupon mutableCopy];
    copy.suitCompany = [self.suitCompany copy];
    copy.array_CouponShop =  [self.array_CouponShop mutableCopy];
    copy.suitWorkArray = [self.suitWorkArray mutableCopy];
    
    return copy;
}

@end
