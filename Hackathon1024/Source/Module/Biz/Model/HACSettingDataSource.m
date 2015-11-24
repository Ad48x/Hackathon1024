//
//  HACSettingDataSource.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACSettingDataSource.h"

@interface HACSettingDataSource()

@property (nonatomic, strong) NSArray *titles;

@end

@implementation HACSettingDataSource

- (instancetype)init {
    if (self = [super init]) {
        _titles = @[
            @"账号",
            @"消息",
            @"其他"
        ];
        self.data = [@[
            @[ @"查看账号", @"退出登录" ],
            @[ @"新消息通知", @"查看系统消息" ],
            @[ @"关于我们", @"App Store 评分", @"分享给好友" ]
        ] mutableCopy];
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.titles[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"HACSettingCell";
    HACBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HACBaseTableViewCell alloc] initWithReuseIdentifier:identifier];
    }
    cell.textLabel.text = self.data[indexPath.section][indexPath.row];
    return cell;
}

@end
