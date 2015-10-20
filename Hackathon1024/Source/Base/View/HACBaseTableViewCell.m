//
//  HACBaseTableViewCell.m
//  Pin
//
//  Created by cyan on 15/9/7.
//  Copyright (c) 2015年 cyan. All rights reserved.
//

#import "HACBaseTableViewCell.h"

@implementation HACBaseTableViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.textColor = HAC_LightGray_Color;
        self.textLabel.font = ThinFont(15);
        
        self.backgroundColor = HAC_Theme_Color;
        self.selectedBackgroundView = ({
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [self.backgroundColor dimColorWithAlpha:0.95];
            view;
        });
    }
    return self;
}

- (void)renderCell:(id)data {

}

@end
