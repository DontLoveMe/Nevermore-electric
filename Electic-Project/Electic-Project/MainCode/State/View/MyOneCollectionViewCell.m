//
//  MyOneCollectionViewCell.m
//  ElectricProject
//
//  Created by 杨浩斌 on 16/6/14.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "MyOneCollectionViewCell.h"
#import "UIView+SDAutoLayout.h"
@implementation MyOneCollectionViewCell


-(id)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        
        [self creatUI];
    }

    return self;
}

-(void)creatUI
{

    self.backView = [[UIImageView alloc]init];
    
    self.backView.image = [UIImage imageNamed:@"背景矩形常态"];
    
    [self.contentView addSubview:self.backView];
    
    _backView.sd_layout
    .leftSpaceToView(self.contentView,4)
    .topSpaceToView(self.contentView,10)
    .widthIs(120)
    .heightIs(100);
    
    self.nameLabel = [[UILabel alloc]init];
        
    self.nameLabel.font = [UIFont boldSystemFontOfSize:15];
    
    self.nameLabel.textColor = [UIColor whiteColor];
    
    [_backView addSubview:self.nameLabel];
    
    _nameLabel.sd_layout
    .leftSpaceToView(_backView,_backView.frame.size.width/2-30)
    .topSpaceToView(_backView,15)
    .widthIs(80)
    .heightIs(20);
    
    self.temperatureView = [[UIImageView alloc]init];
    
    self.temperatureView.image = [UIImage imageNamed:@"温度"];
    
    [_backView addSubview:self.temperatureView];
    
    _temperatureView.sd_layout
    .leftSpaceToView(_backView,10)
    .topSpaceToView(_nameLabel,12)
    .widthIs(20)
    .heightIs(20);
    
    
    self.temperatureLabel = [[UILabel alloc]init];
    
    self.temperatureLabel.textColor = [UIColor grayColor];
    
    self.temperatureLabel.font = [UIFont systemFontOfSize:12];
    
    [self.backView addSubview:self.temperatureLabel];
    
    _temperatureLabel.sd_layout
    .leftSpaceToView(_temperatureView,6)
    .topEqualToView(_temperatureView)
    .widthIs(100)
    .heightIs(25);
    
    
    self.residualcurrentView = [[UIImageView alloc]init];
    
    self.residualcurrentView.image = [UIImage imageNamed:@"剩余电量"];
    
    [self.backView addSubview:self.residualcurrentView];
    
    _residualcurrentView.sd_layout
    .leftSpaceToView(_backView,10)
    .topSpaceToView(_temperatureView,4)
    .widthIs(20)
    .heightIs(20);
    
    
    self.residualcurrentLabel = [[UILabel alloc]init];
    
    self.residualcurrentLabel.textColor = [UIColor grayColor];
    
    self.residualcurrentLabel.font = [UIFont systemFontOfSize:12];
    
    [self.backView addSubview:self.residualcurrentLabel];
    
    _residualcurrentLabel.sd_layout
    .leftSpaceToView(_temperatureView,6)
    .topSpaceToView(_temperatureLabel,6)
    .widthIs(100)
    .heightIs(25);
    
}

-(void)configCellWithModel:(MyOneModel *)model
{

    self.nameLabel.text = [NSString stringWithFormat:@"%@",model.boxName];
    
    
    
    self.temperatureLabel.text = [NSString stringWithFormat:@"温度:%@",model.temperature];
    
    self.residualcurrentLabel.text = [NSString stringWithFormat:@"剩余电量:%@",model.current];
    
    

}

@end
