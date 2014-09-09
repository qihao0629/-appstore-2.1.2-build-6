//
//  Ty_Map_Busine.m
//  腾云家务
//
//  Created by Xu Zhao on 14-6-11.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Map_Busine.h"
#import "Ty_Map_Model.h"
#import "BasicMapAnnotation.h"
@implementation Ty_Map_Busine

#pragma mark - 地图商户搜索
-(void)MapSearchShop:(NSMutableDictionary *)_dicSearch
{
    [[Ty_NetRequestService shareNetWork] formRequest:Map_searchNearlyWorker andParameterDic:_dicSearch andTarget:self andSeletor:@selector(MapSearchShopReqCode: dic:)];
}

-(void)MapSearchShopReqCode:(NSString *)reqCode dic:(NSDictionary *)_dic
{
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            
            NSMutableArray * _arrayMap = [[NSMutableArray alloc]init];
            NSMutableArray * _arrayAnntation = [[NSMutableArray alloc]init];
            
            for (int i = 0; i < [[_dic objectForKey:@"rows"] count]; i++) {
                Ty_Map_Model * mapModel = [[Ty_Map_Model alloc]init];
                mapModel.userGuid = [[[_dic objectForKey:@"rows"] objectAtIndex:i] objectForKey:@"userGuid"];
                mapModel.userPhoto = [[[_dic objectForKey:@"rows"] objectAtIndex:i] objectForKey:@"userPhoto"];
                mapModel.intermediaryName = [[[_dic objectForKey:@"rows"] objectAtIndex:i] objectForKey:@"intermediaryName"];
                mapModel.userEvaluate = [[[_dic objectForKey:@"rows"] objectAtIndex:i] objectForKey:@"userEvaluate"];
                mapModel.intermediarySize = [[[_dic objectForKey:@"rows"] objectAtIndex:i] objectForKey:@"intermediarySize"];
                [_arrayMap addObject:mapModel];
                
                BasicMapAnnotation *  annotation = [[BasicMapAnnotation alloc] initWithTitle:nil Subtitle:nil Coordinate:CLLocationCoordinate2DMake([[[[_dic objectForKey:@"rows"] objectAtIndex:i] objectForKey:@"lat"] floatValue], [[[[_dic objectForKey:@"rows"] objectAtIndex:i] objectForKey:@"lng"] floatValue])];
            
                [_arrayAnntation addObject:annotation];

            }
            
            
            NSMutableDictionary * _dicMap = [[NSMutableDictionary alloc]init];
            [_dicMap setValue:_arrayMap forKeyPath:@"arrayMap"];
            [_dicMap setObject:@"200" forKey:@"code"];
            [_dicMap setObject:_arrayAnntation forKey:@"arrayAnnotation"];
            PostNetNotification(_dicMap,@"MapSearchShopReq");
            
        }else{
            
            PostNetNotification(_dic,@"MapSearchShopReq");
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        PostNetNotification(reqCode,@"MapSearchShopReq");
        
    }
}

@end
