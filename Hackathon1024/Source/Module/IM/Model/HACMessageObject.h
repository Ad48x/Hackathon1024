//
//  HACMessageObject.h
//  Hackathon1024
//
//  Created by cyan on 15/10/23.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACSerializableObject.h"

typedef NS_ENUM(NSUInteger, HACMessageType) {
    HACMessageTypeText          = 0,
    HACMessageTypeImage,
};

@interface HACMessageObject : HACSerializableObject

@property (nonatomic, assign) HACMessageType messageType;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *imageUrl;

@end
