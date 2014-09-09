//
//  Ty_HomeWorkButtonCell.m
//  腾云家务
//
//  Created by 齐 浩 on 14-7-1.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_HomeWorkButtonCell.h"
#import "Ty_HomeMainObject.h"
@implementation Ty_HomeWorkButtonCell
@synthesize firstButton,secondButton,thirdButton,fourthButton;
@synthesize delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:view_BackGroudColor];
        firstButton = [[Ty_HomeWorkButton alloc]initWithFrame:CGRectMake(0, 0, 80, 100)];
        [firstButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        firstButton.hidden = YES;
        
        secondButton = [[Ty_HomeWorkButton alloc]initWithFrame:CGRectMake(self.frame.size.width/4, 0, 80, 100)];
        [secondButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        secondButton.hidden = YES;
        
        thirdButton = [[Ty_HomeWorkButton alloc]initWithFrame:CGRectMake(self.frame.size.width/2, 0, 80, 100)];
        [thirdButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        thirdButton.hidden = YES;
        
        fourthButton = [[Ty_HomeWorkButton alloc]initWithFrame:CGRectMake(self.frame.size.width/4*3, 0, 80, 100)];
        [fourthButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        fourthButton.hidden = YES;
        
        [self.contentView addSubview:firstButton];
        [self.contentView addSubview:secondButton];
        [self.contentView addSubview:thirdButton];
        [self.contentView addSubview:fourthButton];
        
    }
    return self;
}
-(void)loadData:(NSArray*)_dataArray
{
    for (int i=0; i<_dataArray.count; i++) {
        switch (i) {
            case 0:
                firstButton.hidden=NO;
                [firstButton setTitle:[_dataArray[i] workName] forState:UIControlStateNormal];
                [firstButton setImageWithURL:[NSURL URLWithString:[_dataArray[i] workPhoto]] forState:UIControlStateNormal placeholderImage:JWImageName([_dataArray[i] workName])];
                firstButton.workGuid=[_dataArray[i] workGuid];
                firstButton.workName=[_dataArray[i] workName];
                firstButton.firstworkName=[_dataArray[i] firstworkName];
                firstButton.firstworkGuid=[_dataArray[i] firstworkGuid];
                break;
            case 1:
                secondButton.hidden=NO;
                [secondButton setTitle:[_dataArray[i] workName] forState:UIControlStateNormal];
                [secondButton setImageWithURL:[NSURL URLWithString:[_dataArray[i] workPhoto]] forState:UIControlStateNormal placeholderImage:JWImageName([_dataArray[i] workName])];
                secondButton.workGuid=[_dataArray[i] workGuid];
                secondButton.workName=[_dataArray[i] workName];
                secondButton.firstworkName=[_dataArray[i] firstworkName];
                secondButton.firstworkGuid=[_dataArray[i] firstworkGuid];
                break;
            case 2:
                thirdButton.hidden=NO;
                [thirdButton setTitle:[_dataArray[i] workName] forState:UIControlStateNormal];
                [thirdButton setImageWithURL:[NSURL URLWithString:[_dataArray[i] workPhoto]] forState:UIControlStateNormal placeholderImage:JWImageName([_dataArray[i] workName])];
                thirdButton.workGuid=[_dataArray[i] workGuid];
                thirdButton.workName=[_dataArray[i] workName];
                thirdButton.firstworkName=[_dataArray[i] firstworkName];
                thirdButton.firstworkGuid=[_dataArray[i] firstworkGuid];
                break;
            case 3:
                fourthButton.hidden=NO;
                [fourthButton setTitle:[_dataArray[i] workName] forState:UIControlStateNormal];
                [fourthButton setImageWithURL:[NSURL URLWithString:[_dataArray[i] workPhoto]] forState:UIControlStateNormal placeholderImage:JWImageName([_dataArray[i] workName])];
                fourthButton.workGuid=[_dataArray[i] workGuid];
                fourthButton.workName=[_dataArray[i] workName];
                fourthButton.firstworkName=[_dataArray[i] firstworkName];
                fourthButton.firstworkGuid=[_dataArray[i] firstworkGuid];
                break;
            default:
                break;
        }
    }
}
-(void)click:(Ty_HomeWorkButton*)sender
{
    if (delegate) {
        [delegate click_homeWorkButton:sender];
    }
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
