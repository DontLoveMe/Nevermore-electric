//
//  MyTwoTableViewCell.m
//  Electic-Project
//
//  Created by 杨浩斌 on 16/6/16.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "MyTwoTableViewCell.h"

#import "UIView+SDAutoLayout.h"

@implementation MyTwoTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatUI];
    }

    return self;
}

-(void)creatUI
{

    self.lineOne = [[UIImageView alloc]init];
    
    [self.contentView addSubview:self.lineOne];
    
    _lineOne.sd_layout
    .leftSpaceToView(self.contentView,5)
    .topSpaceToView(self.contentView,3)
    .widthIs(KScreenWidth-10)
    .heightIs(2);
    
  _timeLabel = [[UILabel alloc]init];
    
    _timeLabel.textColor = [UIColor redColor];
    
    _timeLabel.font = [UIFont systemFontOfSize:14];
    
    [self.contentView addSubview:_timeLabel];
    
    _timeLabel.sd_layout
    .leftSpaceToView(self.contentView,5)
    .topSpaceToView(_lineOne,10)
    .widthIs(200)
    .heightIs(20);
    
    self.valueLabel = [[UILabel alloc]init];
    
    self.valueLabel.textColor = [UIColor redColor];
    
    self.valueLabel.font = [UIFont systemFontOfSize:14];
    
    [self.contentView addSubview:self.valueLabel];
    
    _valueLabel.sd_layout
    .rightSpaceToView(self.contentView,10)
    .topSpaceToView(_lineOne,10)
    .widthIs(40)
    .heightIs(20);
    
    
    self.lineTwo = [[UIImageView alloc]init];
    
    [self.contentView addSubview:self.lineTwo];
    
    _lineTwo.sd_layout
    .leftSpaceToView(self.contentView,5)
    .topSpaceToView(_timeLabel,10)
    .widthIs(KScreenWidth-10)
    .heightIs(2);
    
    
    
  

}

-(void)configCellWithModelTwo:(MyTwoModel *)model

{

    self.timeLabel.text = model.createDate;
    
    if ([model.wranType integerValue]==1) {
        
        self.valueLabel.text = [NSString stringWithFormat:@"%@℃",model.curValue];

    }else
    {
        self.valueLabel.text = [NSString stringWithFormat:@"%@A",model.curValue];

    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
