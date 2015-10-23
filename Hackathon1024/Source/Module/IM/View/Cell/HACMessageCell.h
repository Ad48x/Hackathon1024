//
//  HACMessageCell.h
//  Hackathon1024
//
//  Created by cyan on 15/10/23.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACBaseTableViewCell.h"

typedef NS_ENUM(NSUInteger, HACMessageCellType) {
    HACMessageCellTypeLeft  = 0,
    HACMessageCellTypeRight
};

@interface HACMessageCell : HACBaseTableViewCell

@property (nonatomic, assign) HACMessageCellType cellType;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *messageView;

- (void)setUserAvatarWithUrl:(NSString *)imageUrl;

@end
