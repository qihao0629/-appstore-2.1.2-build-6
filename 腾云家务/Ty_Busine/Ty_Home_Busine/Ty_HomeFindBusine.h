//
//  Ty_HomeFindBusine.h
//  腾云家务
//
//  Created by 齐 浩 on 14-6-11.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSLocation.h"
#import <CoreLocation/CoreLocation.h>
#import "CSqlite.h"
@interface Ty_HomeFindBusine : TY_BaseBusine<CLLocationManagerDelegate>
{
    CLLocationCoordinate2D mylocation;
    CLLocationManager *locationManager;
    CSqlite *m_sqlite;
}
@property(nonatomic,strong)NSMutableArray* shopArray;
@property(nonatomic,strong)NSMutableArray* personalArray;

@property(nonatomic,strong)NSString* userAddress;//区域
@property(nonatomic,strong)NSString* range;//范围

@property(nonatomic,strong)NSString* longitude;/**经纬度*/
@property(nonatomic,strong)NSString* latitude;


@property(nonatomic,strong)NSString* FirstType;

@property(nonatomic,strong)NSMutableArray* workArray;/**筛选工种*/
@property(nonatomic,strong)NSMutableArray* sortArray;/**排序*/

@property(nonatomic,strong)NSString* workFristName;
@property(nonatomic,strong)NSString* workFristGuid;

@property(nonatomic,strong)NSString* selectworkName;
@property(nonatomic,strong)NSString* selectworkGuid;

@property(nonatomic,strong)NSMutableArray* childrenworkArray;
@property(nonatomic,strong)NSMutableDictionary* childrenworkDic;
@property(nonatomic,strong)NSMutableDictionary* workDic;

@property(nonatomic,assign)BOOL sortBool;//筛选排序
@property(nonatomic,assign)BOOL cityBool;//筛选城市
@property(nonatomic,assign)BOOL workBool;//筛选工种

@property(nonatomic,strong)NSString* orderByTerm;//排序 0:最新 1:接活次数 2:评价 3:按距离
@property(nonatomic,assign)int currentPage;//分页页码

@property(nonatomic,assign)BOOL _isRefreshing;//判断上拉刷新

-(void)initShaiXuan;
-(void)cityProcess:(TSLocation*)_location;
-(void)workProcess:(NSString*)_workType;
-(void)sortProcess:(NSString*)_sort;
- (void)OpenGPS;
-(void)loadDatatarget;
-(UIViewController*)didSelectIndexPath:(NSIndexPath*)indexPath;//Cell点击方法
-(UIViewController*)Click_pub_Requirements;//发布需求
-(UIViewController*)Click_LoginVC;//登录

@end
