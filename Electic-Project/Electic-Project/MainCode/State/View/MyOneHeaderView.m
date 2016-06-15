//
//  MyOneHeaderView.m
//  ElectricProject
//
//  Created by 杨浩斌 on 16/6/14.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "MyOneHeaderView.h"
#import "UIView+SDAutoLayout.h"
@implementation MyOneHeaderView

-(id)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        
        [self creatUI];
    }
    
    return self;
}


-(void)creatUI
{

    self.iconView = [[UIImageView alloc]init];
    
    self.iconView.image = [UIImage imageNamed:@"地址图标"];
    
    [self addSubview:self.iconView];
    
    _iconView.sd_layout
    .leftSpaceToView(self,14)
    .topSpaceToView(self,5)
    .widthIs(20)
    .heightIs(25);
    
    self.addressLabel = [[UILabel alloc]init];
    
    self.addressLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:self.addressLabel];
    
    _addressLabel.sd_layout
    .leftSpaceToView(_iconView,7)
    .topEqualToView(_iconView)
    .widthIs(150)
    .heightIs(25);


}

-(void)configCellWithModel:(MyOneModel *)model
{
    
    self.addressLabel.text = [NSString stringWithFormat:@"%@",model.orgName];
    
}
@end
