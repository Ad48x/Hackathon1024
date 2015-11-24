//
//  ExtensionDelegate.m
//  WatchApp Extension
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "ExtensionDelegate.h"

@interface ExtensionDelegate()

@property (nonatomic, strong) MMWormhole *wormhole;
@property (nonatomic, strong) MMWormholeSession *listeningWormhole;

@end

@implementation ExtensionDelegate

- (void)applicationDidFinishLaunching {

    self.listeningWormhole = [MMWormholeSession sharedListeningSession];
    self.wormhole = [[MMWormhole alloc] initWithApplicationGroupIdentifier:kAppGroupsId
                                                         optionalDirectory:@"wormhole"
                                                            transitingType:MMWormholeTransitingTypeSessionContext];

    [self.listeningWormhole listenForMessageWithIdentifier:@"watch" listener:^(id messageObject) {
        NSLog(@"message from phone: %@", messageObject);
        [self postNotification:WATCH_NOTIFY object:messageObject];
    }];
    
    [self.listeningWormhole activateSessionListening];
    
    [self registerNotification:WATCH_SEND handler:^(NSNotification *notification) {
        [self sendMessageToPhone:notification.object];
    }];
}

- (void)sendMessageToPhone:(NSDictionary *)message {
    [self.wormhole passMessageObject:message identifier:@"phone"];
}

- (void)applicationDidBecomeActive {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillResignActive {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, etc.
}

@end
