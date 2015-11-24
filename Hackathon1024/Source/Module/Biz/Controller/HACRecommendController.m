//
//  HACRecommendController.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACRecommendController.h"
#import "HACRecommendDataSource.h"

@interface HACRecommendController ()

@end

@implementation HACRecommendController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SharedData().showRecommend = NO;
    
    self.title = @"推荐用户";
    @weakify(self);
    [self setRightBarButtonWithTitle:@"完成" action:^(id sender) {
        @strongify(self)
        [self dismissViewControllerAnimated:YES completion:^{
            [[HACAppDelegate instance] switchTabToIndex:1];
        }];
    }];
    [self clearExtendedLayoutEdges];
    
    self.dataSource = [[HACRecommendDataSource alloc] init];
    self.dataSource.data = [self.users mutableCopy];
    [self initTableWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-49-20) refreshType:FFDataRefreshMaskNone];
    self.tableView.allowsSelection = NO;
    self.tableView.dataSource = self.dataSource;
    
    [self registerNotification:DELETE_CELL handler:^(NSNotification *notification) {
        @strongify(self)
        [self.tableView beginUpdates];
        [self.dataSource.data removeObjectAtIndex:[notification.object row]];
        [self.tableView deleteRowsAtIndexPaths:@[notification.object] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    }];
}

@end
