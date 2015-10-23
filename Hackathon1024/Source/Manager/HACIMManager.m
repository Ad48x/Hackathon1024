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
@property (nonatomic, strong) NSMutableDictionary *conversationPool;

@end

@implementation HACIMManager

+ (instancetype)manager {
    SINGLETON(^{
        return [[self alloc] init];
    });
}

- (instancetype)init {
    if (self = [super init]) {
        
        _conversationPool = [NSMutableDictionary dictionary];
        
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

// create a conversation and send mesage
- (void)createConversationTo:(NSString *)clientId sendMessage:(AVIMMessage *)message callback:(AVIMBooleanResultBlock)callback {
    NSString *conversationName = [NSString stringWithFormat:@"%@|%@", MyClientId(), clientId];
    [self.client createConversationWithName:conversationName clientIds:@[clientId] callback:^(AVIMConversation *conversation, NSError *error) {
        if (error) {
            Log(@"create conversation error: %@", error);
        } else {
            // send message
            [self sendMessage:message conversation:conversation callback:callback];
        }
    }];
}

// send message to a client id
- (void)sendMessage:(AVIMMessage *)message to:(NSString *)clientId callback:(AVIMBooleanResultBlock)callback {
    // check conversation
    // from pool
    HACCacheManager *cacheMgr = [HACCacheManager manager];
    NSString *conversationName = [NSString stringWithFormat:@"%@|%@", MyClientId(), clientId];
    [cacheMgr conversationIdForName:conversationName complete:^(NSString *conversationId) {
        // has conversation
        if (conversationId.length > 0) {
            // get from pool
            AVIMConversation *poolConversation = self.conversationPool[conversationId];
            if (poolConversation) {
                [self sendMessage:message conversation:poolConversation callback:callback];
            } else {
                // get from LeanCloud
                [[self.client conversationQuery] getConversationById:conversationId callback:^(AVIMConversation *conversation, NSError *error) {
                    if (error) {
                        Log(@"query conversation error: %@", error);
                        // create a conversation
                        [self createConversationTo:clientId sendMessage:message callback:callback];
                    } else {
                        [self sendMessage:message conversation:conversation callback:callback];
                    }
                }];
            }
        } else {
            // create a conversation
            [self createConversationTo:clientId sendMessage:message callback:callback];
        }
    }];
}

- (void)sendText:(NSString *)text to:(NSString *)clientId callback:(AVIMBooleanResultBlock)callback {
    AVIMTextMessage *message = [AVIMTextMessage messageWithText:text attributes:nil];
    [self sendMessage:message to:clientId callback:callback];
}

- (void)sendText:(NSString *)text conversation:(AVIMConversation *)conversation callback:(AVIMBooleanResultBlock)callback {
    AVIMTextMessage *message = [AVIMTextMessage messageWithText:text attributes:nil];
    [self sendMessage:message conversation:conversation callback:callback];
}

- (void)sendMessage:(AVIMMessage *)message conversation:(AVIMConversation *)conversation callback:(AVIMBooleanResultBlock)callback {
    // save conversation
    [self saveConversation:conversation];
    // send
    [conversation sendMessage:message callback:callback];
}

#pragma mark - AVIM

- (void)conversation:(AVIMConversation *)conversation messageDelivered:(AVIMMessage *)message {
    Log(@"message delivered: %@", message.content);
}

- (void)conversation:(AVIMConversation *)conversation didReceiveCommonMessage:(AVIMMessage *)message {
    Log(@"text message received: %@", message.content);
    [self saveConversation:conversation];
}

- (void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message {
    Log(@"text message received: %@", message.text);
    [self saveConversation:conversation];
}

- (void)conversation:(AVIMConversation *)conversation didReceiveUnread:(NSInteger)unread {
    
}

- (void)saveConversation:(AVIMConversation *)conversation {
    // set to pool
    self.conversationPool[conversation.conversationId] = conversation;
    // save to cache
    [[HACCacheManager manager] setConversationId:conversation.conversationId forName:conversation.name];
}

#pragma mark - Debug

- (void)alertMessageForDebug:(NSString *)message {
    // alert
    UIAlertView *alert = [UIAlertView bk_alertViewWithTitle:@"Message Received" message:message];
    [alert bk_addButtonWithTitle:@"OK" handler:^{
        // handle userInfo
    }];
    [alert show];
}

@end
