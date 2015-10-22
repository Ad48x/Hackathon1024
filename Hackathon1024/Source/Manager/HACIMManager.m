//
//  HACIMManager.m
//  Hackathon1024
//
//  Created by cyan on 15/10/21.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACIMManager.h"

@interface HACIMManager()<AVIMClientDelegate>

@property (nonatomic, strong) AVIMClient *client;

@end

@implementation HACIMManager

+ (instancetype)manager {
    SINGLETON(^{
        return [[self alloc] init];
    });
}

- (void)openClient:(NSString *)clientId callback:(AVIMBooleanResultBlock)callback {
    self.client = [[AVIMClient alloc] init];
    self.client.delegate = self;
    [self.client openWithClientId:clientId callback:^(BOOL succeeded, NSError *error) {
        Log(@"open client: %d", succeeded);
        if (callback) {
            callback(succeeded, error);
        }
    }];
}

- (void)tomSendMessageToJerry {
    // Tom 创建了一个 client
    self.client = [[AVIMClient alloc] init];
    
    // Tom 用自己的名字作为 ClientId 打开 client
    [self.client openWithClientId:@"Tom" callback:^(BOOL succeeded, NSError *error) {
        // Tom 建立了与 Jerry 的会话
        [self.client createConversationWithName:@"猫和老鼠" clientIds:@[@"Jerry"] callback:^(AVIMConversation *conversation, NSError *error) {
            // Tom 发了一条消息给 Jerry
            [conversation sendMessage:[AVIMTextMessage messageWithText:@"耗子，起床！" attributes:nil] callback:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"发送成功！");
                }
            }];
        }];
    }];
}

- (void)jerryReceiveMessageFromTom {
    // Jerry 创建了一个 client
    self.client = [[AVIMClient alloc] init];
    
    // 设置 client 的 delegate，并实现 delegate 方法
    self.client.delegate = self;
    
    // Jerry 用自己的名字作为 ClientId 打开了 client
    [self.client openWithClientId:@"Jerry" callback:^(BOOL succeeded, NSError *error) {
        // ...
    }];
}

- (void)queryUsers:(ArrayCallback)callback {
    AVQuery *query = [AVQuery queryWithClassName:@"IMUser"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        callback(objects);
    }];
}

- (void)sendMessage:(AVIMMessage *)message to:(NSString *)clientId callback:(AVIMBooleanResultBlock)callback {
    [self.client createConversationWithName:clientId clientIds:@[clientId] callback:^(AVIMConversation *conversation, NSError *error) {
        if (!error) {
            [conversation sendMessage:message callback:^(BOOL succeeded, NSError *error) {
                if (callback) {
                    callback(succeeded, error);
                }
            }];
        }
    }];
}

- (void)sendText:(NSString *)text to:(NSString *)clientId {
    AVIMTextMessage *message = [AVIMTextMessage messageWithText:text attributes:nil];
    [self sendMessage:message to:clientId callback:^(BOOL succeeded, NSError *error) {
        
    }];
}

#pragma mark - AVIM

- (void)conversation:(AVIMConversation *)conversation messageDelivered:(AVIMMessage *)message {
    Log(@"message delivered: %@", message.content);
}

- (void)conversation:(AVIMConversation *)conversation didReceiveCommonMessage:(AVIMMessage *)message {
    
    Log(@"text message received: %@", message.content);
    // alert
    UIAlertView *alert = [UIAlertView bk_alertViewWithTitle:@"Message Received" message:message.content];
    [alert bk_addButtonWithTitle:@"OK" handler:^{
        // handle userInfo
    }];
    [alert show];
}

- (void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message {
    Log(@"text message received: %@", message.text);
    // alert
    UIAlertView *alert = [UIAlertView bk_alertViewWithTitle:@"Message Received" message:message.text];
    [alert bk_addButtonWithTitle:@"OK" handler:^{
        // handle userInfo
    }];
    [alert show];
}

- (void)conversation:(AVIMConversation *)conversation didReceiveUnread:(NSInteger)unread {
    
}

@end
