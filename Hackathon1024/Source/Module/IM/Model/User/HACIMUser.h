//
//  HACIMUser.h
//  Hackathon1024
//
//  Created by cyan on 15/10/23.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HACIMUser : NSObject

@property (nonatomic, copy) NSString *clientId;

+ (instancetype)currentUser;

NSString *MyClientId();

@end
