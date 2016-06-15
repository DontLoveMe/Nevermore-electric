//
//  LoginTextFiel.h
//  赛飞奇电力
//
//  Created by 刘毅 on 16/6/7.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginTextField : UIView

@property (nonatomic,strong)UIImageView *bgImgView;
@property (nonatomic,strong)UIImageView *iconImgView;
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)UIButton *button;

- (void)setImageName:(NSString *)imgName
        textFielText:(NSString *)textFielText
  verifyButtonHidden:(BOOL)hidden;

@end
