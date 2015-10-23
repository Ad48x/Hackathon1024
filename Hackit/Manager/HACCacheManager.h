//
//  HACCacheManager.h
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PINCache/PINCache.h>
#import "HACCachedConversation.h"
#import "HACMessageObject.h"
#import "AppMacros.h"

typedef void (^HACCacheObjectCallback)(id object);

@interface HACCacheManager : NSObject

+ (instancetype)manager;

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key;
- (void)objectForKey:(NSString *)key complete:(HACCacheObjectCallback)callback;

// conversation
- (void)setConversationId:(NSString *)conversationId forName:(NSString *)name;
- (void)conversationIdForName:(NSString *)name complete:(HACCacheObjectCallback)callback;
- (void)queryConversations:(HACCacheObjectCallback)callback;

// message
- (void)setMessages:(NSArray<HACMessageObject *> *)messages forClientId:(NSString *)clientId;
- (void)messagesForClientId:(NSString *)clientId complete:(ArrayCallback)callback;

@end
