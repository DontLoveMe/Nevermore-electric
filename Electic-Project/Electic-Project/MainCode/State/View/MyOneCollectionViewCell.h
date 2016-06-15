//
//  MyOneCollectionViewCell.h
//  ElectricProject
//
//  Created by 杨浩斌 on 16/6/14.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOneModel.h"

@interface MyOneCollectionViewCell : UICollectionViewCell

//背景
@property(nonatomic,strong)UIImageView *backView;

//名称
@property(nonatomic,strong)UILabel *nameLabel;

//温度图片
@property(nonatomic,strong)UIImageView *temperatureView;

//剩余电路图片
@property(nonatomic,strong)UIImageView *residualcurrentView;

//温度值
@property(nonatomic,strong)UILabel *temperatureLabel;

//剩余电流值
@property(nonatomic,strong)UILabel *residualcurrentLabel;

-(void)configCellWithModel:(MyOneModel *)model;


@end
