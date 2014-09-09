//
//  ServiceObject.m
//  腾云家务
//
//  Created by 齐 浩 on 13-10-9.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "Ty_Model_ServiceObject.h"

@implementation Ty_Model_ServiceObject

@synthesize headPhoto;
@synthesize headPhotoGaoQing;
@synthesize keep;
@synthesize numTemper;
@synthesize userGuid;
@synthesize userName;
@synthesize userRealName;
@synthesize userType;
@synthesize city;
@synthesize province;
@synthesize area;
@synthesize region;
@synthesize addressDetail;
@synthesize evaluate;
@synthesize idCard;
@synthesize distanceString;
@synthesize serviceNumber;
@synthesize phoneNumber;
@synthesize detailOtherInfo;
@synthesize YZRemark;
@synthesize YZQuote;
@synthesize YZTime;

@synthesize companiesGuid;
@synthesize companyPhoto;
@synthesize companyUserName;
@synthesize companyUserRealName;
@synthesize companyUserAnnear;
@synthesize respectiveCompanies;
@synthesize introductionString;
@synthesize intermediaryResponsiblePerson;//中介负责人联系人
@synthesize intermediaryResponsiblePersonPhone;//联系人电话
@synthesize intermediaryRegisterTime;//中介创建时间
@synthesize intermediaryBusinessTime;//中介营业时间
@synthesize intermediary_City;
@synthesize intermediary_Province;
@synthesize intermediary_Area;
@synthesize intermediary_Region;
@synthesize intermediary_AddressDetail;
@synthesize price;
@synthesize companyPhoneNumber;
@synthesize empCount;
@synthesize UserArray;

@synthesize quality;//质量
@synthesize attitude;//态度
@synthesize speedStr;//速度

@synthesize pingjiaString;

@synthesize longitude;
@synthesize latitude;

@synthesize sex;
@synthesize age;
@synthesize education;
@synthesize workExperience;
@synthesize ethnic;
@synthesize hometown;
@synthesize workTypeArray;
@synthesize evaluationArray;

@synthesize userNameSpell ;
@synthesize userPost;

-(id)init
{
    self = [super init];
    if (self) {
        
        
        headPhoto=@"";
        headPhotoGaoQing=@"";
        keep=NO;
        numTemper = @"";
        userGuid=@"";
        userName = @"";
        userRealName = @"";
        userType=@"";
        city = @"";
        province = @"";
        area = @"";
        region = @"";
        addressDetail = @"";
        evaluate = @"";
        idCard=@"";
        distanceString=@"";
        serviceNumber = @"0";
        phoneNumber = @"";
        detailOtherInfo=@"";
        YZRemark = @"";
        YZQuote = @"";
        YZTime = @"";
        
        companiesGuid = @"";
        companyPhoto=@"";
        companyUserName = @"";
        companyUserRealName = @"";
        companyUserAnnear = @"";
        respectiveCompanies=@"";
        introductionString=@"";
        intermediaryResponsiblePerson = @"";
        intermediaryResponsiblePersonPhone = @"";
        intermediaryBusinessTime=@"";
        intermediaryRegisterTime=@"";
        intermediary_City = @"";
        intermediary_Province = @"";
        intermediary_Area = @"";
        intermediary_Region = @"";
        intermediary_AddressDetail = @"";
        price=@"";
        companyPhoneNumber = @"";
        empCount = @"0";
        
        
        quality=@"";//质量
        attitude=@"";//态度
        speedStr=@"";//速度
        longitude=@"";
        latitude=@"";
        
        pingjiaString=@"";
        
        sex = @"不限";
        age = @"不限";
        education = @"不限";
        workExperience = @"不限";
        ethnic = @"不限";
        hometown = @"不限";
        
        workTypeArray=[[NSMutableArray alloc]init];
        evaluationArray=[[NSMutableArray alloc]init];
        UserArray=[[NSMutableArray alloc]init];
        
        userPost = @"";
        userNameSpell = @"";
    }
    return self;
}
- (id)copyWithZone:(NSZone *)zone {
    copy = [[[self class] allocWithZone: zone] init];

    copy.headPhoto=[self.headPhoto copyWithZone:zone];
    copy.headPhotoGaoQing=[self.headPhotoGaoQing copyWithZone:zone];
    copy.keep=self.keep;
    copy.numTemper=[self.numTemper copyWithZone:zone];
    copy.userGuid=[self.userGuid copyWithZone:zone];
    copy.userName=[self.userName copyWithZone:zone];
    copy.userRealName=[self.userRealName copyWithZone:zone];
    copy.userType=[self.userType copyWithZone:zone];
    copy.city=[self.city copyWithZone:zone];
    copy.province=[self.province copyWithZone:zone];
    copy.area=[self.area copyWithZone:zone];
    copy.region=[self.region copyWithZone:zone];
    copy.addressDetail=[self.addressDetail copyWithZone:zone];
    copy.evaluate=[self.evaluate copyWithZone:zone];
    copy.idCard=[self.idCard copyWithZone:zone];
    copy.distanceString=[self.distanceString copyWithZone:zone];
    copy.serviceNumber=[self.serviceNumber copyWithZone:zone];
    copy.phoneNumber=[self.phoneNumber copyWithZone:zone];
    copy.detailOtherInfo=[self.detailOtherInfo copyWithZone:zone];
    copy.YZRemark=[self.YZRemark copyWithZone:zone];
    copy.YZQuote=[self.YZQuote copyWithZone:zone];
    copy.YZTime=[self.YZTime copyWithZone:zone];
    
    copy.companiesGuid=[self.companiesGuid copyWithZone:zone];
    copy.companyPhoto=[self.companyPhoto copyWithZone:zone];
    copy.companyUserName=[self.companyUserName copyWithZone:zone];
    copy.companyUserRealName=[self.companyUserRealName copyWithZone:zone];
    copy.companyUserAnnear = [self.companyUserAnnear copyWithZone:zone];
    copy.respectiveCompanies=[self.respectiveCompanies copyWithZone:zone];
    copy.introductionString=[self.introductionString copyWithZone:zone];
    copy.intermediaryResponsiblePerson=[self.intermediaryResponsiblePerson copyWithZone:zone];//中介负责人联系人
    copy.intermediaryResponsiblePersonPhone=[self.intermediaryResponsiblePersonPhone copyWithZone:zone];//联系人电话
    copy.intermediaryRegisterTime=[self.intermediaryRegisterTime copyWithZone:zone];//中介创建时间
    copy.intermediaryBusinessTime=[self.intermediaryBusinessTime copyWithZone:zone];//中介营业时间
    copy.intermediary_City=[self.intermediary_City copyWithZone:zone];
    copy.intermediary_Province=[self.intermediary_Province copyWithZone:zone];
    copy.intermediary_Area=[self.intermediary_Area copyWithZone:zone];
    copy.intermediary_Region=[self.intermediary_Region copyWithZone:zone];
    copy.intermediary_AddressDetail=[self.intermediary_AddressDetail copyWithZone:zone];
    copy.companyPhoneNumber=[self.companyPhoneNumber copyWithZone:zone];
    copy.empCount=[self.empCount copyWithZone:zone];
    copy.UserArray=[self.UserArray mutableCopy];
    
    copy.quality=[self.quality copyWithZone:zone];//质量
    copy.attitude=[self.attitude copyWithZone:zone];//态度
    copy.speedStr=[self.speedStr copyWithZone:zone];//速度
    
    copy.pingjiaString=[self.pingjiaString copyWithZone:zone];
    
    copy.longitude=[self.longitude copyWithZone:zone];
    copy.latitude=[self.latitude copyWithZone:zone];
    
    copy.sex=[self.sex copyWithZone:zone];
    copy.age=[self.age copyWithZone:zone];
    copy.education=[self.education copyWithZone:zone];
    copy.workExperience=[self.workExperience copyWithZone:zone];
    copy.ethnic=[self.ethnic copyWithZone:zone];
    copy.hometown=[self.hometown copyWithZone:zone];
    copy.workTypeArray=[self.workTypeArray mutableCopy];
    copy.evaluationArray=[self.evaluationArray mutableCopy];
    
    copy.userNameSpell = [self.userNameSpell copyWithZone:zone];
    copy.userPost = [self.userPost copyWithZone:zone];

    return copy;
}
@end
