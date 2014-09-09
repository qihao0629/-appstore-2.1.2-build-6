//
//  Ty_Order_Root_Controller.h
//  腾云家务
//
//  Created by lgs on 14-8-19.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"
#import "Ty_Order_Master_Controller.h"
#import "Ty_Order_Worker_Controller.h"

@interface Ty_Order_Root_Controller : TYBaseView
{
    Ty_Order_Worker_Controller * order_Worker;
    Ty_Order_Master_Controller * order_Master;
}

@end
