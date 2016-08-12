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
    
    [self.contentView addSubview:self.backView];
    
    _backView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,3)
    .rightSpaceToView(self.contentView,0)
    .heightIs(100);
    
    self.stateLabel = [[UILabel alloc] init];
    self.stateLabel.textAlignment = NSTextAlignmentCenter;
    self.stateLabel.textColor = [UIColor whiteColor];
    self.stateLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.stateLabel];
    
    _stateLabel.sd_layout
    .leftSpaceToView(self.contentView,4)
    .topSpaceToView(_backView,0)
    .rightSpaceToView(self.contentView,0)
    .heightIs(20);
    
    self.nameLabel = [[UILabel alloc]init];
        
    self.nameLabel.font = [UIFont boldSystemFontOfSize:15];
    
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [_backView addSubview:self.nameLabel];
    
    _nameLabel.sd_layout
    .leftSpaceToView(_backView,0)
    .topSpaceToView(_backView,15)
    .rightSpaceToView(_backView,0)
    .heightIs(20);
    
    self.temperatureView = [[UIImageView alloc]init];
    
    self.temperatureView.image = [UIImage imageNamed:@"温度"];
    
    [_backView addSubview:self.temperatureView];
    
    _temperatureView.sd_layout
    .leftSpaceToView(_backView,10)
    .topSpaceToView(_nameLabel,4)
    .widthIs(20)
    .heightIs(20);
    
    
    self.temperatureLabel = [[UILabel alloc]init];
    
    self.temperatureLabel.textColor = [UIColor whiteColor];
    
    self.temperatureLabel.font = [UIFont systemFontOfSize:11];
    self.temperatureLabel.text = @"温度：未知";
    [self.backView addSubview:self.temperatureLabel];
    
    _temperatureLabel.sd_layout
    .leftSpaceToView(_temperatureView,3)
    .centerYEqualToView(_temperatureView)
    .widthIs(100)
    .heightIs(25);
    
    
    self.residualcurrentView = [[UIImageView alloc]init];
    
    self.residualcurrentView.image = [UIImage imageNamed:@"剩余电量"];
    
    [self.backView addSubview:self.residualcurrentView];
    
    _residualcurrentView.sd_layout
    .leftSpaceToView(_backView,10)
    .topSpaceToView(_temperatureView,2)
    .widthIs(20)
    .heightIs(20);
    
    
    self.residualcurrentLabel = [[UILabel alloc]init];
    
    self.residualcurrentLabel.textColor = [UIColor whiteColor];
    
    self.residualcurrentLabel.font = [UIFont systemFontOfSize:11];
    self.residualcurrentLabel.text = @"剩余电流：未知";
    [self.backView addSubview:self.residualcurrentLabel];
    
//    _residualcurrentLabel.sd_layout
//    .leftSpaceToView(_temperatureView,6)
//    .topSpaceToView(_temperatureLabel,3)
//    .widthIs(100)
//    .heightIs(25);
    _residualcurrentLabel.sd_layout.
    leftSpaceToView(_residualcurrentView,3)
    .centerYEqualToView(_residualcurrentView)
    .widthIs(100)
    .heightIs(25);
}

-(void)configCellWithModel:(MyOneModel *)model
{

    //self.nameLabel.text = [NSString stringWithFormat:@"%@",model.boxName];
    
    
//    
//    self.temperatureLabel.text = [NSString stringWithFormat:@"温度:%@",model.temperature];
//    
//    
//    
//    self.residualcurrentLabel.text = [NSString stringWithFormat:@"剩余电量:%@",model.current];

    
    

}

@end
