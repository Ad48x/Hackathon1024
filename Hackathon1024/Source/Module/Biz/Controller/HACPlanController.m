//
//  HACPlanController.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACPlanController.h"
#import "HACPOIController.h"
#import "HACPlanDataSource.h"
#import "HACMapController.h"
#import "HACNavController.h"
#import "HACRecommendController.h"

@interface HACPlanController ()

@property (nonatomic, strong) HACFlatButton *addButton;

@end

@implementation HACPlanController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"行程";
    [self clearExtendedLayoutEdges];
    
    self.addButton = [[HACFlatButton alloc] init];
    self.addButton.title = @"添加新的";
    [self.view addSubview:self.addButton];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-20);
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(self.view.width-40, self.addButton.size.height));
    }];
    
    @weakify(self);
    [self.addButton bk_addEventHandler:^(id sender) {
        @strongify(self)
        HACPOIController *controller = [[HACPOIController alloc] init];
        controller.selectFrom = YES;
        HACNavController *nav = [[HACNavController alloc] initWithRootViewController:controller];
        [self presentViewController:nav animated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.dataSource = [[HACPlanDataSource alloc] init];
    [self initTableWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-TABLE_INSET-82) refreshType:FFDataRefreshMaskHeader];
    self.tableView.dataSource = self.dataSource;
    
    [self.view addSubview:({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height-TABLE_INSET, self.view.width, 49)];
        view.backgroundColor = [UIColor whiteColor];
        view;
    })];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadPlansFromRemote];
    
    if (SharedData().showRecommend) {
        HACRecommendController *controller = [HACRecommendController new];
        controller.users = SharedData().recommendData[@"list"];
        HACNavController *nav = [[HACNavController alloc] initWithRootViewController:controller];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

- (void)loadPlansFromRemote {

    [self finishRefreshData];
    
    @weakify(self);
    [[HACNetworkManager manager] post:API(@"get_point") params:@{ @"userID": [HACIMUser currentUser].clientId } complete:^(HACNetworkRetCode code, NSDictionary *resp) {
        [self finishRefreshData];
        @strongify(self)
        NSArray *list = resp[@"points"];
        if (list) {
            self.dataSource.data = [list mutableCopy];
            [self.tableView reloadData];
        }
    }];
}

- (void)didBeginRefreshData {
    [self finishRefreshDataWhenTimeout];
    [self loadPlansFromRemote];
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dict = self.dataSource.data[indexPath.row];
    // push
    HACMapController *controller = [[HACMapController alloc] init];
    controller.startCoordinate = CLLocationCoordinate2DMake([dict[@"start_latitude"] doubleValue], [dict[@"start_longitude"] doubleValue]);
    controller.destinationCoordinate = CLLocationCoordinate2DMake([dict[@"end_latitude"] doubleValue], [dict[@"end_longitude"] doubleValue]);
    controller.disableRightBarButton = YES;
    controller.vehicleText = dict[@"vehicle"];
    controller.timeText = [NSString stringWithFormat:@"%@ - %@", dict[@"start_time"], dict[@"end_time"]];

    [self pushTabController:controller];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource heightForRowAtIndexPath:indexPath];
}

@end
