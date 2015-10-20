//
//  NSObject+Extension.m
//  Hackathon1024
//
//  Created by cyanzhong on 14/12/11.
//  Copyright (c) 2014年 FunCube. All rights reserved.
//

#import "NSObject+Extension.h"
#import "FXNotifications.h"
#import <objc/runtime.h>

@implementation NSObject (Extension)

void delay(NSTimeInterval sec, delayBlock block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(sec * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (block) {
            block();
        }
    });
}

- (void)performAfterDelay:(NSTimeInterval)delay withBlock:(delayBlock)block {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (block) {
            block();
        }
    });
}

- (NSString *)properties {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    Class cls = [self class];
    uint ivarsCount = 0;
    Ivar *ivars = class_copyIvarList(cls, &ivarsCount);
    const Ivar *ivarsEnd = ivars + ivarsCount;
    for (const Ivar *ivarsBegin = ivars; ivarsBegin < ivarsEnd; ivarsBegin++) {
        Ivar const ivar = *ivarsBegin;
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        if ([key hasPrefix:@"_"]) {
            key = [key substringFromIndex:1];
        }
        id value = [self valueForKey:key];
        [dictionary setObject:value ?: [NSNull null]
                       forKey:key];
    }
    
    if (ivars) {
        free(ivars);
    }
    
    return dictionary.description;
}

- (void)registerNotification:(NSString *)name handler:(NotificationHandler)handler {
    [[NSNotificationCenter defaultCenter] addObserverForName:name object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        if (handler && note) {
            handler(note);
        }
    }];
}

- (void)postNotification:(NSString *)name {
    [self postNotification:name object:nil userInfo:nil];
}

- (void)postNotification:(NSString *)name object:(id)object {
    [self postNotification:name object:object userInfo:nil];
}

- (void)postNotification:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object userInfo:userInfo];
}

@end
