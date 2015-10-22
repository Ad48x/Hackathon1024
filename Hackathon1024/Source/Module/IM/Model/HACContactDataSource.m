//
//  HACContactDataSource.m
//  Hackathon1024
//
//  Created by cyan on 15/10/22.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACContactDataSource.h"

@implementation HACContactDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"HACContactCell";
    HACBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HACBaseTableViewCell alloc] initWithReuseIdentifier:identifier];
    }
    cell.textLabel.text = self[indexPath][@"name"];
    return cell;
}

@end
