//
//  AlarmViewController.h
//  赛飞奇电力
//
//  Created by 刘毅 on 16/6/6.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "BaseViewController.h"

#import "AlarmDetailController.h"

#import "WarmCell.h"

@interface AlarmViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{

    UISearchBar *_searchView;

    UITableView *_warmTable;
    
    NSMutableArray *_warmArr;
    
    NSString *_searchString;
}

@end
