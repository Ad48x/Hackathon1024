//
//  HACContactController.m
//  Hackathon1024
//
//  Created by cyan on 15/10/22.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACContactController.h"
#import "HACContactDataSource.h"
#import "HACChatController.h"

@interface HACContactController ()

@end

@implementation HACContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Contact";
    
    self.dataSource = [[HACContactDataSource alloc] init];
    [self initTableWithFrame:self.view.bounds refreshType:FFDataRefreshMaskHeader];
    self.tableView.dataSource = self.dataSource;

    [self queryUsers];
}

- (void)queryUsers {
    
    [self finishRefreshData];
    
    HACIMManager *mgr = [HACIMManager manager];
    [mgr queryUsers:^(NSArray *array) {
        self.dataSource.data = [array mutableCopy];
        [self.tableView reloadData];
    }];
}

- (void)didBeginRefreshData {
    [self finishRefreshDataWhenTimeout];
    [self queryUsers];
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HACChatController *controller = [[HACChatController alloc] initWithClientId:self.dataSource[indexPath][@"name"]];
    [self pushTabController:controller];
}

@end
