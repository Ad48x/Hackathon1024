//
//  HACLoginCenter.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACLoginCenter.h"
#import "WXApi.h"
#import "WXApiObject.h"

@implementation HACLoginCenter

+ (instancetype)instance {
    SINGLETON(^{
        return [[self alloc] init];
    });
}

@end
