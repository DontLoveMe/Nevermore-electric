//
//  MonitorModel.h
//  Electic-Project
//
//  Created by 刘毅 on 16/8/12.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MonitorModel : NSObject
/*"id": 89,
 "channelNo": 1,
 "heartbeatId": null,
 "wranType": 2,
 "isError": 1,
 "curValue": "840",
 "curConfigValue": null,
 "deviceId": 17,
 "status": 0,
 "createBy": null,
 "createDate": "2016-08-12 10:30:07",
 "lastUpdatedBy": null,
 "lastUpdateDate": "2016-08-12 10:30:07",
 "deleteFlag": 0,
 "boxId": null,
 "boxName": null,
 "orgName": null,
 "handleType": null,
 "seqNum": null,
 "staffName": null,
 "phone": null*/
//@property(nonatomic,copy)NSString *boxName;
//
//@property(nonatomic,copy)NSString *orgName;
//
//@property(nonatomic,copy)NSString *staffName;
//
//@property(nonatomic,copy)NSString *phone;

@property(nonatomic,copy)NSString *curValue;

@property(nonatomic,copy)NSString *createDate;

@property(nonatomic,strong)NSNumber *monitorId;

@property(nonatomic,strong)NSNumber *boxId;

@property(nonatomic,strong)NSNumber *isError;

@property(nonatomic,strong)NSNumber *deviceId;

@property(nonatomic,strong)NSNumber *wranType;

@property(nonatomic,strong)NSNumber *status;

@property(nonatomic,strong)NSNumber *channelNo;

+ (MonitorModel *)modelWithDic:(NSDictionary *)dic;
@end
