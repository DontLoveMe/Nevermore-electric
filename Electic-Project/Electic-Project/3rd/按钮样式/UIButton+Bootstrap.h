//
//  UIButton+Bootstrap.h
//  UIButton+Bootstrap
//
//  Created by Oskar Groth on 2013-09-29.
//  Copyright (c) 2013 Oskar Groth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"

@interface UIButton (Bootstrap)

- (void)addAwesomeIcon:(FAIcon)icon beforeTitle:(BOOL)before;

-(void)bootstrapStyle;

-(void)defaultStyle;

-(void)primaryStyle;

-(void)successStyle;

-(void)infoStyle;

-(void)warningStyle;

-(void)dangerStyle;

// 主题色按钮风格
-(void)themeBtnStyle;

//灰色按钮风格
-(void)lightGrayBtnStyle;

// 白色风格按钮
-(void)writeBtnStyle;

// 文本风格按钮
-(void)textBtnStyle;

// 边框风格
-(void)borderBtnStyle;

@end
