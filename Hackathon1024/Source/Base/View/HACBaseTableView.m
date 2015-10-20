//
//  HACBaseTableView.m
//  Pin
//
//  Created by cyan on 15/9/7.
//  Copyright (c) 2015年 cyan. All rights reserved.
//

#import "HACBaseTableView.h"

@interface HACBaseTableView()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation HACBaseTableView

- (instancetype)init {
    if (self = [super init]) {
        [self setStyle];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self setStyle];
    }
    return self;
}

- (void)setStyle {
    self.backgroundColor = HAC_Theme_Color;
    self.separatorColor = HAC_LightGray_Color;
    self.tableFooterView = [UIView new];
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon"]];
    self.imageView.contentMode = UIViewContentModeCenter;
    self.tableHeaderView = self.imageView;
}

- (void)relayout {
    self.contentInset = UIEdgeInsetsMake(-self.imageView.height, 0, 0, 0);
}

@end
