//
//  HACNetworkApi.h
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#ifndef HACNetworkApi_h
#define HACNetworkApi_h

static NSString *const kHACApiConnectTest = @"http://api.geonames.org/timezoneJSON";
static NSString *const kHACApiServerIp = @"http://121.40.224.245/";

static inline NSString *API(NSString *name) {
    return [kHACApiServerIp stringByAppendingString:name];
};

#endif /* HACNetworkApi_h */
