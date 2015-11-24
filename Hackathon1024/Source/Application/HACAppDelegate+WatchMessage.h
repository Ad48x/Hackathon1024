//
//  HACAppDelegate+WatchMessage.h
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACAppDelegate.h"

@interface HACAppDelegate (WatchMessage)

- (void)handleMessageFromWatch:(NSDictionary *)message;

@end
