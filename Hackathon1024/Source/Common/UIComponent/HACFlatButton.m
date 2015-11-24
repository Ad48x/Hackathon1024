//
//  HACFlatButton.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACFlatButton.h"

@implementation HACFlatButton

- (instancetype)init {
    if (self = [super init]) {
        self.buttonColor = [UIColor concreteColor];
        self.cornerRadius = 4.0f;
        self.titleLabel.font = [UIFont boldFlatFontOfSize:15];
        [self setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
        [self setSize:CGSizeMake(SCREEN_WIDTH-40, 44)];
    }
    
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.buttonColor = [UIColor asbestosColor];
    } else {
        self.buttonColor = [UIColor concreteColor];
    }
}

- (void)setColor:(UIColor *)bgColor shadowColor:(UIColor *)shadowColor {
    self.buttonColor = bgColor;
    self.shadowColor = shadowColor;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self setTitle:title forState:UIControlStateNormal];
}

@end
