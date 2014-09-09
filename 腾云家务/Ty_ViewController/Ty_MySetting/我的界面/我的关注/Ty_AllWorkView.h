//
//  Ty_AllWorkView.h
//  腾云家务
//
//  Created by liu on 14-7-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ty_NewWork_Busine.h"
#import "Ty_Model_WorkListInfo.h"
#import "SearchContactDelegate.h"

@interface Ty_AllWorkView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    
    Ty_NewWork_Busine *_newWorkBusine;
    
    Ty_Model_WorkNodeInfo *_workNodeInfo;
    
    NSMutableArray *_allWorkArr;
    
}

@property (nonatomic,assign) id<SearchContactDelegate>delegate;

@end
