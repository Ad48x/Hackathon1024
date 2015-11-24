//
//  HACTabController.m
//  Hackathon1024
//
//  Created by cyan on 15/10/22.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACTabController.h"
#import "HACConversationsController.h"
#import "HACContactController.h"
#import "HACPlanController.h"
#import "HACSettingController.h"
#import "HACNavController.h"

@interface HACTabController ()

@end

@implementation HACTabController

- (instancetype)init {
    if (self = [super init]) {
        id poi = [self navWithClass:[HACPlanController class]];
        id contacts = [self navWithClass:[HACContactController class]];
        id discovery = [self navWithClass:[HACConversationsController class]];
        id setting = [self navWithClass:[HACSettingController class]];
        self.viewControllers = @[ poi, contacts, discovery, setting];
        
        // 构建tabBar items
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor alizarinColor]} forState:UIControlStateSelected];
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
        NSArray *titles = @[ @"行程", @"好友", @"发现", @"设置" ];
        NSArray *icons = @[ @"plan", @"contact", @"discovery", @"setting" ];
        NSArray *items = self.tabBar.items;
        for (int i=0; i<items.count; ++i) {
            UITabBarItem *tabBarItem = items[i];
            tabBarItem.title = titles[i];
            
            NSString *iconName = icons[i];
            NSString *selName = [iconName stringByAppendingString:@"_sel"];
            
            UIImage *iconImage = [[UIImage imageNamed:iconName] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];;
            UIImage *selImage = [[UIImage imageNamed:selName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            tabBarItem.image = iconImage;
            [tabBarItem setSelectedImage:selImage];
        }
    }
    return self;
}

- (HACNavController *)navWithClass:(Class)clz {
    UIViewController *controller = [[clz alloc] init];
    HACNavController *nav = [[HACNavController alloc] initWithRootViewController:controller];
    return nav;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
