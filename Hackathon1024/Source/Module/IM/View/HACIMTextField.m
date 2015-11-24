//
//  HACIMTextField.m
//  Hackathon1024
//
//  Created by cyan on 15/10/22.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACIMTextField.h"

@implementation HACIMTextField

- (instancetype)init {
    if (self = [super init]) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 4;
        self.layer.borderColor = HAC_Gray_Color.CGColor;
        self.layer.borderWidth = 0.5;
        self.backgroundColor = HAC_Theme_Color;
        self.placeholder = @"message";
        self.returnKeyType = UIReturnKeySend;
        self.font = RegularFont(14);
    }
    return self;
}

static const CGFloat inset = 5;

// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(inset, bounds.origin.y, bounds.size.width-3*inset, bounds.size.height);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

@end
