//
//  XuQiuInfo.m
//  短工平台1.0
//
//  Created by liu on 13-6-18.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "Ty_Model_XuQiuInfo.h"

@implementation Ty_Model_XuQiuInfo

@synthesize contact;
@synthesize contactPhone;
@synthesize submitTime;
@synthesize startTime;
@synthesize endTime;
@synthesize workAmount;
@synthesize priceUnit;
@synthesize priceTotal;
@synthesize appointMoney;
@synthesize realMoney;
@synthesize selectUserArray;
@synthesize city;
//@synthesize couponGuid;
//@synthesize couponTitle;
//@synthesize couponPrice;
@synthesize province;
@synthesize area;
@synthesize region;
@synthesize addressDetail;
@synthesize employeeArr;

@synthesize ask_Price;
@synthesize ask_Sex;
@synthesize ask_Age;
@synthesize ask_Evaluate;
@synthesize ask_WorkExperience;
@synthesize ask_Distance;
@synthesize ask_Education;
@synthesize ask_Ethnic;
@synthesize ask_Hometown;
@synthesize ask_Other;

@synthesize requirementGuid;
@synthesize requirementNumber;
@synthesize requirement_Stage;
@synthesize requirementStageText;
@synthesize pay_Stage;
@synthesize requirement_Type;
@synthesize workGuid;
@synthesize workName;
@synthesize workPhoto;
@synthesize isApply;
@synthesize employeeCount;
@synthesize confirmTime;
@synthesize updateTime;
@synthesize usedCouponInfo;

@synthesize publishUserGuid;
@synthesize publishUserName;
@synthesize publishUsrRealName;
@synthesize publishUserType;
@synthesize publishUserSex;
@synthesize publishUserPhoto;
@synthesize publishUserPhone;
@synthesize publishUserEvaluate;
@synthesize publishUserAnnear;

@synthesize serverObject;
@synthesize oldOrderPersonRealName;

@synthesize userTypeBaseOnRequirement;
@synthesize candidateStatus;

@synthesize evaluateStage;
@synthesize totalPJ_For_Employee;
@synthesize detailPJ_For_Employee;
@synthesize servicePJ_For_Employee;
@synthesize speedPJ_For_Employee;
@synthesize attitudePJ_For_Employee;
@synthesize totalPJ_For_Employer;
@synthesize detailPJ_For_Employer;

- (id)init
{
    self = [super init];
    
    if (self)
    {

        contact=@"";
        contactPhone=@"";
        submitTime = @"";
        startTime = @"";
        endTime = @"00:00";
        workAmount = @"";
//        couponGuid = @"";
//        couponTitle = @"";
//        couponPrice = @"";
        priceUnit=@"";
        priceTotal = @"";
        appointMoney = @"";
        realMoney = @"";
        selectUserArray = [[NSMutableArray alloc]init];
        city = @"";
        province=@"";
        area=@"";
        region=@"";
        addressDetail = @"";
        employeeArr = [[NSMutableArray alloc]init];
        
        
        ask_Price = @"不限";
        ask_Sex = @"不限";
        ask_Age = @"不限";
        ask_Evaluate = @"不限";
        ask_WorkExperience = @"不限";
        ask_Distance = @"不限";
        ask_Education = @"不限";
        ask_Ethnic = @"不限";
        ask_Hometown = @"不限";
        ask_Other = @"";
        
        
        requirementGuid = @"";
        requirementNumber = @"";
        requirement_Stage = @"0";
        requirementStageText = @"";
        pay_Stage = @"3";
        requirement_Type = @"0";
        workGuid = @"";
        workName = @"";
        workPhoto = @"";
        isApply = @"0";
        employeeCount = @"0";
        confirmTime = @"";
        updateTime = @"";
    
        usedCouponInfo = [[My_CouponDetailedModel alloc]init];
        
        publishUserGuid = @"";
        publishUserName = @"";
        publishUsrRealName = @"";
        publishUserType = @"2";
        publishUserSex = @"1";
        publishUserPhoto = @"";
        publishUserPhone = @"";
        publishUserEvaluate = @"";
        publishUserAnnear = @"";
        
        serverObject = [[Ty_Model_ServiceObject alloc]init];
        oldOrderPersonRealName = @"";
        
        userTypeBaseOnRequirement = @"0";
        candidateStatus = @"0";
        
        evaluateStage = @"0";
        totalPJ_For_Employee = @"0";
        detailPJ_For_Employee = @"";
        servicePJ_For_Employee = @"";
        speedPJ_For_Employee = @"";
        attitudePJ_For_Employee = @"";
        totalPJ_For_Employer = @"0";
        detailPJ_For_Employer = @"";
    }
    
    return self;
}
- (id)copyWithZone:(NSZone *)zone {
    copy = [[[self class] allocWithZone: zone] init];
    copy.contact=[self.contact copyWithZone:zone];
    copy.contactPhone=[self.contactPhone copyWithZone:zone];
    copy.submitTime = [self.submitTime copyWithZone:zone];
    copy.startTime = [self.startTime copyWithZone:zone];
    copy.endTime = [self.endTime copyWithZone:zone];
    copy.workAmount=[self.workAmount copyWithZone:zone];
    copy.priceUnit=[self.priceUnit copyWithZone:zone];
    copy.priceTotal = [self.priceTotal copyWithZone:zone];
    copy.appointMoney = [self.appointMoney copyWithZone:zone];
    copy.realMoney  = [self.realMoney copyWithZone:zone];
    copy.selectUserArray = [self.selectUserArray mutableCopy];
    copy.city = [self.city copyWithZone:zone];
    copy.province=[self.province copyWithZone:zone];
    copy.area=[self.area copyWithZone:zone];
    copy.region=[self.region copyWithZone:zone];
    copy.addressDetail = [self.addressDetail copyWithZone:zone];
    copy.employeeArr = [self.employeeArr mutableCopy];
    
    
    copy.ask_Price = [self.ask_Price copyWithZone:zone];
    copy.ask_Sex = [self.ask_Sex copyWithZone:zone];
    copy.ask_Age = [self.ask_Age copyWithZone:zone];
    copy.ask_Evaluate = [self.ask_Evaluate copyWithZone:zone];
    copy.ask_WorkExperience = [self.ask_WorkExperience copyWithZone:zone];
    copy.ask_Distance = [self.ask_Distance copyWithZone:zone];
    copy.ask_Evaluate = [self.ask_Evaluate copyWithZone:zone];
    copy.ask_Ethnic = [self.ask_Ethnic copyWithZone:zone];
    copy.ask_Hometown = [self.ask_Hometown copyWithZone:zone];
    copy.ask_Other = [self.ask_Other copyWithZone:zone];
    
    
    copy.requirementGuid = [self.requirementGuid copyWithZone:zone];
    copy.requirementNumber = [self.requirementNumber copyWithZone:zone];
    copy.requirement_Stage = [self.requirement_Stage copyWithZone:zone];
    copy.requirementStageText = [self.requirementStageText copyWithZone:zone];
    copy.pay_Stage = [self.pay_Stage copyWithZone:zone];
    copy.requirement_Type = [self.requirement_Type copyWithZone:zone];
    copy.workGuid = [self.workGuid copyWithZone:zone];
    copy.workName = [self.workName copyWithZone:zone];
    copy.workPhoto = [self.workPhoto copyWithZone:zone];
    copy.isApply = [self.isApply copyWithZone:zone];
    copy.employeeCount = [self.employeeCount copyWithZone:zone];
    copy.confirmTime = [self.confirmTime copyWithZone:zone];
    copy.updateTime = [self.updateTime copyWithZone:zone];
    
    copy.usedCouponInfo = [self.usedCouponInfo copy];//优惠券copy
    
    copy.publishUserGuid = [self.publishUserGuid copyWithZone:zone];
    copy.publishUserName = [self.publishUserName copyWithZone:zone];
    copy.publishUsrRealName = [self.publishUsrRealName copyWithZone:zone];
    copy.publishUserType = [self.publishUserType copyWithZone:zone];
    copy.publishUserSex = [self.publishUserSex copyWithZone:zone];
    copy.publishUserPhoto = [self.publishUserPhoto copyWithZone:zone];
    copy.publishUserPhone = [self.publishUserPhone copyWithZone:zone];
    copy.publishUserEvaluate = [self.publishUserEvaluate copyWithZone:zone];
    copy.publishUserAnnear = [self.publishUserAnnear copyWithZone:zone];
    
    copy.serverObject = [self.serverObject copy];
    copy.oldOrderPersonRealName = [self.oldOrderPersonRealName mutableCopy];
    
    copy.userTypeBaseOnRequirement = [self.userTypeBaseOnRequirement copyWithZone:zone];
    copy.candidateStatus = [self.candidateStatus copyWithZone:zone];
    
    copy.evaluateStage = [self.evaluateStage copyWithZone:zone];
    copy.totalPJ_For_Employee = [self.totalPJ_For_Employee copyWithZone:zone];
    copy.detailPJ_For_Employee = [self.detailPJ_For_Employee copyWithZone:zone];
    copy.servicePJ_For_Employee = [self.servicePJ_For_Employee copyWithZone:zone];
    copy.speedPJ_For_Employee = [self.speedPJ_For_Employee copyWithZone:zone];
    copy.attitudePJ_For_Employee = [self.attitudePJ_For_Employee copyWithZone:zone];
    copy.detailPJ_For_Employer = [self.detailPJ_For_Employer copyWithZone:zone];
    copy.totalPJ_For_Employer = [self.totalPJ_For_Employer copyWithZone:zone];
    
    return copy;
}

-(void)dealloc
{
    
}
@end
