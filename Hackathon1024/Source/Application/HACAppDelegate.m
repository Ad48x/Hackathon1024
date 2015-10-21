//
//  HACAppDelegate.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACAppDelegate.h"
#import "HACMainController.h"
#import "HACPushCenter.h"
#import "HACLeanManager.h"
#import "HACShareManager.h"
#import "HACDebugUtility.h"

@interface HACAppDelegate ()

@end

@implementation HACAppDelegate

+ (instancetype)instance {
    return (HACAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // MARK: init Window
    self.window = [[HACWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[HACMainController alloc] init];
    [self.window makeKeyAndVisible];
    
    // MARK: Lean
    [[HACLeanManager manager] initSDK];
    // MARK: Push
    [HACPushCenter initWithOptions:launchOptions];
    // MARK: Share
    [[HACShareManager manager] initSDKs];
    // MARK: Debug
    [HACDebugUtility initDebugEnv];
    
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [HACPushCenter clearBadge];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [HACPushCenter registerToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [HACPushCenter handleRemoteNotification:userInfo];
}

@end
