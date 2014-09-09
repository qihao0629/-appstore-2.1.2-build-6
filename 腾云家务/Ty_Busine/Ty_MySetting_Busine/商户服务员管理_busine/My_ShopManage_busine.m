//
//  My_ShopManage_busine.m
//  腾云家务
//
//  Created by 艾飞 on 14/7/9.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_ShopManage_busine.h"
//#import "My_AddEmployeeModel.h"
#import "MyImageHandle.h"

@implementation My_ShopManage_busine
@synthesize array_manage;
- (instancetype)init
{
    self = [super init];
    if (self) {
        
       array_manage = [[NSMutableArray  alloc]init];
    }
    return self;
}
#pragma mark - 商户管理员工
-(void)My_ShopManage_Req:(NSString *) currentPage{
    
    NSMutableDictionary * _dic = [[NSMutableDictionary alloc]init];
    [_dic setObject:currentPage forKey:@"currentPage"];
    [_dic setObject:pageSize_Req forKey:@"pageSize"];
    [_dic setObject:MyLoginUserGuid forKey:@"userGuid"];
    
    [[Ty_NetRequestService shareNetWork]formRequest:My_SERVICE_GETSearch andParameterDic:_dic andTarget:self andSeletor:@selector(MyShopManageReqCode:reqDic:)];
}

-(void)MyShopManageReqCode:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            
            [array_manage removeAllObjects];
            [array_manage addObjectsFromArray:[_dic objectForKey:@"rows"]];
            
            NSMutableDictionary * dic_manage = [[NSMutableDictionary alloc]init];
            [dic_manage setObject:[_dic objectForKey:@"code"] forKey:@"code"];
            [dic_manage setObject:array_manage forKey:@"arrayManage"];
            PostNetDelegate(dic_manage,@"MyShopManageReq");
            
        }else{
            
            PostNetDelegate(_dic,@"MyShopManageReq");
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        PostNetDelegate(reqCode,@"MyShopManageReq");
        
    }
    
}


#pragma mark - 员工添加
-(void)My_AddEmployeeCode_Req:(My_AddEmployeeModel *)addModel{
    
    
    NSMutableDictionary * _dicParameter = [[NSMutableDictionary alloc]init];
    [_dicParameter setObject:MyLoginUserGuid forKey:@"myUserGuid"];
    [_dicParameter setObject:[[Guid share] getGuid] forKey:@"userGuid"];
    for (int i = 0; i < addModel.allkey_ModelParameter.count ; i++) {
        
        if (!ISNULL([addModel.allkey_ModelParameter objectAtIndex:i])) {
            
            [_dicParameter setObject:[addModel.allkey_ModelParameter objectAtIndex:i] forKey:[addModel.allkey_ModelParameterName objectAtIndex:i]];
        }
        
    }
    

    NSMutableDictionary * _dicFile = [[NSMutableDictionary alloc]init];
    
    NSString * userGuidHead = [[Guid share] getGuid];

    if (!ISNULL(addModel.userPhoto) && !ISNULL(addModel.userSmallPhoto)) {
        NSString * savePath = [MyImageHandle saveImage:[MyImageHandle imageWithImageSimple:addModel.userPhoto scaledToSize:CGSizeMake(320, 320)] WithName:@".png" type:@"Head" userGuid:userGuidHead];

        [_dicFile setObject:savePath forKey:@"userPhoto"];

        NSString * saveSmallPath = [MyImageHandle saveSmallImage:[MyImageHandle imageWithImageSimple:addModel.userSmallPhoto scaledToSize:CGSizeMake(65, 65)] WithName:@".png" type:@"Head" userGuid:userGuidHead];
        [_dicFile setObject:saveSmallPath forKey:@"userSmallPhoto"];
    }
    
    NSString * userGuidCard = [[Guid share] getGuid];

    if (!ISNULL(addModel.detailIdcardElectronic) && !ISNULL(addModel.smallDetailIdcardElectronic)) {
        NSString * savePath = [MyImageHandle saveImage:[MyImageHandle imageWithImageSimple:addModel.detailIdcardElectronic scaledToSize:CGSizeMake(320, 320)] WithName:@".png" type:@"Card" userGuid:userGuidCard];
        
        [_dicFile setObject:savePath forKey:@"detailIdcardElectronic"];
        
        NSString * saveSmallPath = [MyImageHandle saveSmallImage:[MyImageHandle imageWithImageSimple:addModel.smallDetailIdcardElectronic scaledToSize:CGSizeMake(65, 65)] WithName:@".png" type:@"Card" userGuid:userGuidCard];
        [_dicFile setObject:saveSmallPath forKey:@"smallDetailIdcardElectronic"];
    }

    [[Ty_NetRequestService shareNetWork]formRequest:My_AddEmployee_Req andParameterDic:_dicParameter andfileDic:_dicFile andTarget:self andSeletor:@selector(My_AddEmployeeReqCode:reqDic:)];
}

-(void)My_AddEmployeeReqCode:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            
            PostNetDelegate(_dic,@"MyAddEmployee");
            
        }else{
            
            PostNetDelegate(_dic,@"MyAddEmployee");
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        PostNetDelegate(reqCode,@"MyAddEmployee");
        
    }
    
}

@end
