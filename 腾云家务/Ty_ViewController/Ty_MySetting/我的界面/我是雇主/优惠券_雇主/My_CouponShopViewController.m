//
//  My_CouponShopViewController.m
//  腾云家务
//
//  Created by 艾飞 on 14/6/26.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_CouponShopViewController.h"
#import "My_EmployerCoupon_busine.h"
#import "My_CouponDetaileShopCell.h"
#import "Ty_Home_UserDetailVC.h"//商户详细信息
@interface My_CouponShopViewController ()

@end

@implementation My_CouponShopViewController
@synthesize couponGuid;
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
    
    my_ShopModel = [[My_CouponDetailedModel alloc]init];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT - 20 - 44 - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = NO;
    _tableView.hidden = YES;
    [self.view addSubview:_tableView];

    [self addNotificationForName:@"MyCouponShopListReq"];
    My_EmployerCoupon_busine * my_couponBusine = [[My_EmployerCoupon_busine alloc]init];
    [my_couponBusine My_CouponShopReq_busineCouponGuid:couponGuid currentPage:@"1"];
    my_couponBusine.delegate = self;
    [self showLoadingInView:self.view];
//    my_couponBusine.my_couponModel_req = my_ShopModel;
    
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

#pragma mark - 修改_回调
-(void)netRequestReceived:(NSNotification *)_notification{
    [self hideLoadingView];
    if ([[_notification object] isKindOfClass:[NSString class]] && [[_notification object] isEqualToString:@"fail"]) {
        
        [self alertViewTitle:@"提示" message:@"网络连接暂时不可用，请稍后再试"];
        
    }else {
        
        if ([[[_notification object] objectForKey:@"code"]intValue] == 200) {
            
            
            _tableView.hidden = NO;

            [my_ShopModel.array_CouponShop addObjectsFromArray:[[_notification object] objectForKey:@"rows"]];

            
            if ([my_ShopModel.array_CouponShop count] == 10) {
                
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
            
            [_tableView reloadData];
            
        }else if ([[[_notification object] objectForKey:@"code"]intValue] == 203){
            
            [self hideMessageView];
            
            //没有数据处理
            isSingend = YES;
            _refreshView._messageLabel.text = @"已加载全部";
            _isRefreshing = NO;
            [self loadTableViewFootView];
            [_tableView reloadData];
            [_refreshView._netMind stopAnimating];
            
        }else{
            
            if (reqint == 1) {
                [self showNetMessageInView:self.view];
                
            }else{
                
                
                [self alertViewTitle:@"提示" message:[[_notification object] objectForKey:@"msg"]];
                
                _isRefreshing = NO;
                [_refreshView._netMind stopAnimating];
                
            }
        }
        
    }
    
}



#pragma mark - UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return my_ShopModel.array_CouponShop.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * CouponCellID = @"couponShopCell";
    My_CouponDetaileShopCell * cell = [tableView dequeueReusableCellWithIdentifier:CouponCellID];
    if (cell == nil) {
        cell = [[My_CouponDetaileShopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CouponCellID];
    }
    
    [cell.typeLabel setText:@"商户"];
    
    [cell.headImage setImageWithURL:[NSURL URLWithString:[[my_ShopModel.array_CouponShop objectAtIndex:indexPath.row  ] objectForKey:@"intermediaryPhoto"]]placeholderImage:JWImageName(@"Contact_image2")];
    cell.shopNameLabel.text = [[my_ShopModel.array_CouponShop objectAtIndex:indexPath.row ] objectForKey:@"detailIntermediaryName"];
    cell.areaLabel.text = [[my_ShopModel.array_CouponShop objectAtIndex:indexPath.row ] objectForKey:@"serveAddress"];
    [cell.customStar setCustomStarNumber:[[[my_ShopModel.array_CouponShop  objectAtIndex:indexPath.row ] objectForKey:@"userEvaluateEmployee"] floatValue]];
    
    [cell setLoadView];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Ty_Home_UserDetailVC * ty_home_user = [[Ty_Home_UserDetailVC alloc] init];
    [ty_home_user Home_UserDetail:Ty_Home_UserDetailTypeDefault];
    ty_home_user.userDetailBusine.userService.userGuid = [[my_ShopModel.array_CouponShop  objectAtIndex:indexPath.row  ] objectForKey:@"detailUserGuid"];
    [self.naviGationController pushViewController:ty_home_user animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.bounds.size.height)  && _refreshView != nil)
    {
        NSLog(@"lgs -- 我是上拉刷新");
       
        
        if (isSingend == NO) {
            
            if (!_refreshView._netMind.isAnimating && !_isRefreshing)
            {
                _refreshView._messageLabel.text = @"正在加载...";
                reqint = reqint + 1;
                NSString * strRow = [NSString stringWithFormat:@"%d",reqint ];

                My_EmployerCoupon_busine * my_couponBusine = [[My_EmployerCoupon_busine alloc]init];
                [my_couponBusine My_CouponShopReq_busineCouponGuid:couponGuid currentPage:strRow];
                my_couponBusine.delegate = self;
                [self showLoadingInView:self.view];
            }
            
        }
        
    }
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
