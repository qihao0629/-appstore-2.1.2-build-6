//
//  CreateMyReqVC.m
//  腾云家务
//
//  Created by 齐 浩 on 13-10-27.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "Ty_Pub_SelectCityVC.h"
#define BackGrundGray [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1]

@interface Ty_Pub_SelectCityVC ()

@end

@implementation Ty_Pub_SelectCityVC
@synthesize xuqiuInfo;
@synthesize arrContent;
@synthesize area;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        arrContent = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.titleString isEqualToString:@"选择区"]) {
        NSString* path = [[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil];
        NSMutableArray* array = [[NSMutableArray alloc]initWithContentsOfFile:path];
        for (int i = 0; i<[array count]; i++)
        {
            if ([[[array objectAtIndex:i] objectForKey:@"state"]isEqualToString:xuqiuInfo.province])
            {
                NSArray* arr = [[NSArray alloc]initWithArray:[[array objectAtIndex:i] objectForKey:@"cities"]];
                for (int j = 0; j< [arr count]; j++)
                {
                    if ([[[arr objectAtIndex:j] objectForKey:@"city"]isEqualToString:xuqiuInfo.city])
                    {
                        arrContent = [[arr objectAtIndex:j] objectForKey:@"areas"];
                    }
                }
            }
        }
    }
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(10, 10, 300, self.view.frame.size.height-49-74) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorColor = view_BackGroudColor;
    
    UIImageView* back = [[UIImageView alloc]initWithFrame:tableview.frame];
    [back setBackgroundColor:view_BackGroudColor];
    
    tableview.backgroundView = back;
    tableview.showsHorizontalScrollIndicator = NO;
    tableview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableview];
    
    

    
	// Do any additional setup after loading the view.
}
-(void)back
{
    if ([self.title isEqualToString:@"选择省"]) {
        xuqiuInfo.province = @"";
    }else if([self.title isEqualToString:@"选择市"]){
        xuqiuInfo.city = @"";
    }else if ([self.title isEqualToString:@"选择区"]){
        xuqiuInfo.area = @"";
    }else if ([self.title isEqualToString:@"选择区域"]){
        xuqiuInfo.region = @"";
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrContent count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not implemented
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* Cell = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Cell];
        [cell setBackgroundColor:[UIColor whiteColor]];
        [cell.textLabel setFont:FONT14_BOLDSYSTEM];
        [cell.detailTextLabel setFont:FONT14_BOLDSYSTEM];
    }
    if ([self.titleString isEqualToString:@"选择省"]) {
        cell.textLabel.text = [[arrContent objectAtIndex:indexPath.row] objectForKey:@"state"];
    }else if([self.titleString isEqualToString:@"选择市"]){
        cell.textLabel.text = [[arrContent objectAtIndex:indexPath.row] objectForKey:@"city"];
    }else if([self.titleString isEqualToString:@"选择区"]){
        cell.textLabel.text = [[arrContent objectAtIndex:indexPath.row] objectForKey:@"area"];
    }else{
        cell.textLabel.text = [arrContent objectAtIndex:indexPath.row];
    }
    return cell;
}

#pragma mark ----UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   if ([self.titleString isEqualToString:@"选择省"]){
       
        xuqiuInfo.province = [[arrContent objectAtIndex:indexPath.row] objectForKey:@"state"];
        Ty_Pub_SelectCityVC* create = [[Ty_Pub_SelectCityVC alloc]init];
        create.xuqiuInfo = xuqiuInfo;
        create.title = @"选择市";
        create.arrContent = [[arrContent objectAtIndex:indexPath.row] objectForKey:@"cities"];
        [self.naviGationController pushViewController:create animated:YES];

    }else if([self.titleString isEqualToString:@"选择市"]){
        
        xuqiuInfo.city = [[arrContent objectAtIndex:indexPath.row] objectForKey:@"city"];
        Ty_Pub_SelectCityVC* create = [[Ty_Pub_SelectCityVC alloc]init];
        create.xuqiuInfo = xuqiuInfo;
        create.title = @"选择区";
        create.arrContent = [[arrContent objectAtIndex:indexPath.row] objectForKey:@"areas"];
        [self.naviGationController pushViewController:create animated:YES];
    }else if([self.titleString isEqualToString:@"选择区"])
    {
        xuqiuInfo.area = [[arrContent objectAtIndex:indexPath.row] objectForKey:@"area"];
        
        [self.naviGationController popViewControllerAnimated:YES];
//        Ty_Pub_SelectCityVC* create = [[Ty_Pub_SelectCityVC alloc]init];
//        create.xuqiuInfo = xuqiuInfo;
//        create.area = [[arrContent objectAtIndex:indexPath.row] objectForKey:@"area"];
//        create.title = @"选择区域";
//        create.arrContent = [[arrContent objectAtIndex:indexPath.row] objectForKey:@"regions"];
//        [self.naviGationController pushViewController:create animated:YES];
        
    }else if ([self.titleString isEqualToString:@"选择区域"]){
        
        xuqiuInfo.area = area;
        xuqiuInfo.region = [arrContent objectAtIndex:indexPath.row];
//        for (int i = 0; i<[self.naviGationController.viewControllers  count]; i++)
//        {
//            NSString *strTemp = [NSString stringWithFormat:@"%@",[self.naviGationController.viewControllers objectAtIndex:i]];
//            NSRange foundObj = [strTemp rangeOfString:@"Ty_Pub_RequirementsVC" options:NSCaseInsensitiveSearch];
//            if (foundObj.length == 21)
//            {
//                [self.naviGationController popToViewController:[self.naviGationController.viewControllers objectAtIndex:i] animated:YES];
//            }
//            
//        }
        [self.naviGationController popToViewController:[self.naviGationController.viewControllers objectAtIndex:self.naviGationController.viewControllers.count-3]  animated:YES];
       
    }
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    switch (indexPath.row) {
//        case 0:
//            [cell setBackgroundView:[[UIImageView alloc] initWithImage:JWImageName(@"i_setupcellbgtop")]];
//            break;
        default:
            if (indexPath.row == arrContent.count-1) {
                [cell setBackgroundView:[[UIImageView alloc] initWithImage:JWImageName(@"i_setupcellbg")]];
            }else{
                [cell setBackgroundView:[[UIImageView alloc] initWithImage:JWImageName(@"i_setupcellbgtop")]];
            }
            break;
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    if (tableview) {
        [tableview reloadData];
    }
//    if (IOS7) {
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    }
    
}
- (void)viewWillDisappear:(BOOL)animated
{
//    if (IOS7) {
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];    
//    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
