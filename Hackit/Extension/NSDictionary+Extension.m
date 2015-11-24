//
//  NSDictionary+Extension.m
//  FlyFish
//
//  Created by cyan on 15/9/10.
//  Copyright (c) 2015年 WDK. All rights reserved.
//

#import "NSDictionary+Extension.h"

#import <objc/runtime.h>

@implementation NSDictionary (Extension)

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(description)), class_getInstanceMethod(self, @selector(__description)));
}

- (NSString *)__description {
    NSString *desc = [self __description];
    desc = [NSString stringWithCString:[desc cStringUsingEncoding:NSUTF8StringEncoding]
                              encoding:NSNonLossyASCIIStringEncoding];
    return desc;
}

@end
