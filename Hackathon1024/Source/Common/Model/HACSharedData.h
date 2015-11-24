//
//  HACSharedData.h
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HACSharedData : NSObject

@property (nonatomic, strong) NSMutableDictionary *userInfo;
@property (nonatomic, strong) NSMutableSet *tags;
@property (nonatomic, assign) BOOL showRecommend;
@property (nonatomic, strong) NSDictionary *recommendData;

HACSharedData *SharedData();

+ (instancetype)instance;

- (void)translateTags;

@end
