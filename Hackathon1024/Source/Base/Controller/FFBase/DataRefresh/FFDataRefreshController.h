//
//  FFDataRefreshController.h
//  FFBase
//
//  Created by cyan on 15/7/24.
//  Copyright (c) 2015年 WDK. All rights reserved.
//  基础的控制刷新的VC

#import "FFBaseViewController.h"
#import <MJRefresh/MJRefresh.h>

// 根据掩码来决定刷新的类型 不指定的情况下为All
typedef NS_OPTIONS(NSInteger, FFDataRefreshMask) {
    FFDataRefreshMaskNone   = 0,
    FFDataRefreshMaskHeader = 1 << 0, // 只有头部
    FFDataRefreshMaskFooter = 1 << 1, // 只有尾部
    FFDataRefreshMaskAll    = (FFDataRefreshMaskHeader | FFDataRefreshMaskFooter)
};

@interface FFDataRefreshController : FFBaseViewController

@property (nonatomic, strong) UIScrollView *baseScrollView;  // Scroll基类 可能指向Table或者Collection
@property (nonatomic, assign) NSTimeInterval refreshTimeout; // 刷新超时时间 默认10s

// For Header
- (void)didBeginRefreshData;                        // 下拉刷新开始
- (void)didFinishRefreshData;                       // 下拉刷新完成

- (void)beginRefreshData;                           // 主动开始刷新
- (void)finishRefreshData;                          // 主动停止下拉刷新
- (void)finishRefreshDataWhenTimeout;               // 超时的时候停止

// For Footer
- (void)didBeginLoadMoreData;                       // 上拉加载更多开始
- (void)didFinishLoadMoreData;                      // 上拉加载更多完成

- (void)beginLoadMoreData;                          // 主动上拉加载
- (void)finishLoadMoreData;                         // 主动停止上拉加载
- (void)finishLoadMoreDataWhenTimeout;              // 超时的时候停止

// 定时结束
- (void)finishRefreshDataAfterDelay:(NSTimeInterval)delay;
- (void)finishLoadMoreDataAfterDelay:(NSTimeInterval)delay;

@end
