//
//  My_AddEmployeeSkillVC.m
//  腾云家务
//
//  Created by 艾飞 on 14/7/11.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_AddEmployeeSkillVC.h"
#import "Ty_Model_WorkListInfo.h"
@interface My_AddEmployeeSkillVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableView_;
    UITableView* tableView2_;
    NSArray* workPlist;
    NSMutableArray *arrContent;
    NSMutableArray *arrContent2;
}
@end

@implementation My_AddEmployeeSkillVC
@synthesize  xuqiuInfo;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        arrContent=[[NSMutableArray alloc]init];
        arrContent2=[[NSMutableArray alloc]init];
    
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
    tableView_.separatorColor=[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    //    tableView_.backgroundView = imageView;
    tableView_.delegate = self;
    tableView_.dataSource = self;
    
    [self.view addSubview:tableView_];
    
    tableView2_ = [[UITableView alloc]initWithFrame:CGRectMake(135, 0, 320, self.view.frame.size.height-49-64) style:UITableViewStylePlain];
    
    //    tableView2_.backgroundView = imageView;
    tableView2_.delegate = self;
    tableView2_.dataSource = self;
    
    
    [self.view addSubview:tableView2_];
    
    workPlist=[[NSArray alloc]initWithContentsOfFile:AddWorkTypefileForPath];
    
    if ([workPlist count]>0) {
        for (int i=0 ; i<[workPlist count]; i++) {
            Ty_Model_WorkListInfo* workType=[[Ty_Model_WorkListInfo alloc]init];
            workType.workGuid=[[workPlist objectAtIndex:i] objectForKey:@"workGuid"];
            workType.workName=[[workPlist objectAtIndex:i] objectForKey:@"workName"];
            [arrContent addObject:workType];
        }
        arrContent2=[[workPlist objectAtIndex:0]objectForKey:@"ChildrenWrok"];
        [tableView_ reloadData];
        [tableView2_ reloadData];
        NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [tableView_ selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        [tableView2_ selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];
   
    }
    
    // Do any additional setup after loading the view.
}
#pragma mark tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==tableView_) {
        return [arrContent count];
    }else{
        return [arrContent2 count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView_==tableView) {
        static NSString *str = @"cell1";
        UITableViewCell *cell = [tableView_ dequeueReusableCellWithIdentifier:str];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            //            cell.backgroundColor = [UIColor whiteColor];
            cell.textLabel.font = FONT14_BOLDSYSTEM;
            cell.selectedTextColor=[UIColor blackColor];
            UIView* cellview=[[UIView alloc]initWithFrame:cell.frame];
            [cellview setBackgroundColor:[UIColor whiteColor]];
            cell.selectedBackgroundView=cellview;
            
        }
        
        cell.textLabel.text = [[arrContent objectAtIndex:indexPath.row] workName];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }else{
        static NSString *str2 = @"cell2";
        UITableViewCell *cell = [tableView2_ dequeueReusableCellWithIdentifier:str2];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str2];
            cell.backgroundColor = [UIColor whiteColor];
            cell.textLabel.font = FONT12_SYSTEM;
            cell.textLabel.textColor=[UIColor grayColor];
            cell.selectedTextColor=[UIColor orangeColor];
            UIImageView* cellview=[[UIImageView alloc]initWithFrame:cell.frame];
            [cellview setImage:JWImageName(@"selectCellbackground@2x")];
            cell.selectedBackgroundView=cellview;
        }
        cell.textLabel.text = [[arrContent2 objectAtIndex:indexPath.row] objectForKey:@"workName"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView_==tableView) {
        cell.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==tableView_) {
        arrContent2=[[workPlist objectAtIndex:indexPath.row]objectForKey:@"ChildrenWrok"];
        NSIndexPath* _indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
        [tableView2_ reloadData];
        [tableView2_ selectRowAtIndexPath:_indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        if ([arrContent2 count]>0) {
            
//            self.xuqiuInfo.workName = [[arrContent2 objectAtIndex:0]objectForKey:@"workName"];
            
        }
    }
    if (tableView==tableView2_) {
        if ([arrContent2 count]>0) {
            
//            self.xuqiuInfo.workName = [[arrContent2 objectAtIndex:indexPath.row]objectForKey:@"workName"];
//            self.xuqiuInfo.workGuid = [[arrContent2 objectAtIndex:indexPath.row] objectForKey:@"workGuid"];
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
