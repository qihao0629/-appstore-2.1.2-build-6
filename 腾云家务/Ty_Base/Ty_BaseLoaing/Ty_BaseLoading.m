//
//  Ty_BaseLoading.m
//  腾云家务
//
//  Created by 齐 浩 on 14-5-26.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_BaseLoading.h"
#import "Ty_BaseLoadingView.h"
@interface Ty_BaseLoading ()

@end

@implementation Ty_BaseLoading

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}
-(void)button_back:(UIButton *)but{
    [Ty_BaseLoadingView  loadingViewRemove];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT-44-49)];
    [Ty_BaseLoadingView loadingViewInit:self.view];
   
    
    //    [button_back addTarget:self action:@selector(button_back:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark ----- Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
