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

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{


    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatUI];
    }
    
    return self;

}

-(void)creatUI
{

  
    self.iconView = [[UIImageView alloc]init];
    
    [self.contentView addSubview:self.iconView];
    
    _iconView.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,19)
    .widthIs(40)
    .heightIs(40);
    
    self.nameLabel = [[UILabel alloc]init];
    
    self.nameLabel.font = [UIFont boldSystemFontOfSize:15];
    
    self.nameLabel.textColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.nameLabel];
    
    _nameLabel.sd_layout
    .leftSpaceToView(_iconView,10)
    .topSpaceToView(self.contentView,15)
    .widthIs(60)
    .heightIs(20);
    
    self.typeLabel = [[UILabel alloc]init];
    
    self.typeLabel.font = [UIFont boldSystemFontOfSize:12];
    
    self.typeLabel.textColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.typeLabel];
    
    _typeLabel.sd_layout
    .leftSpaceToView(_iconView,10)
    .topSpaceToView(_nameLabel,7)
    .widthIs(80)
    .heightIs(20);
    
    self.timeLabel = [[UILabel alloc]init];
    
    self.timeLabel.font = [UIFont systemFontOfSize:10];
    
    self.timeLabel.textColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.timeLabel];
    
    _timeLabel.sd_layout
    .rightSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,21)
    .widthIs(40)
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

-(void)configCellWithModel:(MyTwoModel *)model
{


    self.nameLabel.text = model.BoxName;
    
    self.typeLabel.text = model.Stutas;
    
    self.timeLabel.text = model.createDate;
    
    self.staeLabel.text = model.wranType;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
