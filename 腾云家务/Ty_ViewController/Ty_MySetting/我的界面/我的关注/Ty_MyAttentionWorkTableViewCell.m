//
//  Ty_MyAttentionWorkTableViewCell.m
//  腾云家务
//
//  Created by Xu Zhao on 14-6-9.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_MyAttentionWorkTableViewCell.h"

@implementation Ty_MyAttentionWorkTableViewCell
@synthesize labWorkName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        labWorkName = [[UILabel alloc]init];
        [labWorkName setBackgroundColor:[UIColor clearColor]];
        [labWorkName setHighlightedTextColor:[UIColor whiteColor]];
        [labWorkName setFont:FONT14_SYSTEM];
        [self addSubview:labWorkName];
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
