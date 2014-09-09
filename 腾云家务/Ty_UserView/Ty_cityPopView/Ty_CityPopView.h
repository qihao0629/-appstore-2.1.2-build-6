//
//  CityPopView.h
//  腾云家务
//
//  Created by 齐 浩 on 14-3-17.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSLocation.h"
//enum Ty_CityPopViewStyle {
//    cityPopViewStyleOne = 1,//双排－省／市
//    cityPopViewStyleTwo = 2//双排－区／区域
//};
@class Ty_CityPopView;

@protocol Ty_CityPopViewDelegate <NSObject>

-(void)CityPopView:(Ty_CityPopView* )_CityPopView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface Ty_CityPopView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* tableview;
    UITableView* tableview2;
    UIView* backView;
    UIView* secondBackView;
    
    NSArray *provinces;
    NSArray	*cities;
    NSMutableArray *quyus;
    NSMutableArray *regions;
    
    UITapGestureRecognizer *tapGesture;
}
@property(nonatomic,strong)id<Ty_CityPopViewDelegate>delegate;
@property (strong, nonatomic) TSLocation *locate;
@property(retain,nonatomic)NSString* quanshiStates;
@property(retain,nonatomic)NSString* quanshiString;
+(id)shareCityPopView:(CGRect)frame States:(NSString*)_states City:(NSString* )_city;
-(void)showInView:(UIView *)view;
-(void)disAppear;
-(void)dismissKeyBoard;
@end
