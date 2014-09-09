//
//  Ty_MyAttentionTableViewCell.m
//  腾云家务
//
//  Created by Xu Zhao on 14-6-3.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_MyAttentionTableViewCell.h"

@implementation Ty_MyAttentionTableViewCell
@synthesize strUserPhoto;
@synthesize imageH,imageHView;
@synthesize labName;
@synthesize labType;
@synthesize labWork;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //头像
        imageH = [UIImage imageNamed:strUserPhoto];
        imageHView = [[UIImageView alloc]init];
        [imageHView setFrame:CGRectMake(10, 8, 46, 46)];
        [imageHView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:imageHView];
        
        labName = [[UILabel alloc]init];
        [labName setBackgroundColor:[UIColor clearColor]];
        [labName setTextColor:[UIColor blackColor]];
        //[labName setHighlightedTextColor:[UIColor whiteColor]];
        [labName setFont:FONT15_BOLDSYSTEM];
        [labName setLineBreakMode:NSLineBreakByTruncatingMiddle];
        [self addSubview:labName];
        
        UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"greenBackGround.png"]];
        labType = [[UILabel alloc]init];
        [labType setBackgroundColor:color];
        [labType setTextColor:[UIColor whiteColor]];
        //[labType setHighlightedTextColor:[UIColor blackColor]];
        [labType setFont:FONT12_BOLDSYSTEM];
        [labType setTextAlignment:NSTextAlignmentCenter];
        [labType setLineBreakMode:NSLineBreakByTruncatingMiddle];
        [self addSubview:labType];
        
        UIButton *btnNotAttention = [[UIButton alloc]init];
        [btnNotAttention setFrame:CGRectMake(320-10-49, 8, 49, 20)];
        [btnNotAttention setBackgroundImage:[UIImage imageNamed:@"Contact_notAttention.png"] forState:UIControlStateNormal];
        //[btnNotAttention setTag:position];
        //[btnNotAttention addTarget:self action:@selector(deleteContactNetWork:) forControlEvents:UIControlEventTouchDown];
        //[self addSubview:btnNotAttention];
        
        labWork = [[UILabel alloc]init];
        [labWork setFrame:CGRectMake(65, 37, 230, 20)];
        [labWork.layer setCornerRadius:5];
        [labWork setBackgroundColor:[UIColor clearColor]];
        [labWork setTextColor:[UIColor grayColor]];
        //[labWork setHighlightedTextColor:[UIColor whiteColor]];
        [labWork setFont:FONT13_SYSTEM];
        [labWork setNumberOfLines:0];
        [self addSubview:labWork];
        
        /*customStar=[[CustomStar alloc]initWithFrame:CGRectMake(320-82, 40, 73, 13) Number:5];
        [customStar setUserInteractionEnabled:NO];
        [customStar setCustomStarNumber:[[[arrContactData objectAtIndex:position] contactdata_user_evaluateemployee] intValue]];
        [self addSubview:customStar];*/
    }
    return self;
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
