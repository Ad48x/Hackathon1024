//
// Created by Shaokang Zhao on 15/1/12.
// Copyright (c) 2015 Shaokang Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SKTag;
@interface SKTagButton : UIButton

@property (nonatomic, assign) BOOL checked;

+ (instancetype)buttonWithTag:(SKTag *)tag;
@end