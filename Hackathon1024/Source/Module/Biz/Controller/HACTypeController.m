//
//  HACTypeController.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACTypeController.h"
#import "HACTypeDataSource.h"
#import "HACTimeController.h"

@interface HACTypeController ()

@end

@implementation HACTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择形式";
    @weakify(self);
    [self setRightBarButtonWithTitle:@"下一步" action:^(id sender) {
        @strongify(self)
        HACTimeController *controller = [[HACTimeController alloc] init];
        [self pushViewController:controller];
    }];
    
    self.dataSource = [[HACTypeDataSource alloc] init];
    [self initTableWithFrame:self.view.bounds style:UITableViewStyleGrouped refreshType:FFDataRefreshMaskNone];
    self.tableView.delegate = self;
    self.tableView.dataSource = self.dataSource;
}

- (HACTypeDataSource *)ds {
    return (HACTypeDataSource *)self.dataSource;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        [self ds].selectedType = (int)indexPath.row;
    } else {
        [self ds].selectedVehicle = (int)indexPath.row;
    }
    [tableView reloadData];
}

@end
