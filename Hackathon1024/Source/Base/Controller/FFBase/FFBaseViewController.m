//
//  FFBaseViewController.m
//  FFBase
//
//  Created by cyan on 15/7/14.
//  Copyright (c) 2015年 justinjing. All rights reserved.
//

#import "FFBaseViewController.h"

@interface FFBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation FFBaseViewController

- (instancetype)initWithNavBarStyle:(FFNavBarStyle)style {
    if (self = [super init]) {
        if (style == FFNavBarStyleHidden) {
            self.shouldHiddenNavBar = YES;
        } else {
            self.shouldHiddenNavBar = NO;
        }
    }
    return self;
}

#pragma mark - Life Circle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.shouldHiddenNavBar) { // 把NavBar隐藏了
        [self hideNavBar];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.shouldHiddenNavBar) { // 恢复现场
        [self showNavBar];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark -

- (void)setupUI {
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
