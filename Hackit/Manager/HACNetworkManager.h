//
//  HACNetworkManager.h
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "HACNetworkApi.h"

typedef NS_ENUM(NSInteger, HACNetworkRetCode) {
    HACNetworkRetCodeFailed      = -1,
    HACNetworkRetCodeSuccess     = 0,
};

typedef void (^HACNetworkCallback)(HACNetworkRetCode code, NSDictionary *resp);

@interface HACNetworkManager : NSObject

+ (instancetype)manager;

- (NetworkStatus)networkStatus;

- (void)post:(NSString *)api params:(NSDictionary *)params complete:(HACNetworkCallback)callback;
- (void)get:(NSString *)api complete:(HACNetworkCallback)callback;

@end
