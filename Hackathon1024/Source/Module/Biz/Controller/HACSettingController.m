//
//  HACSettingController.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACSettingController.h"
#import "HACSettingDataSource.h"

@interface HACSettingController ()

@end

@implementation HACSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    self.dataSource = [[HACSettingDataSource alloc] init];
    [self initTableWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStyleGrouped refreshType:FFDataRefreshMaskNone];
    self.tableView.dataSource = self.dataSource;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [PINToast showMessage:@"等下个版本吧！"];
}

@end
