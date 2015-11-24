//
//  HACChatDataSource.m
//  Hackathon1024
//
//  Created by cyan on 15/10/22.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACChatDataSource.h"
#import "HACMessageCell.h"

@implementation HACChatDataSource

- (instancetype)init {
    if (self = [super init]) {
        self.data = [@[@0, @1, @1, @0, @0, @1, @1, @0, @0, @1, @1, @0] mutableCopy];
    }
    return self;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 128;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"HACChatCell";
    HACMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HACMessageCell alloc] initWithReuseIdentifier:identifier];
    }
    cell.cellType = [self[indexPath] intValue];
    return cell;
}

- (CGFloat)cellHeightForText:(NSString *)text {
    return 0;
}

- (CGFloat)cellHeightForImage:(UIImage *)image {
    return 0;
}

@end
