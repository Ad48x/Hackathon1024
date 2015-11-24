//
//  WKInterfaceController+Extension.h
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import <WatchKit/WatchKit.h>

typedef void (^WKMessageCallback)(NSDictionary *message);
typedef void (^WKIMCallback)(BOOL succeeded, NSError *error);

@interface WKInterfaceController (Extension)

void SendMessageToPhone(NSDictionary *message);

- (void)sendMessageToPhone:(NSDictionary *)message;

- (void)alertText:(NSString *)text;

- (void)didReceiveMessage:(WKMessageCallback)callback;

- (void)sendText:(NSString *)text to:(NSString *)clientId callback:(WKIMCallback)callback;

@end
