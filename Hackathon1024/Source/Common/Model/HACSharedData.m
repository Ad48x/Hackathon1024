//
//  HACSharedData.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACSharedData.h"

@implementation HACSharedData

HACSharedData *SharedData() {
    return [HACSharedData instance];
}

+ (instancetype)instance {
    SINGLETON(^{
        return [[self alloc] init];
    });
}

- (instancetype)init {
    if (self = [super init]) {
        _userInfo = [NSMutableDictionary dictionary];
        _userInfo[@"userID"] = [[HACIMUser currentUser] clientId];
        _tags = [NSMutableSet set];
    }
    
    return self;
}

- (void)translateTags {
    self.userInfo[@"tags"] = [self.tags allObjects];
    [self.userInfo removeObjectForKey:@"start_poi"];
}

@end
