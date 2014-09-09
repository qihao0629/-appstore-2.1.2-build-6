//
//  Ty_MyFansView.h
//  腾云家务
//
//  Created by Xu Zhao on 14-7-2.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ty_MyFansTableViewCell.h"
#import "MessageVC.h"

@interface Ty_MyFansView : TYBaseView<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIButton *btnLeft;
    
    UISearchBar *search;
    //UISearchDisplayController *searchController;
}
@property(nonatomic,strong)UIViewController *superVC;
@property(nonatomic,strong)UITableView *tableview;

@end
