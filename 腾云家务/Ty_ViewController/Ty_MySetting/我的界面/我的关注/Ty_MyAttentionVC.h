//
//  Ty_MyAttentionVC.h
//  腾云家务
//
//  Created by liu on 14-7-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ty_NewMyAttention_Busine.h"
#import "SearchContactDelegate.h"
#import "Ty_Model_WorkNodeInfo.h"

@interface Ty_MyAttentionVC :TYBaseView<UITableViewDataSource,UITableViewDelegate,SearchContactDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
{
    BOOL _isWorkViewShow;
    
    UITableView *_tableView;
    
    Ty_NewMyAttention_Busine *_myAttentionBusine;
    
    NSMutableDictionary *_allContactDic;
    NSMutableArray *_allKeysArr;
    
    UISearchBar *_searchBar;
    UISearchDisplayController *_searchController;
    
    UIView *_hideView;
    
    NSMutableDictionary *_searchDic;
    NSMutableArray *_searchArr;
    
    BOOL _isSearch;
}


@end
