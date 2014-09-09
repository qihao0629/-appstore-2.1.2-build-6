//
//  ViewController.h
//  腾云家务
//
//  Created by 齐 浩 on 13-9-22.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegateViewController.h"
#import "UIImage+SplitImageIntoTwoParts.h"
@protocol viewControllerDelegate <NSObject>

@optional
-(void)pop;

@end
@interface ViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic,retain) UIImageView *left;
@property (nonatomic,retain) UIImageView *right;

@property (retain, nonatomic) UIScrollView *pageScroll;
@property (retain, nonatomic) UIView *View1;
@property (retain, nonatomic) UIImageView *imageView;
@property (retain, nonatomic) UIButton *gotoMainViewBtn;
@property (retain, nonatomic) UIImageView *image4;
@property (retain, nonatomic) UIImageView *image3;
@property (retain, nonatomic) UIImageView *image2;
@property (retain, nonatomic) UIImageView *image1;
@property (retain, nonatomic) UIPageControl *pageControl;
@property(nonatomic,strong)id<viewControllerDelegate>delegate;


@property (retain, nonatomic) AppDelegateViewController* AppVC;
- (void)gotoMainViewBtn:(id)sender;

@end
