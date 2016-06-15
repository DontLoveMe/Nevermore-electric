//
//  BindController.h
//  ElectricProject
//
//  Created by coco船长 on 16/6/14.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

@interface BindController : BaseViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>{

    UIScrollView    *_bgScrollView;
    
    //地址
    UIImageView     *_addressImg;
    UILabel         *_addressLabel;
    UITextField     *_addressTF;
    
    //设备
    UIImageView     *_deviceImg;
    UILabel         *_deviceLabel;
    UILabel         *_deviceIDLabel;
    UITextField     *_deviceIDTF;
    UILabel         *_devicePhoneLabel;
    UITextField     *_devicePhoneTF;
    
    //公司名
    UIImageView     *_complanyImg;
    UILabel         *_complanyLabel;
    UITextField     *_complanyTF;
    
    //账号
    UIImageView     *_acountImg;
    UILabel         *_acountLabel;
    
    //保存按钮
    UIButton        *_commitButton;
    
    //选择tableView
    UITableView     *_selectTable;
    NSMutableArray  *_selectArr;
    //手势
    UITapGestureRecognizer  *_singleTap;

}

@end
