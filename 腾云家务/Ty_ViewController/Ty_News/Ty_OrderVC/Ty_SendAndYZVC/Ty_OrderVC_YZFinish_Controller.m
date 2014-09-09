//
//  Ty_OrderVC_YZFinish_Controller.m
//  腾云家务
//
//  Created by lgs on 14-7-5.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_OrderVC_YZFinish_Controller.h"
#import "Ty_OrderVC_Worker_ReceivedPush.h"
#import "AppDelegate.h"

@interface Ty_OrderVC_YZFinish_Controller ()

@end

@implementation Ty_OrderVC_YZFinish_Controller
@synthesize finishImage,finishLabel,AciontButton,contentsLabel,requirementGuid;
@synthesize xuQiu;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadUI];
    self.title = @"应征成功";
    
	// Do any additional setup after loading the view.
}
-(void)loadUI
{
    finishLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, 320, 15)];
    [finishLabel setBackgroundColor:[UIColor clearColor]];
    [finishLabel setTextColor:Color_orange];
    [finishLabel setTextAlignment:NSTextAlignmentCenter];
    [finishLabel setFont:FONT15_BOLDSYSTEM];
    
    finishImage=[[UIImageView alloc]initWithFrame:CGRectMake(125, 75, 70, 70)];
    
    
    contentsLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 155, 320, 14)];
    [contentsLabel setBackgroundColor:[UIColor clearColor]];
    [contentsLabel setTextColor:Color_173];
    [contentsLabel setTextAlignment:NSTextAlignmentCenter];
    [contentsLabel setFont:FONT13_BOLDSYSTEM];
    
    AciontButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [AciontButton setFrame:CGRectMake(50, 200, 220, 40)];
    [AciontButton setBackgroundImage:JWImageName(@"login") forState:UIControlStateNormal];
    [AciontButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [AciontButton addTarget:self action:@selector(goToRequirement) forControlEvents:UIControlEventTouchUpInside];
    [AciontButton.titleLabel setFont:FONT14_BOLDSYSTEM];
    
    [finishLabel setText:@"您的应征抢单已生效！"];
    [contentsLabel setText:@"雇主正在选择合适的服务商，请稍后..."];
    [finishImage setImage:JWImageName(@"pub_qiangdanimage")];
    [AciontButton setTitle:@"查看本次抢单详细" forState:UIControlStateNormal];

    [self.view addSubview:finishLabel];
    [self.view addSubview:finishImage];
    [self.view addSubview:contentsLabel];
    [self.view addSubview:AciontButton];

}
-(void)goToRequirement
{
    Ty_OrderVC_Worker_ReceivedPush * systemP = [[Ty_OrderVC_Worker_ReceivedPush alloc]init];
    
    systemP.requirementGuid = requirementGuid;

    TYBaseView* viewController=[[appDelegate appTabBarController] appNavigation];
    NSRange range;
    range.length=self.naviGationController.viewControllers.count-1;
    range.location=1;
    NSArray* array=[self.naviGationController.viewControllers subarrayWithRange:range];
    [self removeViewControllersFromWindow:array];
    
    [viewController.naviGationController pushViewController:systemP animated:NO];
}
-(void)backClick
{
    [self.naviGationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
