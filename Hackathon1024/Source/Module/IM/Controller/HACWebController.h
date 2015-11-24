//
//  HACWebController.h
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACBaseController.h"

@interface HACWebController : HACBaseController

@property (nonatomic, copy) NSString *clientId;

- (instancetype)initWithClientId:(NSString *)clientId;

@end
