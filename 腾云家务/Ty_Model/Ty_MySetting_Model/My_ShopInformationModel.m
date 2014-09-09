//
//  My_ShopInformationModel.m
//  腾云家务
//
//  Created by AF on 14-8-14.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_ShopInformationModel.h"

@implementation My_ShopInformationModel

@synthesize detailIntermediaryName = _detailIntermediaryName;
@synthesize detailIntermediaryResponsiblePerson = _detailIntermediaryResponsiblePerson;
@synthesize detailIntermediaryRegisterTime = _detailIntermediaryRegisterTime;
@synthesize detailIntermediaryBusinessTime = _detailIntermediaryBusinessTime;
@synthesize detailIntermediaryArea = _detailIntermediaryArea;
@synthesize detailIntermediaryAddress = _detailIntermediaryAddress;
@synthesize detailIntermediaryPhone = _detailIntermediaryPhone;
@synthesize userCoordinateLng = _userCoordinateLng;
@synthesize userCoordinateLat = _userCoordinateLat;
@synthesize detailIntermediaryOtherInfo = _detailIntermediaryOtherInfo;
@synthesize intermediaryElectronic = _intermediaryElectronic;
@synthesize smallIntermediaryElectronic = _smallIntermediaryElectronic;


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _detailIntermediaryName = @"";
        _detailIntermediaryResponsiblePerson = @"";
        _detailIntermediaryRegisterTime = @"";
        _detailIntermediaryBusinessTime = @"";
        _detailIntermediaryArea = @"";
        _detailIntermediaryAddress = @"";
        _detailIntermediaryPhone = @"";
        _userCoordinateLng = @"";
        _userCoordinateLat = @"";
        _detailIntermediaryOtherInfo = @"";
        
    }
    return self;
}


@end
