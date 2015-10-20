//
//  NSObject+Extension.h
//  Hackathon1024
//
//  Created by cyanzhong on 14/12/11.
//  Copyright (c) 2014年 FunCube. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^delayBlock) (void);
typedef void (^NotificationHandler) (NSNotification *notification);

@interface NSObject (Extension)

void delay(NSTimeInterval sec, delayBlock block);

- (void)performAfterDelay:(NSTimeInterval)delay withBlock:(delayBlock)block;

- (NSString *)properties;

- (void)registerNotification:(NSString *)name handler:(NotificationHandler)handler;
- (void)postNotification:(NSString *)name;
- (void)postNotification:(NSString *)name object:(id)object;
- (void)postNotification:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo;

@end
