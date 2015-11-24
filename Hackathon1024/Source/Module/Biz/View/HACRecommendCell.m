//
//  HACRecommendCell.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACRecommendCell.h"

@interface HACRecommendCell()

@property (nonatomic, strong) HACFlatButton *button;

@end

@implementation HACRecommendCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = RegularFont(18);
        
        _button = [[HACFlatButton alloc] init];
        _button.title = @"打招呼";
        _button.titleLabel.font = LightFont(13);
        [self.contentView addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(64);
            make.top.equalTo(18);
            make.bottom.equalTo(-18);
            make.right.equalTo(-18);
        }];
        
        @weakify(self);
        [_button bk_addEventHandler:^(id sender) {
            @strongify(self)
            [self sendRequest];
            [PINToast showMessage:@"消息已发送"];
            [self postNotification:DELETE_CELL object:self.indexPath];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)sendRequest {
    [HACPushCenter sendPush:SharedData().userInfo.JSONString toId:self.userInfo[@"id"]];
}

- (void)renderCell:(id)data {
    if (![data isKindOfClass:[NSDictionary class]]) {
        return ;
    }
    NSDictionary *dict = (NSDictionary *)data;
    self.nameLabel.text = dict[@"name"];
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:dict[@"touxiang"]?:@""]];
}

@end
