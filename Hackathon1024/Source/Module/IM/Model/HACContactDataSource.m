//
//  HACContactDataSource.m
//  Hackathon1024
//
//  Created by cyan on 15/10/22.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACContactDataSource.h"
#import "HACContactCell.h"

@implementation HACContactDataSource

- (instancetype)init {
    if (self = [super init]) {
        self.data = [@[
            @{ @"name": @"StoneJin", @"id": @"562a011e60b280457801ca11", @"avatar": @"http://ac-qp5mlkuc.clouddn.com/33aed9fde6ed43ce.JPG" },
            @{ @"name": @"TY", @"id": @"5629e6cf60b25974b27f81be", @"avatar": @"http://ac-qp5mlkuc.clouddn.com/4f0707ac69a6cb70.JPG" },
            @{ @"name": @"Cyan", @"id": @"562a578760b20fc98136d5c0", @"avatar": @"http://ac-qp5mlkuc.clouddn.com/2e98a01867218239.jpeg" },
        ] mutableCopy];
    }
    
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"HACContactCell";
    HACContactCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HACContactCell alloc] initWithReuseIdentifier:identifier];
    }
    [cell renderCell:self[indexPath]];
    return cell;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44*1.5;
}

@end
