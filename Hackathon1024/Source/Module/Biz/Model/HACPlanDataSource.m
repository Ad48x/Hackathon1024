//
//  HACPlanDataSource.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACPlanDataSource.h"

@interface HACPlanDataSource()

@end

@implementation HACPlanDataSource

- (instancetype)init {
    if (self = [super init]) {
    }
    
    return self;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"HACPlanCell";
    HACBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HACBaseTableViewCell alloc] initWithReuseIdentifier:identifier style:UITableViewCellStyleSubtitle];
    }
    NSDictionary *dict = self.data[indexPath.row];
    NSString *title = [NSString stringWithFormat:@"%@ - %@", dict[@"start_name"], dict[@"end_name"]];
    cell.textLabel.text = title;
    cell.textLabel.font = LightFont(19);
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", dict[@"start_time"], dict[@"end_time"]];
    cell.detailTextLabel.font = RegularFont(17);
    cell.detailTextLabel.textColor = [UIColor asbestosColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

@end
