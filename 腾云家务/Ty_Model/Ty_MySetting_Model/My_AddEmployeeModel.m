//
//  My_AddEmployeeModel.m
//  腾云家务
//
//  Created by 艾飞 on 14/7/9.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_AddEmployeeModel.h"

@implementation My_AddEmployeeModel
@synthesize userAddressDetail = _userAddressDetail;
@synthesize userBirthday = _userBirthday;
@synthesize userPhoto = _userPhoto;
@synthesize userRealName = _userRealName;
@synthesize userSex = _userSex;
@synthesize userSmallPhoto = _userSmallPhoto;
@synthesize detailCensus = _detailCensus;
@synthesize detailIdcard = _detailIdcard;
@synthesize detailIdcardElectronic = _detailIdcardElectronic;
@synthesize smallDetailIdcardElectronic = _smallDetailIdcardElectronic;
@synthesize detailIntermediaryUserNumber = _detailIntermediaryUserNumber;
@synthesize detailPhone = _detailPhone;
@synthesize detailRecord = _detailRecord;

@synthesize allkey_ModelParameter = _allkey_ModelParameter;
@synthesize allkey_ModelParameterName = _allkey_ModelParameterName;

@synthesize allkey_ModelFile = _allkey_ModelFile;
@synthesize allkey_ModelFileName = _allkey_ModelFileName;



- (instancetype)init
{
    self = [super init];
    if (self) {
     
        _userAddressDetail = @"";
        _userBirthday = @"";
        _userRealName = @"";
        _userSex = @"";
        _detailCensus = @"";
        _detailIdcard = @"";
        _detailIntermediaryUserNumber = @"";
        _detailPhone = @"";
        _detailRecord = @"";
        
        _allkey_ModelParameterName = [[NSMutableArray alloc]initWithObjects:@"userAddressDetail",@"userBirthday",@"userRealName",@"userSex",@"detailCensus",@"detailIdcard",@"detailIntermediaryUserNumber",@"detailPhone",@"detailRecord",nil];
        
        _allkey_ModelFileName = [[NSMutableArray alloc]initWithObjects:@"userPhoto",@"userSmallPhoto",@"detailIdcardElectronic",@"smallDetailIdcardElectronic",nil];
        

    }
    return self;
}

-(void)addAllkey_Model{
    
    _allkey_ModelParameter = [[NSMutableArray alloc]initWithObjects:self.userAddressDetail,self.userBirthday,self.userRealName,self.userSex,self.detailCensus,self.detailIdcard,self.detailIntermediaryUserNumber,self.detailPhone,self.detailRecord,nil];

    _allkey_ModelFile = [[NSMutableArray alloc]initWithObjects:self.userPhoto,self.userSmallPhoto,self.detailIdcardElectronic,self.smallDetailIdcardElectronic,nil];

}

@end
