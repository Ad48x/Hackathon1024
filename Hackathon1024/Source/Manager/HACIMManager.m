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

- (instancetype)init {
    if (self = [super init]) {
        [self openClient:MyClientId() callback:^(BOOL succeeded, NSError *error) {
            Log(@"open client (%d)", succeeded);
        }];
    }
    
    return self;
}

- (void)openClient:(NSString *)clientId callback:(AVIMBooleanResultBlock)callback {
    self.client = [[AVIMClient alloc] init];
    self.client.delegate = self;
    [self.client openWithClientId:clientId callback:^(BOOL succeeded, NSError *error) {
        if (callback) {
            callback(succeeded, error);
        }
    }];
}

- (void)queryUsers:(ArrayCallback)callback {
    AVQuery *query = [AVQuery queryWithClassName:@"IMUser"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        callback(objects);
    }];
}

// send message to a client id
- (void)sendMessage:(AVIMMessage *)message to:(NSString *)clientId callback:(AVIMBooleanResultBlock)callback {
    // check conversation
    HACCacheManager *cacheMgr = [HACCacheManager manager];
    [cacheMgr conversationIdForClientId:clientId complete:^(NSString *conversationId) {
        // has conversation
        if (conversationId.length > 0) {
            [[self.client conversationQuery] getConversationById:conversationId callback:^(AVIMConversation *conversation, NSError *error) {
                if (error) {
                    Log(@"query conversation error: %@", error);
                } else {
                    [conversation sendMessage:message callback:callback];
                }
            }];
        } else {
            // create a conversation
            NSString *conversationName = [NSString stringWithFormat:@"%@|%@", MyClientId(), clientId];
            [self.client createConversationWithName:conversationName clientIds:@[clientId] callback:^(AVIMConversation *conversation, NSError *error) {
                if (error) {
                    Log(@"create conversation error: %@", error);
                } else {
                    // save conversation
                    [cacheMgr setConversationId:conversation.conversationId forClientId:clientId];
                    // send message
                    [conversation sendMessage:message callback:callback];
                }
            }];
        }
    }];
}

- (void)sendText:(NSString *)text to:(NSString *)clientId callback:(AVIMBooleanResultBlock)callback {
    AVIMTextMessage *message = [AVIMTextMessage messageWithText:text attributes:nil];
    [self sendMessage:message to:clientId callback:callback];
}

#pragma mark - AVIM

- (void)conversation:(AVIMConversation *)conversation messageDelivered:(AVIMMessage *)message {
    Log(@"message delivered: %@", message.content);
}

- (void)conversation:(AVIMConversation *)conversation didReceiveCommonMessage:(AVIMMessage *)message {
    Log(@"text message received: %@", message.content);
}

- (void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message {
    Log(@"text message received: %@", message.text);
}

- (void)conversation:(AVIMConversation *)conversation didReceiveUnread:(NSInteger)unread {
    
}

- (void)alertMessageForDebug:(NSString *)message {
    // alert
    UIAlertView *alert = [UIAlertView bk_alertViewWithTitle:@"Message Received" message:message];
    [alert bk_addButtonWithTitle:@"OK" handler:^{
        // handle userInfo
    }];
    [alert show];
}

@end
