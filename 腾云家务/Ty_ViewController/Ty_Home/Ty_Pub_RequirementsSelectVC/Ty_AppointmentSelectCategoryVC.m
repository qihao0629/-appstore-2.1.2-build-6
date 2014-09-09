//
//  Ty_AppointmentSelectCategoryVC.m
//  腾云家务
//
//  Created by 齐 浩 on 14-7-5.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_AppointmentSelectCategoryVC.h"

@interface Ty_AppointmentSelectCategoryVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableView_;
    UITableView* tableView2_;
}
@end

@implementation Ty_AppointmentSelectCategoryVC
@synthesize appointmentBusine;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        appointmentBusine = [[Ty_AppointmentSelectCategoryBusine alloc]init];
        appointmentBusine.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tableView_ = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-49-64) style:UITableViewStylePlain];
    [tableView_ setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:tableView_.frame];
    imageView.backgroundColor = [UIColor colorWithRed:212.0/255 green:212.0/255 blue:212.0/255 alpha:1.0];
    tableView_.separatorColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    //    tableView_.backgroundView = imageView;
    tableView_.delegate = self;
    tableView_.hidden = YES;
    tableView_.dataSource = self;
    
    [self.view addSubview:tableView_];
    
    tableView2_ = [[UITableView alloc]initWithFrame:CGRectMake(135, 0, 320, self.view.frame.size.height-49-64) style:UITableViewStylePlain];
    
    //    tableView2_.backgroundView = imageView;
    tableView2_.delegate = self;
    tableView2_.dataSource = self;
    tableView2_.hidden = YES;
    
    [self.view addSubview:tableView2_];
    
    [self showLoadingInView:self.view];
    [appointmentBusine sendCategory];

    // Do any additional setup after loading the view.
}
-(void)netRequestReceived:(NSNotification *)_notification
{
    [self hideLoadingView];
    if ([[[_notification object] objectForKey:@"code"] isEqualToString:@"200"]) {
        tableView2_.hidden = NO;
        tableView_.hidden = NO;
        [tableView_ reloadData];
        [tableView2_ reloadData];
        NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [tableView_ selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        [tableView2_ selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];

    }else if ([[[_notification object] objectForKey:@"code"] isEqualToString:@"203"]){
        [self showMessageInView:self.view message:@"没有相关的服务类型"];
    }else if ([[[_notification object] objectForKey:@"code"] isEqualToString:REQUESTFAIL]){
        [self showNetMessageInView:self.view];
    }
}
-(void)loading
{
    [appointmentBusine sendCategory];
}
#pragma mark ----tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == tableView_) {
        return [appointmentBusine.arrContent count];
    }else{
        return [appointmentBusine.arrContent2 count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView_ == tableView) {
        static NSString *str = @"cell1";
        UITableViewCell *cell = [tableView_ dequeueReusableCellWithIdentifier:str];
        if (cell  ==  nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            //            cell.backgroundColor = [UIColor whiteColor];
            cell.textLabel.font = FONT14_BOLDSYSTEM;
            cell.selectedTextColor = [UIColor blackColor];
            UIView* cellview = [[UIView alloc]initWithFrame:cell.frame];
            [cellview setBackgroundColor:[UIColor whiteColor]];
            cell.selectedBackgroundView = cellview;
            
        }
        
        cell.textLabel.text = [[appointmentBusine.arrContent objectAtIndex:indexPath.row] workName];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }else{
        static NSString *str2 = @"cell2";
        UITableViewCell *cell = [tableView2_ dequeueReusableCellWithIdentifier:str2];
        
        if (cell  ==  nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str2];
            cell.backgroundColor = [UIColor whiteColor];
            cell.textLabel.font = FONT12_SYSTEM;
            cell.textLabel.textColor = [UIColor grayColor];
            cell.selectedTextColor = [UIColor orangeColor];
            UIImageView* cellview = [[UIImageView alloc]initWithFrame:cell.frame];
            [cellview setImage:JWImageName(@"selectCellbackground@2x")];
            cell.selectedBackgroundView = cellview;
        }
        cell.textLabel.text = [[appointmentBusine.arrContent2 objectAtIndex:indexPath.row] objectForKey:@"workName"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView_ == tableView) {
        cell.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tableView_) {
        appointmentBusine.arrContent2 = [[appointmentBusine.workPlist objectAtIndex:indexPath.row]objectForKey:@"ChildrenWork"];
        NSIndexPath* _indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [tableView2_ reloadData];
        [tableView2_ selectRowAtIndexPath:_indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
//        if ([appointmentBusine.arrContent2 count]>0) {
//            appointmentBusine.xuqiuInfo.workName = [[appointmentBusine.arrContent2 objectAtIndex:0]objectForKey:@"workName"];
//            appointmentBusine.xuqiuInfo.workGuid = [[appointmentBusine.arrContent2 objectAtIndex:0] objectForKey:@"workGuid"];
//        }
    }
    if (tableView == tableView2_) {
        if ([appointmentBusine.arrContent2 count]>0) {
            if (appointmentBusine.home_user_detailType != Ty_Home_UserDetailTypeCoupon && ![appointmentBusine.xuqiuInfo.workName isEqualToString:[[appointmentBusine.arrContent2 objectAtIndex:indexPath.row]objectForKey:@"workName"]]) {
                appointmentBusine.xuqiuInfo.usedCouponInfo.couponGuid = @"";
                appointmentBusine.xuqiuInfo.usedCouponInfo.couponTitle = @"";
                appointmentBusine.xuqiuInfo.usedCouponInfo.couponCutPrice =@"";
            }
            appointmentBusine.xuqiuInfo.workName = [[appointmentBusine.arrContent2 objectAtIndex:indexPath.row]objectForKey:@"workName"];
            appointmentBusine.xuqiuInfo.workGuid = [[appointmentBusine.arrContent2 objectAtIndex:indexPath.row] objectForKey:@"workGuid"];
            appointmentBusine.xuqiuInfo.priceUnit = [[appointmentBusine.arrContent2 objectAtIndex:indexPath.row] objectForKey:@"postSalary"];
            [self.naviGationController popViewControllerAnimated:YES];
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark ---- Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
