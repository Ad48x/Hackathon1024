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

- (void)moveToBottom {
    self.tableView.contentOffset = CGPointMake(0, CGFLOAT_MAX);
}

- (void)scrollToBottom {
    [self.tableView setContentOffset:CGPointMake(0, CGFLOAT_MAX) animated:YES];
}

@end
