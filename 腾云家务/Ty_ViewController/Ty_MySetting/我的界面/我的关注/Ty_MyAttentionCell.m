//
//  Ty_MyAttentionCell.m
//  腾云家务
//
//  Created by liu on 14-7-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_MyAttentionCell.h"

@implementation Ty_MyAttentionCell

@synthesize headerImageView = _headerImageView;
@synthesize nameLabel = _nameLabel;
@synthesize workDetailLabel = _workDetailLabel;
@synthesize serviceTypeLabel = _serviceTypeLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 46, 46)];
        _headerImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_headerImageView];
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:15];
        _nameLabel.textColor = [UIColor blackColor];
        [self addSubview:_nameLabel];
        
        _serviceTypeLabel = [[UILabel alloc]init];
        _serviceTypeLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"greenBackGround.png"]];
        _serviceTypeLabel.textColor = [UIColor whiteColor];
        _serviceTypeLabel.font = [UIFont boldSystemFontOfSize:12];
        [self addSubview:_serviceTypeLabel];
        
        _workDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(65, 37, 230, 20)];
        _workDetailLabel.backgroundColor = [UIColor clearColor];
        _workDetailLabel.textColor = [UIColor grayColor];
        _workDetailLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_workDetailLabel];
        
        
    }
    return self;
}

- (void)setContent:(Ty_Model_ServiceObject *)serviceObject
{
    NSString *nameStr = @"";
    NSString *typeNameStr = @"";
    UIImage *placehoderImage;
    if ([serviceObject.userType isEqualToString:@"1"])//中介下短工
    {
        nameStr = serviceObject.userRealName;
        typeNameStr = serviceObject.respectiveCompanies;
        placehoderImage = [serviceObject.sex isEqualToString:@"1"] ? [UIImage imageNamed:@"Message_Female"] : [UIImage imageNamed:@"Message_Male"];
    }
    else if ([serviceObject.userType isEqualToString:@"0"]) // 中介
    {
        nameStr = serviceObject.respectiveCompanies;
        typeNameStr = @"商户";
        placehoderImage = [UIImage imageNamed:@"Message_Service"];
    }
    else //个人，新版本之后不存在这个问题
    {
        nameStr = serviceObject.userRealName;
        typeNameStr = @"个人";
        placehoderImage = [serviceObject.sex isEqualToString:@"1"] ? [UIImage imageNamed:@"Message_Female"] : [UIImage imageNamed:@"Message_Male"];
    }
    
    CGSize size = [nameStr sizeWithFont:[UIFont boldSystemFontOfSize:15] forWidth:250 lineBreakMode:NSLineBreakByCharWrapping];
    _nameLabel.frame = CGRectMake(65, 5, size.width + 2, 20);
    _nameLabel.text = nameStr;
    
    CGSize typeLabelSize = [typeNameStr sizeWithFont:[UIFont boldSystemFontOfSize:12] forWidth:200 lineBreakMode:NSLineBreakByCharWrapping];
    
    _serviceTypeLabel.frame = CGRectMake(65 + _nameLabel.frame.size.width, 8, typeLabelSize.width + 2, 16) ;
    _serviceTypeLabel.text = typeNameStr;
    
    _workDetailLabel.text = serviceObject.userPost;
    
    
    [_headerImageView setImageWithURL:[NSURL URLWithString:serviceObject.headPhoto] placeholderImage:placehoderImage];
    
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
