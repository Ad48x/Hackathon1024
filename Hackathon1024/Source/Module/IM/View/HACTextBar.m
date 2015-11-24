//
//  HACTextBar.m
//  Hackathon1024
//
//  Created by cyan on 15/10/22.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACTextBar.h"

@interface HACTextBar()<UITextFieldDelegate>

@end

@implementation HACTextBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = HAC_LightGray_Color;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
        line.backgroundColor = HAC_Gray_Color;
        [self addSubview:line];
        
        _textField = [[HACIMTextField alloc] init];
        _textField.delegate = self;
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(8, 8, 8, 8));
        }];
    }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    if (self.showKeyboardCallback) {
//        self.showKeyboardCallback();
//    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    self.textReturnCallback(textField.text);
    textField.text = @"";
    
    return YES;
}

@end
