//
//  Ty_SystemMessageVC.h
//  腾云家务
//
//  Created by liu on 14-7-12.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ty_SystemMessageBusine.h"


@interface Ty_SystemMessageVC : TYBaseView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    
    NSMutableArray *_allMessageArr;
    
    Ty_SystemMessageBusine *_systemMsgBusine;
}


@end
