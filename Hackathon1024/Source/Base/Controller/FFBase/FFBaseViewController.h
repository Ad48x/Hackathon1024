//
//  FFBaseViewController.h
//  FFBase
//
//  Created by cyan on 15/7/14.
//  Copyright (c) 2015年 justinjing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FFNavBarStyle) {
    FFNavBarStyleDefault    = 0, // NavBar风格 默认显示
    FFNavBarStyleHidden
};

@interface FFBaseViewController : UIViewController

@property (nonatomic, assign) BOOL shouldHiddenNavBar; // 是否隐藏NavBar

- (instancetype)initWithNavBarStyle:(FFNavBarStyle)style;

- (void)setupUI;

@end
