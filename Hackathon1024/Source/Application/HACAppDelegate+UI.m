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
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // NavBar
    [[UINavigationBar appearance] setTintColor:HAC_LightGray_Color];
    [[UINavigationBar appearance] setBarTintColor:[UIColor midnightBlueColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
        NSForegroundColorAttributeName: HAC_White_Color,
        NSFontAttributeName: LightFont(17.0)
    }];
    // Table
    [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setTextColor:HAC_DarkGray_Color];
    // Tab
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor midnightBlueColor]];
}

@end
