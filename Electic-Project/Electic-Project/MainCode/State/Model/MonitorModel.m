//
//  MonitorModel.m
//  Electic-Project
//
//  Created by 刘毅 on 16/8/12.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "MonitorModel.h"

@implementation MonitorModel
+ (MonitorModel *)modelWithDic:(NSDictionary *)dic {
    MonitorModel *model = [[MonitorModel alloc] init];
    
    if (![dic[@"curValue"] isEqual:[NSNull null]]) {
        model.curValue = dic[@"curValue"];
    }
    if (![dic[@"createDate"] isEqual:[NSNull null]]) {
        model.boxId = dic[@"createDate"];
    }
    if (![dic[@"id"] isEqual:[NSNull null]]) {
        model.monitorId = dic[@"id"];
    }
    if (![dic[@"isError"] isEqual:[NSNull null]]) {
        model.isError = dic[@"isError"];
    }
    if (![dic[@"deviceId"] isEqual:[NSNull null]]) {
        model.deviceId = dic[@"deviceId"];
    }
    if (![dic[@"status"] isEqual:[NSNull null]]) {
        model.status = dic[@"status"];
    }
    if (![dic[@"channelNo"] isEqual:[NSNull null]]) {
        model.channelNo = dic[@"channelNo"];
    }
    
    return model;
}
@end
