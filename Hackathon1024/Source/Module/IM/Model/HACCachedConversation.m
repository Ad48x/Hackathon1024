//
//  HACCachedConversation.m
//  Hackathon1024
//
//  Created by cyan on 15/10/23.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACCachedConversation.h"

@implementation HACCachedConversation

- (NSString *)displayName {
    if (!_displayName) {
        NSArray *comps = [self.conversationName componentsSeparatedByString:@"|"];
        _displayName = comps.lastObject;
        
    }
    return _displayName;
}

@end
