//
//  LoginTextFiel.m
//  赛飞奇电力
//
//  Created by 刘毅 on 16/6/7.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "LoginTextField.h"

@implementation LoginTextField

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}
- (void)initViews {
    
    _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth-80, self.frame.size.height)];
    _bgImgView.image = [UIImage imageNamed:@"登录_输入框"];
    [self addSubview:_bgImgView];
    
    _iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, (self.frame.size.height-30)/2, 25, 30)];
    [self addSubview:_iconImgView];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconImgView.frame)+5, (self.frame.size.height-30)/2, 1, 30)];
    imageView.image = [UIImage imageNamed:@"登录_竖线"];
    [self addSubview:imageView];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(40, (self.frame.size.height-20)/2, 200, 20)];
    _textField.textColor = [UIColor colorWithWhite:1 alpha:1];
    
    [self addSubview:_textField];
}

- (void)setImageName:(NSString *)imgName
        textFielText:(NSString *)textFielText
  verifyButtonHidden:(BOOL)hidden{
    
    _iconImgView.image = [UIImage imageNamed:imgName];
//    _textField.placeholder = textFielText;
    _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textFielText
                                                                       attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.7 alpha:0.7],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    
    
    if (hidden) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.tag = 100;
        _button.frame = CGRectMake(KScreenWidth-80-80, 0, 80, self.frame.size.height);
        [_button setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_button setBackgroundImage:[UIImage imageNamed:@"登录_输入框"] forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:13];
        [_button setTitleColor:[UIColor colorFromHexRGB:@"009BFF"] forState:UIControlStateNormal];
        [self addSubview:_button];
    }
}

@end
