//
//  HACIMUser.m
//  Hackathon1024
//
//  Created by cyan on 15/10/23.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACIMUser.h"

@implementation HACIMUser

+ (instancetype)currentUser {
    SINGLETON(^{
        return [[self alloc] init];
    });
}

- (instancetype)init {
    if (self = [super init]) {
        _clientId = @"562a011e60b280457801ca11";
    }
    
    return self;
}

NSString *MyClientId() {
    return [[HACIMUser currentUser] clientId];
}

@end
