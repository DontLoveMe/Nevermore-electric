//
//  HomeCell.m
//  赛飞奇电力
//
//  Created by 刘毅 on 16/6/6.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell {
    
    __weak IBOutlet UIImageView *_imgView;
    
    __weak IBOutlet UILabel *_nameLabel;
    
    __weak IBOutlet UILabel *_annotateLabel;
}


- (void)setDic:(NSDictionary *)dic {
    if (_dic != dic) {
        _dic = dic;
    }
    
    _imgView.image = [UIImage imageNamed:_dic[@"image"]];
    
    _nameLabel.text = _dic[@"name"];
    
    _annotateLabel.text = _dic[@"annotate"];
    
}

@end
