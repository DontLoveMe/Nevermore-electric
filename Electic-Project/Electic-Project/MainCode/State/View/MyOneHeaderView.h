//
//  MyOneHeaderView.h
//  ElectricProject
//
//  Created by 杨浩斌 on 16/6/14.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOneModel.h"
@interface MyOneHeaderView : UICollectionReusableView


@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UILabel *addressLabel;

-(void)configCellWithModel:(MyOneModel *)model;

@end
