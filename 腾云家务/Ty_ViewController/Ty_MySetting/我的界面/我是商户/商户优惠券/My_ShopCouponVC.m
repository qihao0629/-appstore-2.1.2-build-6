//
//  My_ShopCouponVC.m
//  腾云家务
//
//  Created by AF on 14-7-17.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_ShopCouponVC.h"
#import "My_ShopCoupon_busine.h"
#import "MyShopCouponCell.h"
#import "My_CouponDetailedModel.h"
@interface My_ShopCouponVC ()
{
    My_CouponDetailedModel * _my_Shopcoupon_model;
}
@end

@implementation My_ShopCouponVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _my_Shopcoupon_model = [[My_CouponDetailedModel alloc]init];

    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT - 20- 44- 49 )style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    _tableView.backgroundView = nil;
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
    
    [self addNotificationForName:@"MyShopCouponList"];
    
    My_ShopCoupon_busine * my_shopCoupon = [[My_ShopCoupon_busine alloc]init];
    my_shopCoupon.my_shopCoupon_model = _my_Shopcoupon_model;
    [my_shopCoupon My_shopCouponListCurrentPage:@"1"];
    my_shopCoupon.delegate = self;
    [self showLoadingInView:self.view];
    
}


#pragma mark - 网络_回调
-(void)netRequestReceived:(NSNotification *)_notification{
    [self hideLoadingView];
    
    if ([[_notification object] isKindOfClass:[NSString class]] && [[_notification object] isEqualToString:@"fail"]) {
        
        [self alertViewTitle:@"提示" message:@"网络连接暂时不可用，请稍后再试"];
        
    }else {
        if ([[[_notification object] objectForKey:@"code"]intValue] == 200) {
            
            [_tableView reloadData];
            
        }else if ([[[_notification object] objectForKey:@"code"]intValue] == 203 ){
            
            [self showMessageInView:self.view message:@"暂无优惠券信息"];
            
        }else{
            
            [self alertViewTitle:@"提示" message:[[_notification object] objectForKey:@"msg"]];
            
        }
        
    }
    
}


#pragma mark - UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _my_Shopcoupon_model.array_Coupon.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * CouponCellID = @"couponShopCell";
    
    MyShopCouponCell * cell = [tableView dequeueReusableCellWithIdentifier:CouponCellID];
    
    if (cell == nil) {
        
        cell = [[MyShopCouponCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CouponCellID];
        
    }
    
    cell.labelNumber.text = [NSString stringWithFormat:@"序列号: %@",[[_my_Shopcoupon_model.array_Coupon objectAtIndex:indexPath.section] objectForKey:@"couponNo"]];
    if ([[[_my_Shopcoupon_model.array_Coupon objectAtIndex:indexPath.section] objectForKey:@"couponSuitWorkType"] isEqualToString:@"1"]) {
        cell.labelWorkText.text = @"适用全部工种";

    }else{
        
        NSString * strWork = [[NSString alloc]init];

        for (int i = 0; i < [[[_my_Shopcoupon_model.array_Coupon objectAtIndex:indexPath.section] objectForKey:@"suitWork"] count]; i++) {
            
            if (ISNULLSTR(strWork)) {
                
                strWork = [NSString stringWithFormat:@"%@",[[[_my_Shopcoupon_model.array_Coupon objectAtIndex:indexPath.section] objectForKey:@"suitWork"] objectAtIndex:i]];
                
            }else{
                
                strWork = [NSString stringWithFormat:@"%@/%@",strWork,[[[_my_Shopcoupon_model.array_Coupon objectAtIndex:indexPath.section] objectForKey:@"suitWork"] objectAtIndex:i]];
                
            }
            
        }
        cell.labelWorkText.text = strWork;

    
    }
    cell.labelConditions.text = [NSString stringWithFormat:@"使用条件: 该优惠券可低%@元现金",[[_my_Shopcoupon_model.array_Coupon objectAtIndex:indexPath.section] objectForKey:@"couponCutPrice"]];
    
    cell.labelUser.text = [NSString stringWithFormat:@"使用人: %@",[[_my_Shopcoupon_model.array_Coupon objectAtIndex:indexPath.section] objectForKey:@"ucUserRealName"]];
    
    cell.labelMoneyText.text = [NSString stringWithFormat:@"%@元",[[_my_Shopcoupon_model.array_Coupon objectAtIndex:indexPath.section] objectForKey:@"couponCutPrice"]];
    
    if ([self heightForString:cell.labelWorkText.text fontSize:13.0f andWidth:230] > 20) {
        cell.labelWorkText.frame = CGRectMake(70 , 40, 230, [self heightForString:cell.labelWorkText.text fontSize:13.0f andWidth:230]);
        cell.labelConditions.frame = CGRectMake(10 , 50 + cell.labelWorkText.frame.size.height , 200, 20);
        cell.labelUser.frame = CGRectMake(10 , 80 + cell.labelWorkText.frame.size.height , 200, 20);

    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.backgroundColor = [UIColor whiteColor];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * strWork = [[NSString alloc]init];
    
    for (int i = 0; i < [[[_my_Shopcoupon_model.array_Coupon objectAtIndex:indexPath.section] objectForKey:@"suitWork"] count]; i++) {
        
        if (ISNULLSTR(strWork)) {
            
            strWork = [NSString stringWithFormat:@"%@",[[[_my_Shopcoupon_model.array_Coupon objectAtIndex:indexPath.section] objectForKey:@"suitWork"] objectAtIndex:i]];
            
        }else{
            
            strWork = [NSString stringWithFormat:@"%@/%@",strWork,[[[_my_Shopcoupon_model.array_Coupon objectAtIndex:indexPath.section] objectForKey:@"suitWork"] objectAtIndex:i]];
            
        }
        
    }
    if ([self heightForString:strWork fontSize:13.0f andWidth:230] > 20) {
        
        return 110 + [self heightForString:strWork fontSize:13.0f andWidth:230];
        
    }else{
        
        return 130;
        
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10;
}

#pragma mark - 字符串高度

- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
