//
//  HACAppDelegate.h
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HACWindow.h"

@interface HACAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) HACWindow *window;

+ (instancetype)instance;

@end

