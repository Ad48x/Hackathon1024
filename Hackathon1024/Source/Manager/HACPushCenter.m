//
//  HACPushCenter.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACPushCenter.h"
#import <AVOSCloud/AVOSCloud.h>

@implementation HACPushCenter

+ (void)initWithOptions:(NSDictionary *)options {
    if (!SIMULATOR) {
        UIUserNotificationType types = (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types
                                                                                 categories:nil];
        UIApplication *application = [UIApplication sharedApplication];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }
}

+ (void)registerToken:(NSData *)token {
    Log(@"%@", [NSString stringWithFormat:@"Device Token: %@", token]);
    AVInstallation *currentInstallation = [AVInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:token];
    [currentInstallation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        Log(@"Push Config (%d)", succeeded);
    }];
}

+ (void)handleRemoteNotification:(NSDictionary *)userInfo {
    Log(@"Push Received: %@", userInfo);
    [AVAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
    
    // alert
//    UIAlertView *alert = [UIAlertView bk_alertViewWithTitle:@"Push Received" message:userInfo.description];
//    [alert bk_addButtonWithTitle:@"OK" handler:^{
//        // handle userInfo
//    }];
//    [alert show];
}

+ (void)clearBadge {
    UIApplication *application = [UIApplication sharedApplication];
    int num = (int)application.applicationIconBadgeNumber;
    if (num != 0) {
        AVInstallation *currentInstallation = [AVInstallation currentInstallation];
        [currentInstallation setBadge:0];
        [currentInstallation saveEventually];
        application.applicationIconBadgeNumber = 0;
    }
    [application cancelAllLocalNotifications];
}

+ (void)addChannel:(NSString *)channel {
    AVInstallation *currentInstallation = [AVInstallation currentInstallation];
    [currentInstallation addUniqueObject:channel forKey:kHACPushChannelKey];
    [currentInstallation saveInBackground];
}

+ (void)removeChannel:(NSString *)channel {
    AVInstallation *currentInstallation = [AVInstallation currentInstallation];
    [currentInstallation removeObject:channel forKey:kHACPushChannelKey];
    [currentInstallation saveInBackground];
}

+ (void)sendPush:(NSString *)message toId:(NSString *)clientId {
    AVPush *push = [[AVPush alloc] init];
    [push setMessage:message];
    [push sendPushInBackground];
}

+ (void)sendPush:(NSString *)message channel:(NSString *)channel {
    AVPush *push = [[AVPush alloc] init];
    [push setChannel:channel];
    [push setMessage:message];
    [push sendPushInBackground];
}

+ (void)sendPush:(NSString *)message channels:(NSArray *)channels {
    AVPush *push = [[AVPush alloc] init];
    [push setChannels:channels];
    [push setMessage:message];
    [push sendPushInBackground];
}

@end
