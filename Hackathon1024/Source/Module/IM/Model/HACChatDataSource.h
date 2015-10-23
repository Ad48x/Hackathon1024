//
//  HACChatDataSource.h
//  Hackathon1024
//
//  Created by cyan on 15/10/22.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACBaseDataSource.h"

@interface HACChatDataSource : HACBaseDataSource

- (CGFloat)cellHeightForText:(NSString *)text;
- (CGFloat)cellHeightForImage:(UIImage *)image;

@end
