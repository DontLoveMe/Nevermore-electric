//
//  MyOneTableViewCell.h
//  Electic-Project
//
//  Created by 杨浩斌 on 16/6/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTwoModel.h"
@interface MyOneTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *typeLabel;

@property(nonatomic,strong)UILabel *timeLabel;

@property(nonatomic,strong)UILabel *staeLabel;



-(void)configCellWithModelTwo:(MyTwoModel *)model;


@end
