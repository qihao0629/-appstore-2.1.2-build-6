//
//  UserAddressDetailViewController.m
//  腾云家务
//
//  Created by 艾飞 on 13-11-13.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "UserAddressDetailViewController.h"
#import "UserRegionsViewController.h"
@interface UserAddressDetailViewController ()

@end

@implementation UserAddressDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"地区";

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainBounds.size.width, MainBounds.size.height-49-20-44) style:UITableViewStyleGrouped];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    [self.view addSubview:_tableView];
    
}

#pragma mark ---- UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_array_area count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * strCell = @"AddressCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:strCell];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0f];

    cell.textLabel.text = [[_array_area objectAtIndex:indexPath.row] objectForKey:@"area"];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    UserRegionsViewController * userRegions = [[UserRegionsViewController alloc]init];
    userRegions.array_city = [[_array_area objectAtIndex:indexPath.row] objectForKey:@"regions"];
    userRegions.str_city = [NSString stringWithFormat:@"%@  %@",_str_area,[[_array_area objectAtIndex:indexPath.row] objectForKey:@"area"]];
    [self.naviGationController pushViewController:userRegions animated:YES];

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
