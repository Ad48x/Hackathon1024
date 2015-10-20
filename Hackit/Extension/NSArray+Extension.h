//
//  NSArray+Extension.h
//  FFBase
//
//  Created by cyan on 15/7/23.
//  Copyright (c) 2015年 justinjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)

- (NSArray *)reversedArray;

// 纯粹是为了代码简洁，原生方法太尼玛长了
- (void)foreach:(void (^)(id, NSUInteger, BOOL *))block;

@end
