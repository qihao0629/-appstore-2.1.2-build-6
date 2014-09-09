//
//  Ty_NewsVC.h
//  腾云家务
//
//  Created by 齐 浩 on 14-5-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageListTableView.h"
#import "JumpToNextDelegate.h"
#import "Ty_MessageList_Busine.h"

@interface Ty_NewsVC : TYBaseView<JumpToNextDelegate>
{
    MessageListTableView *_messageListTableView;
    Ty_MessageList_Busine *_messageListBusine;
}


@end
