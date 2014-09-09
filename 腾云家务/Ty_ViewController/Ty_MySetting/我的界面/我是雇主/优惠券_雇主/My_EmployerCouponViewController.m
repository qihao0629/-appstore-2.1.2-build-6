//
//  My_EmployerCouponViewController.m
//  腾云家务
//
//  Created by 艾飞 on 14/6/16.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_EmployerCouponViewController.h"
#import "My_EmployerCouponTableViewCell.h"
#import "My_EmployerCoupon_busine.h"
#import "My_CouponDetailedViewController.h"//优惠券详细

@interface My_EmployerCouponViewController ()

@end

@implementation My_EmployerCouponViewController
@synthesize my_coupon_model = _my_coupon_model;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)keyboardWillShow:(NSNotification *)notification
{

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"优惠券";
    _my_coupon_model = [[My_CouponDetailedModel alloc]init];
    array_coupon = [[NSMutableArray alloc]init];
    but_select = 0;
    for (int i = 0; i < 3; i ++) {
        
        UIButton * button_coupon = [UIButton buttonWithType:UIButtonTypeCustom];
        button_coupon.frame = CGRectMake(i * (SCREEN_WIDTH/3), 0, SCREEN_WIDTH/3, 32);
        button_coupon.tag = 2400 + i;
        button_coupon.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];

        switch (i) {
            case 0:
                
                [button_coupon setTitle:@"未使用" forState:UIControlStateNormal];
                [button_coupon setTitleColor:ColorRedText forState:UIControlStateNormal];
                [button_coupon setBackgroundImage:[UIImage imageNamed:@"my_coupon_selected.png"] forState:UIControlStateNormal];

                break;
            case 1:
                
                [button_coupon setTitle:@"已使用" forState:UIControlStateNormal];
                [button_coupon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [button_coupon setBackgroundImage:[UIImage imageNamed:@"my_coupon.png"] forState:UIControlStateNormal];

                break;
                
            case 2:
                
                [button_coupon setTitle:@"已过期" forState:UIControlStateNormal];
                [button_coupon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [button_coupon setBackgroundImage:[UIImage imageNamed:@"my_coupon.png"] forState:UIControlStateNormal];
                
                break;
            default:
                break;
        }
        [button_coupon addTarget:self action:@selector(button_couopn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button_coupon];
    }
    for (int i = 1; i < 3; i ++ ) {
        
            UIImageView * imageIine = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/3)*i, 0, 1, 31)];
            imageIine.image = [UIImage imageNamed:@"my_coupon_line.png"];
            [self.view addSubview:imageIine];
        
    }
    
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 32, SCREEN_WIDTH-20,SCREEN_HEIGHT - 20- 44 - 49 - 32) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = view_BackGroudColor;
    _tableView.backgroundView = nil;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

    My_EmployerCoupon_busine * my_coupon_busine =  [[My_EmployerCoupon_busine alloc]init];//请求优惠券列表(未使用)
    [my_coupon_busine My_EmployerCouponReq_busine:@"1" currentPage:@"1"];
    my_coupon_busine.delegate = self;
    [self showLoadingInView:self.view];
    
    [self addNotificationForName:@"MyCouponReq"];
    
    if (_refreshView == nil)
    {
        reqint = 1;
        isSingend = NO;
        _refreshView = [[RefreshView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 20, 40.0)];
        _refreshView._messageLabel.text = @"正在加载...";
        
    }
}

#pragma mark - 上拉加载显示
-(void)loadTableViewFootView
{
    if (_tableView.contentSize.height >= _tableView.bounds.size.height)
    {
        _tableView.tableFooterView = _refreshView;
    }
}

#pragma mark - 未使用 已使用 已过期(优惠券状态)
-(void)button_couopn:(UIButton *)but{
    
    reqint = 1;
    isSingend = NO;
    _refreshView._messageLabel.text = @"正在加载...";
    [_my_coupon_model.array_Coupon removeAllObjects];

    switch (but.tag) {
        case 2400:
        {
            //未使用
            but_select = 0;
            My_EmployerCoupon_busine * my_coupon_busine =  [[My_EmployerCoupon_busine alloc]init];//请求优惠券列表(未使用)
            [my_coupon_busine My_EmployerCouponReq_busine:@"1" currentPage:@"1"];
            my_coupon_busine.delegate = self;
            
            [but setTitleColor:ColorRedText forState:UIControlStateNormal];
            [but setBackgroundImage:[UIImage imageNamed:@"my_coupon_selected.png"] forState:UIControlStateNormal];
            
            UIButton * button_yishiyong = (UIButton *)[self.view viewWithTag:2401];
            UIButton * button_yiguoqi = (UIButton *)[self.view viewWithTag:2402];
            
            [button_yishiyong setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button_yishiyong setBackgroundImage:[UIImage imageNamed:@"my_coupon.png"] forState:UIControlStateNormal];
            [button_yiguoqi setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button_yiguoqi setBackgroundImage:[UIImage imageNamed:@"my_coupon.png"] forState:UIControlStateNormal];
            
            [self showLoadingInView:self.view];
            
            break;
        }
        case 2401:
            //已使用
        {
            but_select = 1;
            My_EmployerCoupon_busine * my_coupon_busine =  [[My_EmployerCoupon_busine alloc]init];//请求优惠券列表(未使用)
            [my_coupon_busine My_EmployerCouponReq_busine:@"2" currentPage:@"1"];
            my_coupon_busine.delegate = self;
            [but setTitleColor:ColorRedText forState:UIControlStateNormal];
            [but setBackgroundImage:[UIImage imageNamed:@"my_coupon_selected.png"] forState:UIControlStateNormal];
            
            UIButton * button_weishiyong = (UIButton *)[self.view viewWithTag:2400];
            UIButton * button_yiguoqi = (UIButton *)[self.view viewWithTag:2402];
            
            [button_weishiyong setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button_weishiyong setBackgroundImage:[UIImage imageNamed:@"my_coupon.png"] forState:UIControlStateNormal];
            [button_yiguoqi setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button_yiguoqi setBackgroundImage:[UIImage imageNamed:@"my_coupon.png"] forState:UIControlStateNormal];
            
            [self showLoadingInView:self.view];
            
            break;
        }
            
        case 2402:
        {
    
            //已过期
            but_select = 2;
            My_EmployerCoupon_busine * my_coupon_busine =  [[My_EmployerCoupon_busine alloc]init];//请求优惠券列表(未使用)
            [my_coupon_busine My_EmployerCouponReq_busine:@"3" currentPage:@"1"];
            my_coupon_busine.delegate = self;
            
            [but setTitleColor:ColorRedText forState:UIControlStateNormal];
            [but setBackgroundImage:[UIImage imageNamed:@"my_coupon_selected.png"] forState:UIControlStateNormal];
            UIButton * button_weishiyong = (UIButton *)[self.view viewWithTag:2400];
            UIButton * button_yishiyong = (UIButton *)[self.view viewWithTag:2401];
            
            [button_weishiyong setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button_weishiyong setBackgroundImage:[UIImage imageNamed:@"my_coupon.png"] forState:UIControlStateNormal];
            [button_yishiyong setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button_yishiyong setBackgroundImage:[UIImage imageNamed:@"my_coupon.png"] forState:UIControlStateNormal];
            
            [self showLoadingInView:self.view];

            break;
        }
        default:
            break;
    }

}

#pragma mark - 优惠券列表——网络回调
-(void)netRequestReceived:(NSNotification *)_notification{
    
    [self hideLoadingView];
    [self hideNetMessageView];
    [self hideMessageView];
    if ([[_notification object] isKindOfClass:[NSString class]] && [[_notification object] isEqualToString:@"fail"]) {
        
        if (reqint == 1) {
            
            isSingend = YES;
            
            [_my_coupon_model.array_Coupon removeAllObjects];

            [self showNetMessageInView:_tableView];
            
            [_tableView reloadData];
            
        }else{
        
            [self alertViewTitle:@"提示" message:@"网络连接暂时不可用，请稍后再试"];

        }
 
        
    }else {
        if ([[[_notification object]objectForKey:@"code"]intValue] == 200) {
            
            [_tableView reloadData];
            
            
            if (reqint == 1) {
                
                [_my_coupon_model.array_Coupon removeAllObjects];
                
            }
            
            reqint = reqint + 1;
            
            _tableView.hidden = NO;
            
            [_my_coupon_model.array_Coupon addObjectsFromArray:[[_notification object] objectForKey:@"rows"]];
            
            [_tableView reloadData];
            
           
            if ([_my_coupon_model.array_Coupon count] == 10) {
                
                _tableView.tableFooterView = _refreshView;
                
            }
            
            if ([[[_notification object] objectForKey:@"rows"] count] < 10) {
                
                //没有数据处理
                isSingend = YES;
                _refreshView._messageLabel.text = @"已加载全部";
                _isRefreshing = NO;
                [self loadTableViewFootView];
                [_tableView reloadData];
                [_refreshView._netMind stopAnimating];
                
            }
        
            
        }else if ([[[_notification object]objectForKey:@"code"]intValue] == 203){

            if (reqint == 1) {
            
                isSingend = YES;
                [_my_coupon_model.array_Coupon removeAllObjects];
                [self showMessageInView:_tableView message:@"暂无优惠券信息"];
                [_tableView reloadData];
                
            }else{
            
                //没有数据处理
                isSingend = YES;
                _refreshView._messageLabel.text = @"已加载全部";
                _isRefreshing = NO;
                [self loadTableViewFootView];
                [_tableView reloadData];
                [_refreshView._netMind stopAnimating];
            
            }
    

        }else{

            [self alertViewTitle:@"提示" message:[[_notification object] objectForKey:@"msg"]];
            
        }
        
    }
    
}

#pragma mark 重新加载代理回执
-(void)loading
{

    reqint = 1;
    isSingend = NO;
    _refreshView._messageLabel.text = @"正在加载...";
    [_my_coupon_model.array_Coupon removeAllObjects];

    switch (but_select) {
        case 0:
        {
            My_EmployerCoupon_busine * my_coupon_busine =  [[My_EmployerCoupon_busine alloc]init];//请求优惠券列表(未使用)
            [my_coupon_busine My_EmployerCouponReq_busine:@"1" currentPage:@"1"];
            my_coupon_busine.delegate = self;

            [self showLoadingInView:self.view];

            break;
        }
        case 1:
        {
            My_EmployerCoupon_busine * my_coupon_busine =  [[My_EmployerCoupon_busine alloc]init];//请求优惠券列表(已使用)
            [my_coupon_busine My_EmployerCouponReq_busine:@"2" currentPage:@"1"];
            my_coupon_busine.delegate = self;

            [self showLoadingInView:self.view];

            break;
        }
        case 2:
        {
            My_EmployerCoupon_busine * my_coupon_busine =  [[My_EmployerCoupon_busine alloc]init];//请求优惠券列表(已过期)
            [my_coupon_busine My_EmployerCouponReq_busine:@"3" currentPage:@"1"];
            my_coupon_busine.delegate = self;

            [self showLoadingInView:self.view];

            break;
        }
        default:
            break;
    }
    
}
#pragma mark - UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _my_coupon_model.array_Coupon.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString * strCell = @"my_couponCell";
    
    My_EmployerCouponTableViewCell * cell = [tableView  dequeueReusableCellWithIdentifier:strCell];
    
    if (cell == nil) {
        
        cell = [[My_EmployerCouponTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
        
    }
    
    [cell.imageViewCoupon setImageWithURL:[NSURL URLWithString:[[_my_coupon_model.array_Coupon objectAtIndex:indexPath.section] objectForKey:@"couponPhoto"]] placeholderImage:JWImageName(@"pub_coupon")];
    
    cell.labelNumberCoupon.text = [NSString stringWithFormat:@"序列号:%@",[[_my_coupon_model.array_Coupon objectAtIndex:indexPath.section] objectForKey:@"couponNo"]];
    
    if (but_select == 1) {
        
        cell.labelDayCoupon.text = [NSString stringWithFormat:@"使用日期:%@",[[_my_coupon_model.array_Coupon objectAtIndex:indexPath.section] objectForKey:@"ucUseTime"]];

    }else{
        
        cell.labelDayCoupon.text = [NSString stringWithFormat:@"截止日期:%@",[[_my_coupon_model.array_Coupon objectAtIndex:indexPath.section] objectForKey:@"ucEndTime"]];
    }
    
    if (but_select == 2) {
        
        cell.imageViewCouponExpired.image = [UIImage imageNamed:@"imageViewCouponExpired.png"];
        
    }else{
        
        cell.imageViewCouponExpired.image = [UIImage imageNamed:@""];

    }
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.backgroundColor = [UIColor whiteColor];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (but_select != 2) {
        My_CouponDetailedViewController * my_couponDetailed = [[My_CouponDetailedViewController alloc]init];
        my_couponDetailed.title = @"优惠券详细";
        my_couponDetailed.couponGuid = [[_my_coupon_model.array_Coupon objectAtIndex:indexPath.section] objectForKey:@"couponGuid"];
        my_couponDetailed.couponNo = [[_my_coupon_model.array_Coupon objectAtIndex:indexPath.section] objectForKey:@"couponNo"];
        my_couponDetailed.coupon_type = [NSString stringWithFormat:@"%d",but_select+1];
        my_couponDetailed.ucState = [[_my_coupon_model.array_Coupon objectAtIndex:indexPath.section] objectForKey:@"ucState"];
    
        [self.naviGationController pushViewController:my_couponDetailed animated:YES];
    }
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
#pragma mark - 上啦
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.bounds.size.height)  && _refreshView != nil)
    {
        NSLog(@"lgs -- 我是上拉刷新");
        
        
        if (isSingend == NO) {
            
            if (!_refreshView._netMind.isAnimating && !_isRefreshing)
            {
                _refreshView._messageLabel.text = @"正在加载...";
                
                NSString * strRow = [NSString stringWithFormat:@"%d",reqint ];
         
                
                switch (but_select) {
                    case 0:
                    {
                        My_EmployerCoupon_busine * my_coupon_busine =  [[My_EmployerCoupon_busine alloc]init];//请求优惠券列表(未使用)
                        [my_coupon_busine My_EmployerCouponReq_busine:@"1" currentPage:strRow];
                        my_coupon_busine.delegate = self;
                        
                        [self showLoadingInView:self.view];
                        
                        break;
                    }
                    case 1:
                    {
                        My_EmployerCoupon_busine * my_coupon_busine =  [[My_EmployerCoupon_busine alloc]init];//请求优惠券列表(已使用)
                        [my_coupon_busine My_EmployerCouponReq_busine:@"2" currentPage:strRow];
                        my_coupon_busine.delegate = self;
                        
                        [self showLoadingInView:self.view];
                        
                        break;
                    }
                    case 2:
                    {
                        My_EmployerCoupon_busine * my_coupon_busine =  [[My_EmployerCoupon_busine alloc]init];//请求优惠券列表(已过期)
                        [my_coupon_busine My_EmployerCouponReq_busine:@"3" currentPage:strRow];
                        my_coupon_busine.delegate = self;
                        
                        [self showLoadingInView:self.view];
                        
                        break;
                    }
                    default:
                        break;
                }
            }
            
        }
        
    }
}
#pragma mark - 返回顶部
-(void)tableviewTop{
    
    [_tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    
}

#pragma mark -
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
