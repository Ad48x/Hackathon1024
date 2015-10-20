//
//  HACLeanManager.m
//  Hackathon1024
//
//  Created by cyan on 15/10/20.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACLeanManager.h"

#if DEBUG
#define PRODUCATION_MODE    0
#else
#define PRODUCATION_MODE    1
#endif

@implementation HACLeanManager

+ (instancetype)manager {
    SINGLETON(^{
        return [[self alloc] init];
    });
}

- (void)initSDK {
    [AVOSCloud setApplicationId:kHACLeanAppId clientKey:kHACLeanAppKey];
    [AVPush setProductionMode:PRODUCATION_MODE];
}

@end
