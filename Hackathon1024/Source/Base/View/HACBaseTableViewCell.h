//
//  HACBaseTableViewCell.h
//  Pin
//
//  Created by cyan on 15/9/7.
//  Copyright (c) 2015年 cyan. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat kHACDefaultCellHeight = 44.0;

@interface HACBaseTableViewCell : UITableViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier style:(UITableViewCellStyle)style;

- (void)renderCell:(id)data;

@end
