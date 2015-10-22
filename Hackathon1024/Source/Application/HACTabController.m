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

@interface HACTabController ()

@end

@implementation HACTabController

- (instancetype)init {
    if (self = [super init]) {
        id conversations = [self navWithClass:[HACConversationsController class]];
        id contacts = [self navWithClass:[HACContactController class]];
        self.viewControllers = @[ conversations, contacts ];
    }
    return self;
}

- (UINavigationController *)navWithClass:(Class)clz {
    UIViewController *controller = [[clz alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    return nav;
}

@end
