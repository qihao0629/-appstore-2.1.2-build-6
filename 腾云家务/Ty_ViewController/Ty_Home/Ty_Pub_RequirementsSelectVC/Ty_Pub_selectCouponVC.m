//
//  Ty_Pub_selectCouponVC.m
//  腾云家务
//
//  Created by 齐 浩 on 14-8-12.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Pub_selectCouponVC.h"
#import "My_CouponDetailedModel.h"
#import "My_EmployerCouponTableViewCell.h"

@interface Ty_Pub_selectCouponVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _tableView;
}
@end

@implementation Ty_Pub_selectCouponVC
@synthesize selectCouponBusine;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        selectCouponBusine = [[Ty_Pub_selectCouponBusine alloc] init];
        selectCouponBusine.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"选择优惠券";
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20,SCREEN_HEIGHT - 20- 44 - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = view_BackGroudColor;
    _tableView.backgroundView = nil;
    _tableView.showsVerticalScrollIndicator = NO;
    
    
    self.button_ok.hidden = NO;
    [self.button_ok setImage:JWImageName(@"button_ok") forState:UIControlStateNormal];
    [self.button_ok addTarget:self action:@selector(selectCouponOk) forControlEvents:UIControlEventTouchUpInside];
    
    selectCouponBusine.my_coupon_model.couponGuid = selectCouponBusine.xuqiuInfo.usedCouponInfo.couponGuid;
    
    [selectCouponBusine Pub_CouponRequest];
    [self showLoadingInView:self.view];
    // Do any additional setup after loading the view.
}
-(void)selectCouponOk
{
    if (selectCouponBusine.my_coupon_model.selectBool) {
        selectCouponBusine.xuqiuInfo.usedCouponInfo.couponGuid = selectCouponBusine.my_coupon_model.couponGuid;
        selectCouponBusine.xuqiuInfo.usedCouponInfo.couponTitle = selectCouponBusine.my_coupon_model.couponTitle;
        selectCouponBusine.xuqiuInfo.usedCouponInfo.couponCutPrice = selectCouponBusine.my_coupon_model.couponCutPrice;
    }else{
        selectCouponBusine.xuqiuInfo.usedCouponInfo.couponGuid = @"";
        selectCouponBusine.xuqiuInfo.usedCouponInfo.couponTitle = @"";
        selectCouponBusine.xuqiuInfo.usedCouponInfo.couponCutPrice = @"";
    }
    
    [self.naviGationController popViewControllerAnimated:YES];
}
#pragma mark ----网络回调
-(void)netRequestReceived:(NSNotification *)_notification
{
    [self hideLoadingView];
    
    if ([[_notification object] isEqualToString:@"200"]) {
        [self.view addSubview:_tableView];
    }else if([[_notification object] isEqualToString:@"203"]){
        [self showMessageInView:self.view message:@"您没有适用的优惠券"];
    }else{
        [self showNetMessageInView:self.view];
    }
}
-(void)loading
{
    [self showLoadingInView:self.view];
    [selectCouponBusine Pub_CouponRequest];
}
#pragma mark - UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return selectCouponBusine.array_Coupon.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * strCell = @"my_couponCell";
    
    My_EmployerCouponTableViewCell * cell = [tableView  dequeueReusableCellWithIdentifier:strCell];
    
    if (cell == nil) {
        
        cell = [[My_EmployerCouponTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
        
    }

    [cell.imageViewCoupon setImageWithURL:[NSURL URLWithString:[[selectCouponBusine.array_Coupon objectAtIndex:indexPath.section] couponPhoto]] placeholderImage:JWImageName(@"pub_coupon")];
    
    cell.labelNumberCoupon.text = [NSString stringWithFormat:@"序列号:%@",[[selectCouponBusine.array_Coupon objectAtIndex:indexPath.section] couponNo]];
    
    cell.labelDayCoupon.text = [NSString stringWithFormat:@"截止日期:%@",[[selectCouponBusine.array_Coupon objectAtIndex:indexPath.section] ucEndTime]];
    cell.imageViewCouponExpired.image = [UIImage imageNamed:@"pub_couponSelectImage"];
    if ([[selectCouponBusine.array_Coupon objectAtIndex:indexPath.section] selectBool]) {
        cell.imageViewCouponExpired.hidden = NO;
    }else{
        cell.imageViewCouponExpired.hidden = YES;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.backgroundColor = [UIColor whiteColor];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (selectCouponBusine.my_coupon_model == [selectCouponBusine.array_Coupon objectAtIndex:indexPath.section]) {
        selectCouponBusine.my_coupon_model.selectBool = !selectCouponBusine.my_coupon_model.selectBool;
    }else{
        selectCouponBusine.my_coupon_model.selectBool = NO;
        selectCouponBusine.my_coupon_model = [selectCouponBusine.array_Coupon objectAtIndex:indexPath.section];
        selectCouponBusine.my_coupon_model.selectBool = YES;
    }
    
    [tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
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

#pragma mark - 返回顶部
-(void)tableviewTop{
    
    [_tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    
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
