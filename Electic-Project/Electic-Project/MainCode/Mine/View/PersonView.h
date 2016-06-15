//
//  PersonView.h
//  赛飞奇电力
//
//  Created by 刘毅 on 16/6/7.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonView : UIView

@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *label;
@property (nonatomic,strong)UITextField *textFiel;

- (void)setImageName:(NSString *)imgName
           labelText:(NSString *)labelText
        textFielText:(NSString *)textFielText;

@end
