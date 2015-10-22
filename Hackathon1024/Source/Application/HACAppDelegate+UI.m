//
//  HACAppDelegate+UI.m
//  Hackathon1024
//
//  Created by cyan on 15/10/22.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACAppDelegate+UI.h"

@implementation HACAppDelegate (UI)

- (void)setStyle {
    // StatusBar Style
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    // NavBar Hidden
    [[UINavigationBar appearance] setBarTintColor:HAC_Theme_Color];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
        NSForegroundColorAttributeName: HAC_Black_Color,
        NSFontAttributeName: MediumFont(17.0)
    }];
    // Table
    [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setTextColor:HAC_LightGray_Color];
}

@end
