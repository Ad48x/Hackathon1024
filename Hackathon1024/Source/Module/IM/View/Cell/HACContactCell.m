//
//  HACContactCell.m
//  Hackathon1024
//
//  Created by cyan on 15/10/25.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACContactCell.h"

@interface HACContactCell()

@end

@implementation HACContactCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        _avatarView.clipsToBounds = YES;
        _avatarView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarView.layer.cornerRadius = _avatarView.height/2;
        _avatarView.backgroundColor = HAC_LightGray_Color;
        [self.contentView addSubview:_avatarView];
        [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(_avatarView.size);
            make.left.equalTo(self.contentView).offset(20);
            make.centerY.equalTo(self.contentView);
        }];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = RegularFont(18);
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_avatarView.mas_right).offset(20);
            make.top.bottom.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)renderCell:(id)data {
    if (![data isKindOfClass:[NSDictionary class]]) {
        return ;
    }
    NSDictionary *dict = (NSDictionary *)data;
    self.nameLabel.text = dict[@"name"];
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:dict[@"avatar"]?:@""]];
}

@end
