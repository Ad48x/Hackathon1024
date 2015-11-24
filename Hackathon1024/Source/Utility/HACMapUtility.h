//
//  HACMapUtility.h
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kHACMapApiKey = @"ebea681af092a3186410f4a4e4677100";

@interface HACMapUtility : NSObject

+ (CLLocationCoordinate2D)coordinateWithPOI:(AMapPOI *)poi;

@end
