//
//  FFBaseViewController+Navigation.m
//  FFBase
//
//  Created by cyan on 15/7/23.
//  Copyright (c) 2015年 justinjing. All rights reserved.
//

#import "FFBaseViewController+Navigation.h"

@implementation FFBaseViewController (Navigation)

- (void)navigationBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pushViewController:(UIViewController *)controller {
    // 目前这样，之后可能会有重用逻辑
    [self.navigationController pushViewController:controller animated:YES];
}

@end
