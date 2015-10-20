//
//  HACAppDelegate.h
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#if DEBUG
#import "iConsole.h"
#import <GT/GT.h>
#import "FLEXManager.h"
#endif

@interface HACAppDelegate : UIResponder <UIApplicationDelegate, iConsoleDelegate>

@property (strong, nonatomic) iConsoleWindow *window;


@end

