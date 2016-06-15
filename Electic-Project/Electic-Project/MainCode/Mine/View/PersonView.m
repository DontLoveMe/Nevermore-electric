//
//  PersonView.m
//  赛飞奇电力
//
//  Created by 刘毅 on 16/6/7.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "PersonView.h"

@implementation PersonView

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
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, (self.frame.size.height-30)/2, 25, 30)];
    [self addSubview:_imgView];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(40, (self.frame.size.height-20)/2, 100, 20)];
    _label.tag = 100;
    _label.text = @"创建";
    _label.textColor = [UIColor whiteColor];
    _label.font = [UIFont systemFontOfSize:16];
    [self addSubview:_label];
    
    _textFiel = [[UITextField alloc] initWithFrame:CGRectMake(self.frame.size.width-205, (self.frame.size.height-20)/2, 200, 20)];
    _textFiel.textColor = [UIColor colorWithWhite:0.6 alpha:1];
    _textFiel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_textFiel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
    imageView.image = [UIImage imageNamed:@"横线"];
    [self addSubview:imageView];
    
}

- (void)setImageName:(NSString *)imgName
           labelText:(NSString *)labelText
        textFielText:(NSString *)textFielText {
    
    _imgView.image = [UIImage imageNamed:imgName];
    _label.text = labelText;
    _textFiel.text = textFielText;
}
@end
