//
//  HACDebugUtility.h
//  Hackathon1024
//
//  Created by cyan on 15/10/21.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#if DEBUG
#import "iConsole.h"
#import <GT/GT.h>
#import "FLEXManager.h"
#endif

@interface HACDebugUtility : NSObject

+ (void)initDebugEnv;

@end
