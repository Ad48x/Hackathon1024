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
#import "HACTabController.h"
#import "HACAppDelegate+UI.h"
#import "HACAppDelegate+WatchMessage.h"

@interface HACAppDelegate ()

@property (nonatomic, strong) MMWormhole *watchConnectivityWormhole;
@property (nonatomic, strong) MMWormholeSession *watchConnectivityListeningWormhole;
@property (nonatomic, strong) HACTabController *tabController;

@end

@implementation HACAppDelegate

+ (instancetype)instance {
    return (HACAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // MARK: Lean
    [[HACLeanManager manager] initSDK];
    // MARK: Push
    [HACPushCenter initWithOptions:launchOptions];
    // MARK: Share
    [[HACShareManager manager] initSDKs];
    // MARK: Debug
    [HACDebugUtility initDebugEnv];
    
    // MARK: init Window
    self.tabController = [[HACTabController alloc] init];
    self.window = [[HACWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.tabController;
    [self.window makeKeyAndVisible];
    
    // MARK: Style
    [self setStyle];
    
    // MARK: MMWormhole
    [self initMMWormhole];
    
    self.webController = [[HACWebController alloc] initWithClientId:@"5629e6cf60b25974b27f81be"];
    
    return YES;
}

- (void)initMMWormhole {
    self.watchConnectivityListeningWormhole = [MMWormholeSession sharedListeningSession];
    self.watchConnectivityWormhole = [[MMWormhole alloc] initWithApplicationGroupIdentifier:kAppGroupId
                                                                          optionalDirectory:@"wormhole"
                                                                             transitingType:MMWormholeTransitingTypeSessionContext];
    [self.watchConnectivityListeningWormhole listenForMessageWithIdentifier:@"phone" listener:^(id messageObject) {
        [self handleMessageFromWatch:messageObject];
    }];
    
    [self.watchConnectivityListeningWormhole activateSessionListening];
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

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [HACPushCenter handleRemoteNotification:userInfo];
}

void SendMessageToWatch(NSDictionary *message) {
    [[HACAppDelegate instance] sendMessageToWatch:message];
}

- (void)sendMessageToWatch:(NSDictionary *)message {
    [self.watchConnectivityWormhole passMessageObject:message identifier:@"watch"];
}

- (void)switchTabToIndex:(int)index {
    self.tabController.selectedIndex = index;
}

@end
