//
//  HACBaseDataSource.h
//  Pin
//
//  Created by cyan on 15/9/13.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HACBaseTableViewCell.h"

@interface HACBaseDataSource : NSObject<UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, weak) id host;

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (id)objectForKeyedSubscript:(NSIndexPath *)indexPath;
- (void)setObject:(id)object forKeyedSubscript:(NSIndexPath *)indexPath;

@end
