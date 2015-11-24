//
//  FFTableViewController.h
//  FFBase
//
//  Created by cyan on 15/7/24.
//  Copyright (c) 2015年 WDK. All rights reserved.
//  包含UITableView的基类 可以做上下拉刷新等

#import "FFDataRefreshController.h"
#import "HACBaseTableView.h"

@interface FFTableViewController : FFDataRefreshController<UITableViewDelegate>

@property (nonatomic, strong) HACBaseTableView *tableView;
@property (nonatomic, strong) HACBaseDataSource *dataSource;

- (void)initTableWithFrame:(CGRect)frame;   // 初始化UITableView

- (void)initTableWithFrame:(CGRect)frame refreshType:(FFDataRefreshMask)mask; // 刷新类型

- (void)initTableWithFrame:(CGRect)frame style:(UITableViewStyle)style refreshType:(FFDataRefreshMask)mask; // 刷新类型

@end
