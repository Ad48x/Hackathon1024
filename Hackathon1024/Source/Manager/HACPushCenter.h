//
//  HACPushCenter.h
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HACLeanUtility.h"

@interface HACPushCenter : NSObject

+ (void)initWithOptions:(NSDictionary *)options;

+ (void)registerToken:(NSData *)token;

+ (void)handleRemoteNotification:(NSDictionary *)userInfo;

+ (void)clearBadge;

+ (void)addChannel:(NSString *)channel;
+ (void)removeChannel:(NSString *)channel;

+ (void)sendPush:(NSString *)message toId:(NSString *)clientId;
+ (void)sendPush:(NSString *)message channel:(NSString *)channel;
+ (void)sendPush:(NSString *)message channels:(NSArray *)channels;

@end
