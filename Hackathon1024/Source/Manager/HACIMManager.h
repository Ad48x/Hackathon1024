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

- (void)tomSendMessageToJerry;
- (void)jerryReceiveMessageFromTom;

@end
