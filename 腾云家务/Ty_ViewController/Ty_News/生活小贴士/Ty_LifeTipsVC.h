//
//  Ty_LifeTipsVC.h
//  腾云家务
//
//  Created by liu on 14-8-6.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ty_LifeTipsBusine.h"

@interface Ty_LifeTipsVC : TYBaseView <UITableViewDataSource,UITableViewDelegate>
{
    Ty_LifeTipsBusine *_lifeTipsBusine;
    
    UITableView *_tableView;
    
}

@end
