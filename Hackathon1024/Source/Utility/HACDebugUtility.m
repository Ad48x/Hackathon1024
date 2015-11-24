//
//  HACDebugUtility.m
//  Hackathon1024
//
//  Created by cyan on 15/10/21.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACDebugUtility.h"
#import "HACLeanUtility.h"

@implementation HACDebugUtility

+ (void)initDebugEnv {
#if DEBUG
    // MARK: iConsole
//    [iConsole sharedConsole].delegate = [[HACAppDelegate instance] window];
//    [iConsole sharedConsole].logSubmissionEmail = @"log.e@qq.com";
    // MARK: GT
    // GT_DEBUG_INIT;
    // MARK: FLEX
    // [[FLEXManager sharedManager] showExplorer];
    // [HACDebugUtility runTestCases];
#endif
}

+ (void)runTestCases {
    HACLeanUtility *lean = [[HACLeanUtility alloc] init];
    [lean runTestCases];
}

@end
