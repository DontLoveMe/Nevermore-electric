//
//  MyTwoModel.h
//  Electic-Project
//
//  Created by 杨浩斌 on 16/6/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTwoModel : NSObject

//电箱名称
@property(nonatomic,copy)NSString *BoxName;

//处理状态
@property(nonatomic,copy)NSString *wranType;

//报警时间
@property(nonatomic,copy)NSString *createDate;

//预警类型
@property(nonatomic,copy)NSString *Stutas;

@end
