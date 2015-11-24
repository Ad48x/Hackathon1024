
//
//  HACTypeDataSource.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACTypeDataSource.h"

@interface HACTypeDataSource()

@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation HACTypeDataSource

- (instancetype)init {
    if (self = [super init]) {
        self.data = [@[
            @[ @"上下班", @"跑步", @"出差", @"旅行" ],
            @[ @"公交车", @"的士", @"步行", @"地铁", @"高铁" ]
        ] mutableCopy];
        _titleArray = @[ @"类型", @"交通方式" ];
        self.selectedType = 0;
        self.selectedVehicle = 0;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"HACTypeCell";
    HACBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HACBaseTableViewCell alloc] initWithReuseIdentifier:identifier];
    }
    cell.textLabel.text = self.data[indexPath.section][indexPath.row];
    if ((indexPath.section == 0 && indexPath.row == self.selectedType) ||
        (indexPath.section == 1 && indexPath.row == self.selectedVehicle)) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.tintColor = [UIColor asbestosColor];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.titleArray[section];
}

- (void)setSelectedType:(int)selectedType {
    _selectedType = selectedType;
    SharedData().userInfo[@"type"] = self.data[0][selectedType];
}

- (void)setSelectedVehicle:(int)selectedVehicle {
    _selectedVehicle = selectedVehicle;
    SharedData().userInfo[@"vehicle"] = self.data[1][selectedVehicle];
}

@end
