//
//  NSArray+Extension.m
//  FFBase
//
//  Created by cyan on 15/7/23.
//  Copyright (c) 2015年 justinjing. All rights reserved.
//

#import "NSArray+Extension.h"

#import <objc/runtime.h>

@implementation NSArray (Extension)

- (NSArray *)reversedArray {
    return [[self reverseObjectEnumerator] allObjects];
}

- (void)foreach:(void (^)(id, NSUInteger, BOOL *))block {
    [self enumerateObjectsUsingBlock:block];
}

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
