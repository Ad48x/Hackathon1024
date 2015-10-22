//
//  HACBaseTableController.m
//  Pin
//
//  Created by cyan on 15/9/18.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACBaseTableController.h"

@interface HACBaseTableController ()

@end

@implementation HACBaseTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self clearExtendedLayoutEdges];
}

- (void)scrollToBottom {
    NSIndexPath *indexPath = NSIndexPathMake(self.dataSource.data.count-1, 0);
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

@end
