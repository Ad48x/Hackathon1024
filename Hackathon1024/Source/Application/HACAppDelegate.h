//
//  HACAppDelegate.h
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HACWindow.h"
#import "HACWebController.h"

@interface HACAppDelegate : UIResponder <UIApplicationDelegate>

void SendMessageToWatch(NSDictionary *message);

@property (strong, nonatomic) HACWindow *window;
@property (nonatomic, strong) HACWebController *webController;

+ (instancetype)instance;

- (void)sendMessageToWatch:(NSDictionary *)message;

- (void)switchTabToIndex:(int)index;

@end

