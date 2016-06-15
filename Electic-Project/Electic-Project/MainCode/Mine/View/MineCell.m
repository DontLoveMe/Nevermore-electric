//
//  MineCell.m
//  赛飞奇电力
//
//  Created by 刘毅 on 16/6/6.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "MineCell.h"

@implementation MineCell {
    
    __weak IBOutlet UIImageView *_imgView;
       
    __weak IBOutlet UILabel *_nameLabel;
    
    __weak IBOutlet NSLayoutConstraint *_imgWidth;
}

- (void)setDic:(NSDictionary *)dic {
    if (_dic != dic) {
        _dic = dic;
    }
   
    NSString *img = _dic[@"image"];
    if (img.length > 0 ) {
       _imgView.image = [UIImage imageNamed:img];
       
    }else {
        _imgView.image = nil;
        _imgWidth.constant = 0;
    }
    
    
    _nameLabel.text = _dic[@"name"];
    
    
}


@end
