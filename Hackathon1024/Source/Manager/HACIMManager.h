//
//  HACIMManager.h
//  Hackathon1024
//
//  Created by cyan on 15/10/21.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kHACIMDefaultConversation = @"Conversation";

@interface HACIMManager : NSObject

+ (instancetype)manager;

- (void)openClient:(NSString *)clientId callback:(AVIMBooleanResultBlock)callback;

- (void)tomSendMessageToJerry;
- (void)jerryReceiveMessageFromTom;

- (void)sendText:(NSString *)text to:(NSString *)clientId;

@end
