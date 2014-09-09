//
//  Ty_SearchBusine.h
//  腾云家务
//
//  Created by 齐 浩 on 14-7-9.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSLocation.h"
#import <CoreLocation/CoreLocation.h>
#import "CSqlite.h"

@interface Ty_SearchBusine : TY_BaseBusine<CLLocationManagerDelegate>
{
    CLLocationCoordinate2D mylocation;
    CLLocationManager *locationManager;
    CSqlite *m_sqlite;
}
@property(nonatomic,strong)NSString* searchText;
@property(nonatomic,strong)NSMutableArray* markArray;
@property(nonatomic,assign)BOOL searchBool;
@property(nonatomic,strong)NSString* longitude;/**经纬度*/
@property(nonatomic,strong)NSString* latitude;
@property(nonatomic,assign)int currentPage;//分页页码

@property(nonatomic,assign)BOOL _isRefreshing;//判断上拉刷新

@property(nonatomic,strong)NSMutableArray* shopArray;
@property(nonatomic,strong)NSMutableArray* personalArray;

-(void)searchBegin:(NSString* )_text;//搜索开始
-(void)loadDatatarget;//加载数据


-(void)reloadMarkData;//更新数组数据源
-(void)removeMarkData;//删除所有数据
-(void)insertMarkMessage:(NSString*)message;//插入一条数据
-(BOOL)isHave:(NSString* )message;//判断是否数据重复

-(UIViewController*)didSelectIndexPath:(NSIndexPath*)indexPath;//Cell点击方法


@end
