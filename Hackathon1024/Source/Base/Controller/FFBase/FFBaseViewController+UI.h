//
//  FFBaseViewController+UI.h
//  FFBase
//
//  Created by cyan on 15/7/23.
//  Copyright (c) 2015年 justinjing. All rights reserved.
//  BaseVC UI相关

#import "FFBaseViewController.h"

@interface FFBaseViewController (UI)<UIGestureRecognizerDelegate>

- (void)hideNavBar;                 // 隐藏navBar
- (void)hideNavBar:(BOOL)animated;
- (void)showNavBar;                 // 显示navBar
- (void)showNavBar:(BOOL)animated;

- (void)enableSwipeBackGesture;     // 允许滑动返回
- (void)disableSwipeBackGesture;    // 不允许滑动返回

- (void)clearExtendedLayoutEdges;   // 清除边距
- (void)setExtendedLayoutEdges:(UIRectEdge)layout; // 设置边距样式
- (void)setExtendedLayoutEdgesToAll;

- (void)setLeftBarButtonWithTitle:(NSString *)title action:(void (^)(id sender))handler;
- (void)setRightBarButtonWithTitle:(NSString *)title action:(void (^)(id sender))handler;

- (void)disableRightBarButton;

- (void)showToast:(NSString *)toast;
- (void)showToast:(NSString *)toast duration:(NSTimeInterval)duration;
- (void)showToast:(NSString *)toast duration:(NSTimeInterval)duration position:(id)position;
- (void)showLoadingIndicator;
- (void)hideLoadingIndicator;

@end
