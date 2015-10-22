//
//  HACChatDataSource.m
//  Hackathon1024
//
//  Created by cyan on 15/10/22.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACChatDataSource.h"

@implementation HACChatDataSource

- (instancetype)init {
    if (self = [super init]) {
        self.data = [@[@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,] mutableCopy];
    }
    return self;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"HACChatCell";
    HACBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HACBaseTableViewCell alloc] initWithReuseIdentifier:identifier];
    }
    cell.textLabel.text = [@(indexPath.row) stringValue];
    return cell;
}


@end
