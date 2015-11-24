//
//  HACConversationDataSource.m
//  Hackathon1024
//
//  Created by cyan on 15/10/23.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACConversationDataSource.h"

@implementation HACConversationDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"HACConversationCell";
    HACBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HACBaseTableViewCell alloc] initWithReuseIdentifier:identifier];
    }
    HACCachedConversation *conversation = self[indexPath];
    cell.textLabel.text = conversation.displayName;
    return cell;
}

@end
