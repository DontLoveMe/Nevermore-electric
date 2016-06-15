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
    UIView          *_acountView;
    UIButton        *_acountSelectButton;
    UILabel         *_acountexistLabel;
    UITextField     *_acountexistTF;
    UIButton        *_acountUnselectButton;
    UILabel         *_acountAddlabel;
    UITextField     *_acountAddTF;
    
    //保存按钮
    UIButton        *_commitButton;
    
    //选择tableView
    UITableView     *_selectTable;
    NSMutableArray  *_selectArr;
    //手势
    UITapGestureRecognizer  *_singleTap;

    //选中的label(100->地址，101->序列号，102->账户)
    NSInteger       _textFieldType;
    
    //用户传的参数
    NSMutableDictionary *_params;
    
}

@end
