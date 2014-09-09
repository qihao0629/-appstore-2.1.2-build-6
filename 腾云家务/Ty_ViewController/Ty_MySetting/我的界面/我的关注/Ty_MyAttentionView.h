//
//  Ty_MyAttentionView.h
//  腾云家务
//
//  Created by Xu Zhao on 14-6-16.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ty_MyAttention_Busine.h"
#import "Ty_MyAttentionTableViewCell.h"
#import "Ty_Home_UserDetailVC.h"
#import "Ty_MyAttentionWork.h"
@interface Ty_MyAttentionView : UIView<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>
{
    Ty_MyAttention_Busine *myAttention;
    
    BOOL workBool,searchBool;
    
    UISearchBar *search;
    UISearchDisplayController *searchController;
    
    UIButton *btnLeft;
}
@property(nonatomic,strong)Ty_MyAttentionWork *superVC;
@property(nonatomic,strong)UITableView *tableview;
@end
