//
//  CustomStar.m
//  腾云家务
//
//  Created by 齐 浩 on 13-9-25.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "CustomStar.h"

@implementation CustomStar
@synthesize number;

- (id)initWithFrame:(CGRect)frame Number:(int)_number
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
//        NSLog(@"%d",(int)2.8);
        
        number = _number;
        
        for (int i = 0; i < number; i++) {
            UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(self.frame.size.width/5*i, 0, self.frame.size.height, self.frame.size.height)];
            [button setBackgroundImage:JWImageName(@"star_normal") forState:UIControlStateNormal];
            [button setTag:100*(i+1)];
            [button addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            button=nil;
        }
    }
    return self;
}
-(void)ClickButton:(UIButton* )sender
{
    
    for (int i = 0; i < number; i++) {
        
        UIButton *tempButton = (UIButton *)[self viewWithTag:100*(i+1)];
        if (100*(i+1) <= sender.tag){
            [tempButton setBackgroundImage:JWImageName(@"star_select") forState:UIControlStateNormal];
        }else{
            [tempButton setBackgroundImage:JWImageName(@"star_normal") forState:UIControlStateNormal];
        }
        tempButton = nil;
    }
    if (self.delegate) {
        [self.delegate CustomStarDelegateAction:sender.tag and:sender];
    }

}
-(void)setCustomStarNumber:(float)_number
{
    NSLog(@"%f",_number);
    float _number2 = _number;
    if (_number > 0&&_number <= 5) {
        _number2 = 0.5;
    }else if(_number > 5 && _number <= 10){
        _number2 = 1;
    }else if(_number2 > 10 && _number <= 20){
        _number2 = 1.5;
    }else if (_number2 > 20 && _number2 <= 30){
        _number2 = 2;
    }else if(_number2 > 30 && _number2 <= 40){
        _number2 = 2.5;
    }else if (_number2 > 40 && _number2 <= 50){
        _number2 = 3;
    }else if (_number2 > 50 && _number2 <= 70){
        _number2 = 3.5;
    }else if (_number2 > 70 && _number2 <= 90){
        _number2 = 4;
    }else if (_number2 > 90 && _number2 <= 120){
        _number2 = 4.5;
    }else if( _number2 > 120){
        _number2 = 5;
    }
    int num = (int)_number2;
    UIButton *tempButton = (UIButton *)[self viewWithTag:100*(num+1)];
    
    if(num == 5)
    {
        for (int i = 0; i < number; i++) {
            UIButton *Button = (UIButton *)[self viewWithTag:100*(i+1)];
                [Button setBackgroundImage:JWImageName(@"star_select") forState:UIControlStateNormal];
        }
    }else{
        for (int i = 0; i < number; i++) {
            UIButton *Button = (UIButton *)[self viewWithTag:100*(i+1)];
            if (100*(i+1) <= tempButton.tag && i <= (_number2 - 1)){
                [Button setBackgroundImage:JWImageName(@"star_select") forState:UIControlStateNormal];
            }else if((100*(i+1) >= tempButton.tag) && (100*(i+1) < (tempButton.tag+100) && i < _number2)){
                [Button setBackgroundImage:JWImageName(@"star_half") forState:UIControlStateNormal];
            }else{
                [Button setBackgroundImage:JWImageName(@"star_normal") forState:UIControlStateNormal];
            }
        }
    }
    tempButton=nil;
}
-(void)setEvaluateStarNumber:(int)_number
{
    int num = (int)_number;
    UIButton *tempButton = (UIButton *)[self viewWithTag:100*(num+1)];
    
    if(num == 5)
    {
        for (int i = 0; i < number; i++) {
            UIButton *Button = (UIButton *)[self viewWithTag:100*(i+1)];
            [Button setBackgroundImage:JWImageName(@"star_select") forState:UIControlStateNormal];
        }
    }else{
        for (int i = 0; i < number; i++) {
            UIButton *Button = (UIButton *)[self viewWithTag:100*(i+1)];
            if (100*(i+1) <= tempButton.tag && i <= (_number-1)){
                [Button setBackgroundImage:JWImageName(@"star_select") forState:UIControlStateNormal];
            }else if((100*(i+1) >= tempButton.tag) && (100*(i+1) < (tempButton.tag+100) && i < _number)){
                [Button setBackgroundImage:JWImageName(@"star_half") forState:UIControlStateNormal];
            }else{
                [Button setBackgroundImage:JWImageName(@"star_normal") forState:UIControlStateNormal];
            }
        }
    }
    tempButton = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
