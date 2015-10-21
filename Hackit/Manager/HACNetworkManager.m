//
//  HACNetworkManager.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACNetworkManager.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "AppMacros.h"

@implementation HACNetworkManager

+ (instancetype)manager {
    SINGLETON(^{
        return [[self alloc] init];
    });
}

- (NetworkStatus)networkStatus {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    NetworkStatus status = [reachability currentReachabilityStatus];
    return status;
}

- (void)handleNetworkResponse:(id)responseObject complete:(HACNetworkCallback)callback {
    __block NSDictionary *dict = @{};
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            dict = (NSDictionary *)responseObject;
        } else if ([responseObject isKindOfClass:[NSString class]]) {
            dict = [responseObject objectFromJSONString];
        } else if ([responseObject isKindOfClass:[NSData class]]) {
            NSString *resp = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            dict = [resp objectFromJSONString];
        }

        if (dict) {
            int retCode = [dict[@"ret"] intValue];
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(retCode, dict);
            });
        } else {
            Log(@"server err: %@", responseObject);
        }
    });
}

- (void)post:(NSString *)api params:(NSDictionary *)params complete:(HACNetworkCallback)callback {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    if (params == nil) {
        params = @{};
    }
    
    [manager POST:api
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              [self handleNetworkResponse:responseObject complete:callback];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              Log(@"network err: %@", error);
          }
     ];
}

- (void)get:(NSString *)api complete:(HACNetworkCallback)callback {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:api
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [self handleNetworkResponse:responseObject complete:callback];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             Log(@"network err: %@", error);
         }
     ];
}

@end
