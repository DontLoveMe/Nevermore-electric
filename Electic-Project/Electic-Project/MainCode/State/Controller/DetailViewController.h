//
//  DetailViewController.h
//  ElectricProject
//
//  Created by 杨浩斌 on 16/6/14.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

@interface DetailViewController : BaseViewController

//标题
@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *textTitle;

//配电箱ID
@property(nonatomic,strong)NSNumber *boxID;

//地址
@property(nonatomic,copy)NSString *address;

//配电箱
@property(nonatomic,copy)NSString *boxName;

//户名
@property(nonatomic,copy)NSString *namelabel;

//探测器
@property(nonatomic,copy)NSString *detector;

//通讯
@property(nonatomic,copy)NSString *dispatch;

//温度值
@property(nonatomic,copy)NSString *tempture;

//剩余电流值
@property(nonatomic,copy)NSString *current;



@end
