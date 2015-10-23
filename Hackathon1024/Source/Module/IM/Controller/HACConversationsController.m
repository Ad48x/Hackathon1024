//
//  HACConversationsController.m
//  Hackathon1024
//
//  Created by cyan on 15/10/22.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACConversationsController.h"
#import "HACConversationDataSource.h"

@interface HACConversationsController ()

@end

@implementation HACConversationsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Conversations";
    
    self.dataSource = [[HACConversationDataSource alloc] init];
    [self initTableWithFrame:self.view.bounds refreshType:FFDataRefreshMaskHeader];
    self.tableView.dataSource = self.dataSource;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self queryConversationsFromCache];
}

- (void)queryConversationsFromCache {
    HACCacheManager *cacheMgr = [HACCacheManager manager];
    [cacheMgr queryConversations:^(NSArray *conversations) {
        [self finishRefreshData];
        self.dataSource.data = [conversations mutableCopy];
        [self.tableView reloadData];
    }];
}

- (void)queryConversations {
    [self finishRefreshData];
}

- (void)didBeginRefreshData {
    [self finishRefreshDataWhenTimeout];
    [self queryConversationsFromCache];
}

@end
