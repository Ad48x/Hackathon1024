//
//  HACCacheManager.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACCacheManager.h"
#import "AppMacros.h"

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
        if (callback && object) {
            callback(object);
        }
    }];
}

@end
