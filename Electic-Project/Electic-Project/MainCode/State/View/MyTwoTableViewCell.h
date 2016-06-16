//
//  MyTwoTableViewCell.h
//  Electic-Project
//
//  Created by 杨浩斌 on 16/6/16.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTwoModel.h"

@interface MyTwoTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *lineOne;

@property(nonatomic,strong)UILabel *timeLabel;

@property(nonatomic,strong)UILabel *valueLabel;

@property(nonatomic,strong)UIImageView *lineTwo;
-(void)configCellWithModelTwo:(MyTwoModel *)model;

@end
