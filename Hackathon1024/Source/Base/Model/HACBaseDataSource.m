//
//  HACBaseDataSource.m
//  Pin
//
//  Created by cyan on 15/9/13.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACBaseDataSource.h"
#import "AppStyles.h"

@implementation HACBaseDataSource

- (instancetype)init {
    if (self = [super init]) {
        _data = [NSMutableArray array];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kHACDefaultCellHeight;
}

- (id)objectForKeyedSubscript:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.data.count) {
        return nil;
    }
    return self.data[indexPath.row];
}

- (void)setObject:(id)object forKeyedSubscript:(NSIndexPath *)indexPath {
    if (indexPath.row < self.data.count) {
        self.data[indexPath.row] = object;
    }
}

@end
