//
//  MyOneModel.m
//  ElectricProject
//
//  Created by 杨浩斌 on 16/6/14.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "MyOneModel.h"

@implementation MyOneModel

+ (MyOneModel *)modelWithDic:(NSDictionary *)dic {
    MyOneModel *model = [[MyOneModel alloc] init];
    
    if (![dic[@"boxName"] isEqual:[NSNull null]]) {
        model.boxName = dic[@"boxName"];
    }
    if (![dic[@"id"] isEqual:[NSNull null]]) {
        model.boxId = dic[@"id"];
    }
    if (![dic[@"monitors"] isEqual:[NSNull null]]) {
        model.monitors = dic[@"monitors"];
    }
    if (![dic[@"isError"] isEqual:[NSNull null]]) {
        model.isError = dic[@"isError"];
    }
    if (![dic[@"isOnline"] isEqual:[NSNull null]]) {
        model.isOnline = dic[@"isOnline"];
    }
    
    return model;
}

@end
