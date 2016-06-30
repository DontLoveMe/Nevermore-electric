//
//  Common.h
//  ElectricProject
//
//  Created by coco船长 on 16/6/14.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#ifndef Common_h
#define Common_h

//测试服务器
#define BASE_URL @"http://120.24.41.38:8182"

/*--------------报警------------------*/
//报警列表
#define WarnningListURL @"/eps/monitor/history/list"
//报警处理
#define WarnningHandleURL @"/eps/monitor/history/handle"
//报警详情（图标）
#define WarnningDetailURL @"/eps/monitor/history/barchart"
//配电箱历史报警列表
#define WarnningHistoryListURL @"/eps/monitor/history/box/list"
//配电箱报警趋势图
#define WarnningHistoryPicURL @"/eps/monitor/history/temLineChart"

/*--------------电箱------------------*/
//配电箱列表
#define ElecticBoxListURL @"/eps/electric/box/list"
//配电箱搜索
#define ElecticBoxSearchURL @"/eps/electric/box/device/search"
//配电箱绑定
#define ElecticBoxBindURL @"/eps/box/staff/ref"
//配电箱状态列表
#define ElecticBoxStatusListURL @"/eps/electric/box/monitor"
//配电箱状态详情
#define ElecticBoxStatusDetailURL @"/eps/electric/box/monitor/detail"
//

/*--------------历史------------------*/
//配电箱历史列表
#define ElecticHistoryListURL @"/eps/electric/box/monitor/history"

/*--------------用户------------------*/
//用户登录
#define LoginURL @"/eps/sys/user/login"
//用户激活（第一次登陆）
#define ActiveUserURL @"/eps/sys/user/activate"
//用户修改密码
#define ModifyPasswordURL @"/eps/sys/user/password"
//用户修改信息
#define ModifyUserMsgURL @"/eps/sys/staff/update"
//用户意见反馈
#define AdviceURL  @"/eps/sys/feedback/add"
//用户搜索(技术人员关联)
#define SearchUserURL @"/eps/sys/user/search"

/*-上传文件-**-修改头像-*/
#define UpdataFileURL @"/eps/file/upload"

#endif /* Common_h */
