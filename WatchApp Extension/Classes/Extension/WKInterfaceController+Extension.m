//
//  WKInterfaceController+Extension.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "WKInterfaceController+Extension.h"

@implementation WKInterfaceController (Extension)

void SendMessageToPhone(NSDictionary *message) {
    [[NSNotificationCenter defaultCenter] postNotificationName:WATCH_SEND object:message];
}

- (void)sendMessageToPhone:(NSDictionary *)message {
    [self postNotification:WATCH_SEND object:message];
}

- (void)alertText:(NSString *)text {
    WKAlertAction *alert = [WKAlertAction actionWithTitle:@"OK" style:WKAlertActionStyleCancel handler:^{
    }];
    [self presentAlertControllerWithTitle:@"Message" message:text preferredStyle:WKAlertControllerStyleAlert actions:@[alert]];
}

- (void)didReceiveMessage:(WKMessageCallback)callback {
    [self registerNotification:WATCH_NOTIFY handler:^(NSNotification *notification) {
        callback(notification.object);
    }];
}

- (void)sendText:(NSString *)text to:(NSString *)clientId callback:(WKIMCallback)callback {
    
}

@end
