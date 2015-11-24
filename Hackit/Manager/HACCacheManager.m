//
//  HACCacheManager.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACCacheManager.h"
#import "AppMacros.h"

static NSString *const kHACStorageConverstaionIds = @"HAC.IM.Conversations";

@implementation HACCacheManager

+ (instancetype)manager {
    SINGLETON(^{
        return [[self alloc] init];
    });
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key {
    [[PINCache sharedCache] setObject:object forKey:key];
}

- (void)objectForKey:(NSString *)key complete:(HACCacheObjectCallback)callback {
    [[PINCache sharedCache] objectForKey:key block:^(PINCache *cache, NSString *key, id object) {
        if (callback) {
            callback(object);
        }
    }];
}

- (void)setConversationId:(NSString *)conversationId forName:(NSString *)name {
    HACCacheManager *mgr = [HACCacheManager manager];
    [mgr objectForKey:kHACStorageConverstaionIds complete:^(id object) {
        if (!object) {
            object = [@{ name: conversationId } mutableCopy];
        } else {
            object[name] = conversationId;
        }
        [mgr setObject:object forKey:kHACStorageConverstaionIds];
    }];
}

- (void)conversationIdForName:(NSString *)name complete:(HACCacheObjectCallback)callback {
    HACCacheManager *mgr = [HACCacheManager manager];
    [mgr objectForKey:kHACStorageConverstaionIds complete:^(id object) {
        if (object) {
            callback(object[name]);
        } else {
            callback(nil);
        }
    }];
}

- (void)queryConversations:(HACCacheObjectCallback)callback {
    [[HACCacheManager manager] objectForKey:kHACStorageConverstaionIds complete:^(id object) {
        if (object) {
            NSDictionary *dict = (NSDictionary *)object;
            NSMutableArray *array = [NSMutableArray array];
            [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                HACCachedConversation *conversation = [[HACCachedConversation alloc] init];
                conversation.conversationName = key;
                conversation.conversationId = obj;
                [array addObject:conversation];
            }];
            callback(array);
        } else {
            callback(@[]);
        }
    }];
}

- (void)setMessages:(NSArray<HACMessageObject *> *)messages forClientId:(NSString *)clientId {
    [[HACCacheManager manager] setObject:messages forKey:clientId];
}

- (void)messagesForClientId:(NSString *)clientId complete:(ArrayCallback)callback {
    [[HACCacheManager manager] objectForKey:clientId complete:^(id object) {
        if (object) {
            callback((NSArray *)object);
        } else {
            callback(@[]);
        }
    }];
}

@end
