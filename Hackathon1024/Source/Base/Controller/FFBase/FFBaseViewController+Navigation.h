//
//  FFBaseViewController+Navigation.h
//  FFBase
//
//  Created by cyan on 15/7/23.
//  Copyright (c) 2015年 justinjing. All rights reserved.
//  BaseVC 导航相关

#import "FFBaseViewController.h"

@interface FFBaseViewController (Navigation)

- (void)navigationBack;             // Navigation Pop一层
- (void)pushViewController:(UIViewController *)controller;

@end
