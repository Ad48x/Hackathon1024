//
//  FFDataRefreshController.m
//  FFBase
//
//  Created by cyan on 15/7/24.
//  Copyright (c) 2015年 WDK. All rights reserved.
//

#import "FFDataRefreshController.h"

@interface FFDataRefreshController ()

@end

@implementation FFDataRefreshController

- (instancetype)init {
    if (self = [super init]) {
        _refreshTimeout = 10;
    }
    return self;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self finishRefreshData];
    [self finishLoadMoreData];
}

- (void)finishRefreshDataAfterDelay:(NSTimeInterval)delay {
    [self performSelector:@selector(finishRefreshData) withObject:nil afterDelay:delay];
}

- (void)finishLoadMoreDataAfterDelay:(NSTimeInterval)delay {
    [self performSelector:@selector(finishLoadMoreData) withObject:nil afterDelay:delay];
}

- (void)beginRefreshData {
    [self.baseScrollView.header beginRefreshing];
}

- (void)finishRefreshData {
    [self.baseScrollView.header endRefreshing];
    [self didFinishRefreshData];
}

- (void)finishRefreshDataWhenTimeout {
    [self finishRefreshDataAfterDelay:self.refreshTimeout];
}

- (void)beginLoadMoreData {
    [self.baseScrollView.footer beginRefreshing];
}

- (void)finishLoadMoreData {
    [self.baseScrollView.footer endRefreshing];
    [self didFinishLoadMoreData];
}

- (void)finishLoadMoreDataWhenTimeout {
    [self finishLoadMoreDataAfterDelay:self.refreshTimeout];
}

#pragma mark - 由子类实现
-(void)didBeginRefreshData{}
-(void)didFinishRefreshData{}
-(void)didBeginLoadMoreData{}
-(void)didFinishLoadMoreData{}

@end
