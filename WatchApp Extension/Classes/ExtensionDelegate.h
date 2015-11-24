//
//  ExtensionDelegate.h
//  WatchApp Extension
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import <WatchKit/WatchKit.h>

@interface ExtensionDelegate : NSObject <WKExtensionDelegate>

- (void)sendMessageToPhone:(NSDictionary *)message;

@end
