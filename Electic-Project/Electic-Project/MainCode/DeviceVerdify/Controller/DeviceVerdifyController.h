//
//  DeviceVerdifyController.h
//  Electic-Project
//
//  Created by coco船长 on 16/6/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

@interface DeviceVerdifyController : BaseViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>{

    //设备
    UIImageView     *_deviceImg;
    UILabel         *_deviceLabel;
    UILabel         *_deviceIDLabel;
    UITextField     *_deviceIDTF;
    UILabel         *_devicePhoneLabel;
    UITextField     *_devicePhoneTF;
    
    UIButton        *_resetButton;
    UIButton        *_dampButton;
    
    //选择tableView
    UITableView     *_selectTable;
    NSMutableArray  *_selectArr;
    //手势
    UITapGestureRecognizer  *_singleTap;
    
    //用户传的参数
    NSMutableDictionary *_params;

}

@end
