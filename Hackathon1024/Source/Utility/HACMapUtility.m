//
//  HACMapUtility.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACMapUtility.h"

@implementation HACMapUtility

+ (CLLocationCoordinate2D)coordinateWithPOI:(AMapPOI *)poi {
    return CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude);
}

@end
