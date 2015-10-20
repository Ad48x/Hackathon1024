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

@interface HACAppDelegate ()

@end

@implementation HACAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // MARK: init Window
    self.window = [[iConsoleWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[HACMainController alloc] init];
    [self.window makeKeyAndVisible];
    
    // MARK: Lean
    [[HACLeanManager manager] initSDK];
    // MARK: Push
    [HACPushCenter initWithOptions:launchOptions];
    // MARK: Share
    [[HACShareManager manager] initSDKs];
    // MARK: Debug
    [self initDebugEnv];
    
    [self bk_performBlock:^(id obj) {
        [HACPushCenter sendPush:@"HHH" channel:@"Cyan"];
    } afterDelay:3];
    
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

#pragma mark - Debug

- (void)initDebugEnv {
#if DEBUG
    // MARK: iConsole
    [iConsole sharedConsole].delegate = self;
    [iConsole sharedConsole].logSubmissionEmail = @"log.e@qq.com";
    // MARK: GT
    // GT_DEBUG_INIT;
    // MARK: FLEX
    // [[FLEXManager sharedManager] showExplorer];
#endif
}

#pragma mark - iConsole Delegate

- (void)handleConsoleCommand:(NSString *)command {
    Log(@"Command Received: %@", command);
}

@end
