//
//  Ty_Home_SelectCityVC.h
//  腾云家务
//
//  Created by 齐 浩 on 14-5-14.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSLocation.h"
#import <CoreLocation/CoreLocation.h>

@protocol Ty_Home_SelectCityVCDelegate <NSObject>

@optional
-(void)Home_SelectCity:(TSLocation*)_home_selectData;

@end

@interface Ty_Home_SelectCityVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,CLLocationManagerDelegate>
{
    NSMutableArray* tableArray;//显示城市
    NSMutableArray *searchResults;//搜索城市
    NSMutableArray* ArrayPinYin;//所有城市拼音
    NSMutableArray* Array;//所有城市
//    NSString* locationCity;//定位城市
    UITableView* tableview;
    NSMutableDictionary* cityDic;
    NSMutableArray* IndexArray;
    UISearchBar *mySearchBar;
    UISearchDisplayController *searchDisplayController;
    id<Ty_Home_SelectCityVCDelegate>delegate;
    UIActivityIndicatorView *_netMind;
    
    
    BOOL isNewLocation;//定位 判断
    
}
@property(nonatomic,strong)TSLocation* home_selectData;//获取选择城市信息

@property(nonatomic,strong)id<Ty_Home_SelectCityVCDelegate>delegate;
//定位
@property (nonatomic,retain)CLLocationManager* locationManager;
@property (nonatomic, retain) CLGeocoder *myGeocoder;

@end
