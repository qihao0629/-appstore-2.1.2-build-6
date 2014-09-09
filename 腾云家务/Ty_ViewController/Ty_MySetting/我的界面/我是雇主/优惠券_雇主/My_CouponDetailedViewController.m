//
//  My_CouponDetailedViewController.m
//  腾云家务
//
//  Created by 艾飞 on 14/6/18.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_CouponDetailedViewController.h"
#import "My_EmployerCoupon_busine.h"
#import "My_CouponDetailedCell.h"
#import "My_CouponDetaileShopCell.h"
#import "My_CouponShopViewController.h"
#import "Ty_Home_UserDetailVC.h"//商户详细信息
@interface My_CouponDetailedViewController ()

@end

@implementation My_CouponDetailedViewController
@synthesize my_coupon_model = _my_coupon_model;
@synthesize coupon_type = _coupon_type;
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
    _my_coupon_model = [[My_CouponDetailedModel alloc]init];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT - 20 - 44 - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = NO;
    _tableView.hidden = YES;
    [self.view addSubview:_tableView];
    
    My_EmployerCoupon_busine * my_coupon_busine =  [[My_EmployerCoupon_busine alloc]init];
    [my_coupon_busine My_CouponDetailedReq_busineCouponGuid:_couponGuid couponNo:_couponNo ucState:_ucState];
    my_coupon_busine.my_couponModel_req = _my_coupon_model;
    my_coupon_busine.delegate = self;
    [self showLoadingInView:self.view];

    [self addNotificationForName:@"MyCouponDetaileReq"];
}
#pragma mark - 重新加载
-(void)loading{
    
    My_EmployerCoupon_busine * my_coupon_busine =  [[My_EmployerCoupon_busine alloc]init];
    [my_coupon_busine My_CouponDetailedReq_busineCouponGuid:_couponGuid couponNo:_couponNo ucState:_ucState];
    my_coupon_busine.my_couponModel_req = _my_coupon_model;
    my_coupon_busine.delegate = self;

    [self showLoadingInView:self.view];
    
}

#pragma mark - 优惠券列表——网络回调.
-(void)netRequestReceived:(NSNotification *)_notification{
    
    [self hideLoadingView];
    if ([[_notification object] isKindOfClass:[NSString class]] && [[_notification object] isEqualToString:@"fail"]) {
        
        [self showNetMessageInView:self.view];
        
    }else {
        
        if ([[[_notification object]objectForKey:@"code"]intValue] == 200) {
        
            _tableView.hidden = NO;
            [_tableView reloadData];
            self.title = _my_coupon_model.couponTitle;
            
        }else {
            
            [self alertViewTitle:@"提示" message:[[_notification object] objectForKey:@"msg"]];
            
        }
        
    }
    
}


#pragma mark - UITableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 1) {
        if ([_my_coupon_model.couponSuitCompanyType isEqualToString:@"1"]) {
            
            return 1;
            
        }else{
            
            return  _my_coupon_model.suitCompany.count + 1;
            
        }
    }
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section == 0 || (indexPath.section == 1 && indexPath.row == 0) ) {
        
        NSString * strCellID = @"CouponCell";
        My_CouponDetailedCell * cell = [tableView dequeueReusableCellWithIdentifier:strCellID];
        if (cell == nil) {
            cell = [[My_CouponDetailedCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCellID];
        }
      
      
        switch (indexPath.section) {
            case 0:
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell My_CouponDetailaCellLabelHiddenNO];
                
                cell.labelTitle.text = _my_coupon_model.couponTitle;
                cell.labelCouponNo.text = @"序列号:";
                cell.labelCouponNoText.text = _my_coupon_model.couponNo;
                cell.labelMoey.text = [NSString stringWithFormat:@"%@元",_my_coupon_model.couponCutPrice];
                if ([_coupon_type isEqualToString:@"1"]) {
                    cell.labelUcEndTime.text = [NSString stringWithFormat:@"有效期: %@",_my_coupon_model.ucEndTime];

                }else{
                
                    cell.labelUcEndTime.text = [NSString stringWithFormat:@"使用日期: %@",_my_coupon_model.ucUseTime];

                }
            
                if ([_my_coupon_model.couponSuitWorkType isEqualToString:@"1"]) {
                    
                    cell.labelSuitWork.text = @"适用工种: 适用于所有工种";

                }else{
                    
                    cell.labelSuitWork.text = @"适用工种:";
                    cell.labelSuitWorkText.text = _my_coupon_model.suitWork;
                    cell.labelSuitWorkText.frame = CGRectMake(75 , 82, 225 , [self heightForString:_my_coupon_model.suitWork fontSize:14.0f andWidth:225]);

                }

                break;
                
            case 1:
                if (indexPath.row == 0) {
                    
                    
                    if ([self.coupon_type isEqualToString:@"2"]) {
                        
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        
                    }else{
                    
                        cell.selectionStyle = UITableViewCellSelectionStyleGray;

                    }
                    
                    if ([_my_coupon_model.couponSuitCompanyType isEqualToString:@"1"]) {
                        
                        cell.labelShop.text = @"适用店铺: 适用于所有店铺";
                        cell.labelShop.frame = CGRectMake(10, 5, 200, 20);
                        cell.labelShopTitle.text = @"";
                        
                    }else{
                        
                        cell.labelShop.text = @"使用店铺";
                        
                        if ([self.coupon_type isEqualToString:@"1"]) {
                            
                            cell.labelShopTitle.text = @"查看全部";
                            
                        }else{
                            
                            cell.labelShopTitle.text = @"";
                            
                        }
                        
                    }
                    [cell My_CouponDetailaCellLabelHiddenYes];
                    
                }

                break;
      
            default:
                break;
        }
        
        return cell;

    }else if(indexPath.section == 1 && !indexPath.row == 0 ){
    
        NSString * strCellID = @"CouponShopCell";
        My_CouponDetaileShopCell * cell = [tableView dequeueReusableCellWithIdentifier:strCellID];
        if (cell == nil) {
            
            cell = [[My_CouponDetaileShopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCellID];
        }
        
        
        if ([self.coupon_type isEqualToString:@"2"]) {
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        [cell.typeLabel setText:@"商户"];
            
        [cell.headImage setImageWithURL:[NSURL URLWithString:[[_my_coupon_model.suitCompany objectAtIndex:indexPath.row -1 ] objectForKey:@"intermediaryPhoto"]]placeholderImage:JWImageName(@"Contact_image2")];
        cell.shopNameLabel.text = [[_my_coupon_model.suitCompany objectAtIndex:indexPath.row -1 ] objectForKey:@"detailIntermediaryName"];
        cell.areaLabel.text = [[_my_coupon_model.suitCompany objectAtIndex:indexPath.row -1] objectForKey:@"serveAddress"];
        [cell.customStar setCustomStarNumber:[[[_my_coupon_model.suitCompany  objectAtIndex:indexPath.row -1 ] objectForKey:@"userEvaluateEmployee"] floatValue]];
        
    
        [cell setLoadView];

        return cell;

    }else{
    
        NSString * strCellID = @"CouponTextCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:strCellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCellID];
            
            labelTextDetail = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 300, 40)];
  
        }
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.layer.borderWidth = 0.3;
        cell.layer.borderColor = [[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0f]CGColor];
        
        labelTextDetail.font = [UIFont systemFontOfSize:14.0f];
//        labelTextDetail.textColor = [UIColor colorWithRed:161.0/255.0 green:161.0/255.0 blue:161.0/255.0 alpha:1.0f];
        [labelTextDetail setTextAlignment:NSTextAlignmentLeft];
        labelTextDetail.text = [NSString stringWithFormat:@"使用说明:%@",_my_coupon_model.couponDetail];
        labelTextDetail.numberOfLines = 0;
        [cell.contentView addSubview:labelTextDetail];
        [labelTextDetail setFrame:CGRectMake(10, 5, 300, [self heightForString:[NSString stringWithFormat:@"使用说明:%@",_my_coupon_model.couponDetail] fontSize:14.0f andWidth:300] + 20)];
        
        return cell;
        
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            
            return 110 + [self heightForString:_my_coupon_model.suitWork fontSize:14.0f andWidth:240] - 20;
            
            break;
        case 1:
            if (indexPath.row == 0 ) {
                
                return 30;
                
            }else{
            
                return 80;
            }
            
            break;
        case 2:
        {
        
            return [self heightForString:[NSString stringWithFormat:@"使用说明:%@",_my_coupon_model.couponDetail] fontSize:14.0f andWidth:300] + 20;
            
            break;
        }
        default:
            break;
    }
    return 44;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
        
    }
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 10;
        
    }
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        
    }
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1 && indexPath.row == 0) {
        if (![_my_coupon_model.couponSuitCompanyType isEqualToString:@"1"]) {
            if ([self.coupon_type isEqualToString:@"1"]) {
                My_CouponShopViewController * my_couponShop = [[My_CouponShopViewController alloc]init];
                my_couponShop.title = @"适用商户";
                my_couponShop.couponGuid = _couponGuid;
                [self.naviGationController pushViewController:my_couponShop animated:YES];
            }

        }
    }
    if (indexPath.section == 1 && indexPath.row != 0 ) {
        if ([self.coupon_type isEqualToString:@"1"]) {
            Ty_Home_UserDetailVC * ty_home_user = [[Ty_Home_UserDetailVC alloc] init];
            [ty_home_user Home_UserDetail:Ty_Home_UserDetailTypeCoupon];
            ty_home_user.userDetailBusine.userService.userGuid = [[_my_coupon_model.suitCompany  objectAtIndex:indexPath.row -1 ] objectForKey:@"detailUserGuid"];
            ty_home_user.userDetailBusine.coupon = [_my_coupon_model copy];
            [self.naviGationController pushViewController:ty_home_user animated:YES];
        }

    }
}

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 字符串高度
- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
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
