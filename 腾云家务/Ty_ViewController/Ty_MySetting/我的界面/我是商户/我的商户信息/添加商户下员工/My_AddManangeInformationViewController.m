//
//  My_AddManangeInformationViewController.m
//  腾云家务
//
//  Created by 艾飞 on 14/7/10.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_AddManangeInformationViewController.h"
#import "AddSkillCell.h"
#import "My_AddEmployeeSkillVC.h"
@interface My_AddManangeInformationViewController ()

@end

@implementation My_AddManangeInformationViewController
@synthesize my_AddemployeeModel;
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

    //初始化导航右侧按钮
    [self.naviGationController.rightBarButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.naviGationController.rightBarButton.titleLabel setFont:FONT15_BOLDSYSTEM];
    [self.naviGationController.rightBarButton setExclusiveTouch:YES];
    [self.naviGationController.rightBarButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self setSlidingBack:NO];//关闭滑动返回
    
    [self employeeTitleInformation];//信息view
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, viewEmployee.frame.size.height + 20, SCREEN_WIDTH,SCREEN_HEIGHT - 20- 44- 49 - viewEmployee.frame.size.height - 20)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    _tableView.separatorStyle = NO;
    //    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    _tableView.backgroundView = nil;
    [self.view addSubview:_tableView];
    
    array_skill = [[NSMutableArray alloc]init];
    
}


#pragma mark - 重写 返回按钮事件
-(void)backClick{

    [self.naviGationController popToViewController:[self.naviGationController.viewControllers objectAtIndex:1] animated:YES];
    
}

#pragma mark - UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [array_skill count] + 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * strID = @"myCell";
    AddSkillCell * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (cell == nil) {
        cell = [[AddSkillCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strID];
        
    }
    
    cell.selectionStyle =  UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == [array_skill count] ) {
        //最后一行
        cell.textLabel.text = @"+增加服务";
        cell.textLabel.textColor = [UIColor colorWithRed:3.0/255.0 green:70.0/255.0 blue:141.0/255.0 alpha:1.0];
        cell.detailTextLabel.text = @"";
        cell.lableMoney.hidden = YES;
        
        
    }else{
        
        cell.textLabel.text = [[array_skill objectAtIndex:indexPath.row] objectForKey:@"workName"];
        NSString * strText = [[[array_skill objectAtIndex:indexPath.row] objectForKey:@"T"] objectForKey:@"k.k_specialty"];
        if (!ISNULLSTR(strText)) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"个人特长(标签):%@",[[[array_skill objectAtIndex:indexPath.row] objectForKey:@"T"] objectForKey:@"k.k_specialty"]];
            
        }else{
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"个人特长(标签):"];
            
        }
        
        NSString * strPostSalary = [NSString stringWithFormat:@"%@",[[array_skill objectAtIndex:indexPath.row] objectForKey:@"postSalary"]];
        
//        if (!ISNULLSTR(strPostSalary)) {
//            cell.lableMoney.text = [NSString stringWithFormat:@"%@元/%@",[[array_skill objectAtIndex:indexPath.row] objectForKey:@"postSalary"],[dic_price objectForKey:[[array_skill objectAtIndex:indexPath.row] objectForKey:@"workName"]]];
//        }
//        
        cell.lableMoney.hidden = NO;
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == [array_skill count]) {
        //        [self alertViewTitle:@"提示" message:@"修改稍后开放！" cancel:@"确定" other:nil];
       
        My_AddEmployeeSkillVC * my_addSkill = [[My_AddEmployeeSkillVC alloc]init];
        [self.naviGationController pushViewController:my_addSkill animated:YES];
        
    }else{
       
    
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"所有服务";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 35;
}

#pragma mark - 雇工信息
-(void)employeeTitleInformation{

    viewEmployee = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 130)];
    viewEmployee.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewEmployee];

    
    UIImageView * imageHead = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    if (my_AddemployeeModel.userPhoto) {
        
        if ([my_AddemployeeModel.userSex isEqualToString:0]) {
            imageHead.image = JWImageName(@"Contact_image1");

        }else{
            
            imageHead.image = JWImageName(@"Contact_image");
            
        }

    }else{
        
        imageHead.image = my_AddemployeeModel.userPhoto;
    }
    [viewEmployee addSubview:imageHead];
    
    
    for (int i = 0; i < 10 ; i++) {
        UILabel * labelName = [[UILabel alloc]initWithFrame:CGRectMake(80, i * 20 + 10, 230, 20)];
        labelName.tag = 2300 + i;
        labelName.backgroundColor = [UIColor clearColor];
        labelName.font = [UIFont systemFontOfSize:15.0f];
        labelName.textAlignment = NSTextAlignmentLeft;
        [viewEmployee addSubview:labelName];
        
    }
    
    UILabel * labelNameTag = (UILabel *)[self.view viewWithTag:2300];
    if (ISNULL(my_AddemployeeModel.userRealName)) {
        labelNameTag.text = @"姓名";
    }else{
        labelNameTag.text = [NSString stringWithFormat:@"姓名：%@",my_AddemployeeModel.userRealName];
    }
    
    UILabel * labelNameTag_1 = (UILabel *)[self.view viewWithTag:2301];
    if (ISNULL(my_AddemployeeModel.detailPhone)) {
        labelNameTag_1.text = @"手机";
    }else{
        labelNameTag_1.text = [NSString stringWithFormat:@"手机：%@",my_AddemployeeModel.detailPhone];
    }
    
    UILabel * labelNameTag_2 = (UILabel *)[self.view viewWithTag:2302];
    if (ISNULL(my_AddemployeeModel.userBirthday)) {
        labelNameTag_2.text = @"生日：";
    }else{
        labelNameTag_2.text = [NSString stringWithFormat:@"生日：%@",my_AddemployeeModel.userBirthday];
    }
    
    UILabel * labelNameTag_3 = (UILabel *)[self.view viewWithTag:2303];
    if (ISNULL(my_AddemployeeModel.detailIdcard)) {
        labelNameTag_3.text = @"身份证：";
    }else{
        labelNameTag_3.text = [NSString stringWithFormat:@"身份证：%@",my_AddemployeeModel.detailIdcard];
    }
    
    UILabel * labelNameTag_4 = (UILabel *)[self.view viewWithTag:2304];
    labelNameTag_4.text = @"身份证照：";
    
    UILabel * labelNameTag_5 = (UILabel *)[self.view viewWithTag:2305];
    if (ISNULL(my_AddemployeeModel.detailRecord)) {
        labelNameTag_5.text = @"学历：";
    }else{
        labelNameTag_5.text = [NSString stringWithFormat:@"学历：%@",my_AddemployeeModel.detailRecord];
    }
    [self labelHiddenYes];
    
    UIButton * xiangxiButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [xiangxiButton setFrame:CGRectMake(250, 100, 50, 25)];
    [xiangxiButton setTitle:@"<更多>" forState:UIControlStateNormal];
    [xiangxiButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [xiangxiButton.titleLabel setFont:FONT14_BOLDSYSTEM];
    xiangxiButton.selected = NO;
    [xiangxiButton addTarget:self action:@selector(xiangxi:) forControlEvents:UIControlEventTouchUpInside];
    [viewEmployee addSubview:xiangxiButton];
    
}

#pragma mark - 更多

-(void)xiangxi:(UIButton *)but{
    if (but.selected) {
        
        [but setTitle:@"<更多>" forState:UIControlStateNormal];
        viewEmployee.frame = CGRectMake(0, 20,SCREEN_WIDTH, 140);
        [self labelHiddenYes];
        but.selected = NO;
        [but setFrame:CGRectMake(250, 100, 50, 25)];
        _tableView.frame = CGRectMake(0, viewEmployee.frame.size.height + 20, SCREEN_WIDTH,SCREEN_HEIGHT - 20- 44- 49 - viewEmployee.frame.size.height - 20);

    }else{
        
        [but setTitle:@"<收起>" forState:UIControlStateNormal];
        viewEmployee.frame = CGRectMake(0, 20,SCREEN_WIDTH, 220);
        [self labelHiddenNo];
        but.selected = YES;
        [but setFrame:CGRectMake(250, 185, 50, 25)];
        _tableView.frame = CGRectMake(0, viewEmployee.frame.size.height + 20, SCREEN_WIDTH,SCREEN_HEIGHT - 20- 44- 49 - viewEmployee.frame.size.height - 20);
    }
}

#pragma mark - 显示
-(void)labelHiddenNo{
    
    UILabel * labelNameTag_6 = (UILabel *)[self.view viewWithTag:2306];
    
    labelNameTag_6.hidden = NO;
    
    if (ISNULL(my_AddemployeeModel.detailIntermediaryUserNumber)) {
        
        labelNameTag_6.text = @"编号：";
        
    }else{
        
        labelNameTag_6.text = [NSString stringWithFormat:@"编号：%@",my_AddemployeeModel.detailIntermediaryUserNumber];
    }
    
    UILabel * labelNameTag_7 = (UILabel *)[self.view viewWithTag:2307];
    
    labelNameTag_7.hidden = NO;

    if (ISNULL(my_AddemployeeModel.userSex)) {
        
        labelNameTag_7.text = @"性别：";
        
    }else{
        if ([my_AddemployeeModel.userSex isEqualToString:0]) {
            
            labelNameTag_7.text = @"性别：男";
            
        }else{
            
            labelNameTag_7.text = @"性别：女";
            
        }
    }
    
    UILabel * labelNameTag_8 = (UILabel *)[self.view viewWithTag:2308];
    labelNameTag_8.hidden = NO;
    if (ISNULL(my_AddemployeeModel.detailCensus)) {
        labelNameTag_8.text = @"籍贯：";
    }else{
        labelNameTag_8.text = [NSString stringWithFormat:@"籍贯：%@",my_AddemployeeModel.detailCensus];
    }
    
    UILabel * labelNameTag_9 = (UILabel *)[self.view viewWithTag:2309];
    labelNameTag_9.hidden = NO;
    if (ISNULL(my_AddemployeeModel.userAddressDetail)) {
        labelNameTag_9.text = @"地址：";
    }else{
        labelNameTag_9.text = [NSString stringWithFormat:@"地址：%@",my_AddemployeeModel.userAddressDetail];
    }

}

#pragma mark - 隐藏
-(void)labelHiddenYes{
    
    UILabel * labelNameTag_6 = (UILabel *)[self.view viewWithTag:2306];
    labelNameTag_6.hidden = YES;

    UILabel * labelNameTag_7 = (UILabel *)[self.view viewWithTag:2307];
    labelNameTag_7.hidden = YES;

    UILabel * labelNameTag_8 = (UILabel *)[self.view viewWithTag:2308];
    labelNameTag_8.hidden = YES;

    UILabel * labelNameTag_9 = (UILabel *)[self.view viewWithTag:2309];
    labelNameTag_9.hidden = YES;

}

#pragma marik - 编辑
-(void)rightButtonAction{


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
