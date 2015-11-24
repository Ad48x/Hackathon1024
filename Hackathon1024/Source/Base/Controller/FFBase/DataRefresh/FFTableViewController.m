//
//  FFTableViewController.m
//  FFBase
//
//  Created by cyan on 15/7/24.
//  Copyright (c) 2015年 WDK. All rights reserved.
//

#import "FFTableViewController.h"

@interface FFTableViewController ()

@end

@implementation FFTableViewController

- (void)dealloc {
    _tableView.delegate = nil;
}

- (void)initTableWithFrame:(CGRect)frame {
    // 默认上下拉都有 Plain类型
    [self initTableWithFrame:frame style:UITableViewStylePlain refreshType:FFDataRefreshMaskAll];
}

- (void)initTableWithFrame:(CGRect)frame refreshType:(FFDataRefreshMask)mask {
    // 默认Plain类型
    [self initTableWithFrame:frame style:UITableViewStylePlain refreshType:mask];
}

- (void)initTableWithFrame:(CGRect)frame style:(UITableViewStyle)style refreshType:(FFDataRefreshMask)mask {
    self.tableView = [[HACBaseTableView alloc] initWithFrame:frame style:style];
    self.tableView.delegate = self;
    
    if (mask & FFDataRefreshMaskHeader) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(didBeginRefreshData)];
        header.stateLabel.textColor = [UIColor asbestosColor];
        header.lastUpdatedTimeLabel.textColor = [UIColor asbestosColor];
        self.tableView.header = header;
    }
    
    if (mask & FFDataRefreshMaskFooter) {
        self.tableView.footer = ({
            MJRefreshAutoFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(didBeginLoadMoreData)];
            footer.automaticallyRefresh = NO;
            footer;
        });
    }
    
    self.baseScrollView = self.tableView;
    [self.view addSubview:self.tableView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.tableView relayout];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource heightForRowAtIndexPath:indexPath];
}

@end
