//
//  HACMessageCell.m
//  Hackathon1024
//
//  Created by cyan on 15/10/23.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACMessageCell.h"

static const CGFloat kHACMessageAvatarSize = 32;
static const CGFloat kHACMessageCellPadding = 10;

@interface HACMessageCell()

@property (nonatomic, strong) UIImageView *avatarView;

@end

@implementation HACMessageCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(kHACMessageCellPadding, kHACMessageCellPadding, kHACMessageCellPadding, kHACMessageCellPadding));
        }];
        
        _avatarView = [[UIImageView alloc] init];
        _avatarView.clipsToBounds = YES;
        _avatarView.backgroundColor = [UIColor blackColor];
        _avatarView.contentMode = UIViewContentModeScaleAspectFill;
        [_bgView addSubview:_avatarView];
        
        _messageView = [[UIView alloc] init];
        [_bgView addSubview:_messageView];
    }
    return self;
}

- (void)setCellType:(HACMessageCellType)cellType {
    _cellType = cellType;
    if (cellType == HACMessageCellTypeLeft) {
        [self.avatarView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(kHACMessageAvatarSize, kHACMessageAvatarSize));
            make.top.left.equalTo(0);
        }];
        self.messageView.backgroundColor = [UIColor redColor];
        [self.messageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(kHACMessageAvatarSize+kHACMessageCellPadding);
            make.top.bottom.right.equalTo(self.bgView);
        }];
    } else {
        [self.avatarView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(kHACMessageAvatarSize, kHACMessageAvatarSize));
            make.top.equalTo(0);
            make.right.equalTo(self.bgView);
        }];
        self.messageView.backgroundColor = [UIColor greenColor];
        [self.messageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView);
            make.right.equalTo(self.bgView).offset(-kHACMessageAvatarSize-kHACMessageCellPadding);
            make.top.bottom.equalTo(self.bgView);
        }];
    }
}

- (void)setUserAvatarWithUrl:(NSString *)imageUrl {
    
}

@end
