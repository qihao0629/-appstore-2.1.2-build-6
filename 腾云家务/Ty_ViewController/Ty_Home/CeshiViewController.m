//
//  CeshiViewController.m
//  腾云家务
//
//  Created by 齐 浩 on 14-5-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "CeshiViewController.h"

@interface CeshiViewController ()

@end

@implementation CeshiViewController

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
    self.title = @"未开放";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self showMessageInView:self.view message:@"这项还未开放哦，请耐心等待！有惊喜哦！"];
    
	// Do any additional setup after loading the view.
}
//-(void)viewWillAppear:(BOOL)animated
//{
////    [self setNavigationBarHidden:YES animated:NO];
//}
-(void)viewDidAppear:(BOOL)animated{
//    [self setNavigationBarHidden:NO animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
