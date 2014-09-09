//
//  My_ShopCoupon_busine.m
//  腾云家务
//
//  Created by AF on 14-7-17.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_ShopCoupon_busine.h"

@implementation My_ShopCoupon_busine


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        array_ShopCoupon = [[NSMutableArray  alloc]init];
    }
    return self;
}


#pragma mark - 列表
-(void)My_shopCouponListCurrentPage:(NSString *)currentPage {
    
    NSMutableDictionary * dic_req = [[NSMutableDictionary alloc]init];
    [dic_req setObject:MyLoginUserGuid forKey:@"detailUserGuid"];
    [dic_req setObject:currentPage forKey:@"currentPage"];
    [dic_req setObject:pageSize_Req forKey:@"pageSize"];
    
    [[Ty_NetRequestService shareNetWork]formRequest:My_ShopCouponList andParameterDic:dic_req andTarget:self andSeletor:@selector(MyshopCouponListCode:reqDic:)];
    
}

-(void)MyshopCouponListCode:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            [array_ShopCoupon addObjectsFromArray:[_dic objectForKey:@"rows"]];
            
            _my_shopCoupon_model.array_Coupon = array_ShopCoupon;
            
            NSDictionary * dic_req = @{@"code":[_dic objectForKey:@"code"]};
            
            PostNetDelegate(dic_req,@"MyShopCouponList");
            
        }else {
            
            PostNetDelegate(_dic,@"MyShopCouponList");
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        PostNetDelegate(reqCode,@"MyShopCouponList");
        
    }
    
}


@end
