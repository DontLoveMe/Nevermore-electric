//
//  MyOneTableViewCell.m
//  Electic-Project
//
//  Created by 杨浩斌 on 16/6/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "MyOneTableViewCell.h"
#import "UIView+SDAutoLayout.h"
@implementation MyOneTableViewCell

{

    MyTwoModel *_model;

}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{


    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatUI];
    }
    
    return self;

}

-(void)creatUI
{

  
    _iconView = [[UIImageView alloc]init];
    
    _iconView.image = [UIImage imageNamed:@"警告图像"];

    
    [self.contentView addSubview:_iconView];
    
    _iconView.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,30)
    .widthIs(45)
    .heightIs(45);
    
    self.nameLabel = [[UILabel alloc]init];
    
    self.nameLabel.font = [UIFont boldSystemFontOfSize:15];
    
    self.nameLabel.textColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.nameLabel];
    
    _nameLabel.sd_layout
    .leftSpaceToView(_iconView,10)
    .topSpaceToView(self.contentView,30)
    .widthIs(60)
    .heightIs(20);
    
    self.typeLabel = [[UILabel alloc]init];
    
    self.typeLabel.font = [UIFont boldSystemFontOfSize:12];
    
    self.typeLabel.textColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.typeLabel];
    
    _typeLabel.sd_layout
    .leftSpaceToView(_iconView,10)
    .topSpaceToView(_nameLabel,7)
    .widthIs(120)
    .heightIs(20);
    
    self.timeLabel = [[UILabel alloc]init];
    
    self.timeLabel.font = [UIFont systemFontOfSize:10];
    
    self.timeLabel.textColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.timeLabel];
    
    _timeLabel.sd_layout
    .rightSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,30)
    .widthIs(120)
    .heightIs(20);
    
    self.staeLabel = [[UILabel alloc]init];
    
    self.staeLabel.font = [UIFont systemFontOfSize:12];
    
    self.staeLabel.textColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.staeLabel];
    

    _staeLabel.sd_layout
    .rightSpaceToView(self.contentView,15)
    .topSpaceToView(_timeLabel,15)
    .widthIs(50)
    .heightIs(20);
    
    

}

-(void)configCellWithModelTwo:(MyTwoModel *)model
{


    _model=model;
    
  _iconView.image = [UIImage imageNamed:@"警告图像"];

    
    self.nameLabel.text = model.boxName;
    
    
     self.timeLabel.text = model.createDate;
//
    
    NSString *str =  [NSString stringWithFormat:@"%@",model.wranType];
    
    
    if ([str isEqualToString:@"1"]) {
        
        self.typeLabel.text = @"检测到温度异常";

    }else
    {
    
        self.typeLabel.text = @"检测到电流异常";

      }
    
    NSString *str2 = [NSString stringWithFormat:@"%@",model.stutas];
    
    if ([str2 isEqualToString:@"1"]) {
        
        self.staeLabel.text = @"已处理";
        
    }else
    {
        
        self.staeLabel.text = @"未处理";
        
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
