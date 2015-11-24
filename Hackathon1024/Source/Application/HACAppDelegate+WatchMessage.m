//
//  HACAppDelegate+WatchMessage.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACAppDelegate+WatchMessage.h"

@implementation HACAppDelegate (WatchMessage)

- (void)handleMessageFromWatch:(NSDictionary *)message {
    Log(@"message from watch: %@", message);
    if ([message[@"cmd"] isEqualToString:@"push"]) {
        [HACPushCenter sendPush:SharedData().userInfo.JSONString toId:message[@"id"]];
    }
}

@end
