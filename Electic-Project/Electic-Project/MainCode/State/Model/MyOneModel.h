//
//  MyOneModel.h
//  ElectricProject
//
//  Created by 杨浩斌 on 16/6/14.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOneModel : NSObject

@property(nonatomic,copy)NSString *boxName;

@property(nonatomic,strong)NSNumber *boxId;

@property(nonatomic,strong)NSDictionary *monitors;

@property(nonatomic,strong)NSNumber *isError;

@property(nonatomic,strong)NSNumber *isOnline;

+ (MyOneModel *)modelWithDic:(NSDictionary *)dic;

@end
