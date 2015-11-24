//
//  HACRecommendDataSource.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACRecommendDataSource.h"

@implementation HACRecommendDataSource

- (instancetype)init {
    if (self = [super init]) {
//        self.data = [@[
//            @{ @"name": @"StoneJin", @"id": @"562a011e60b280457801ca11" },
//            @{ @"name": @"TY", @"id": @"5629e6cf60b25974b27f81be" },
//            @{ @"name": @"Cyan", @"id": @"562a578760b20fc98136d5c0" },
//        ] mutableCopy];
    }
    
    return self;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44*1.5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"HACRecoCell";
    HACRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HACRecommendCell alloc] initWithReuseIdentifier:identifier];
    }

    cell.userInfo = self[indexPath];
    [cell renderCell:self[indexPath]];
    cell.indexPath = indexPath;
    
    return cell;
}

@end
