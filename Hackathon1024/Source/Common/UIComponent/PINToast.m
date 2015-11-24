//
//  PINToast.m
//  Pin
//
//  Created by cyan on 15/9/20.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "PINToast.h"

@interface PINToast()

@property (nonatomic, strong) UILabel *label;

@end

@implementation PINToast

- (instancetype)initWithMessage:(NSString *)message {
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor alizarinColor];
        
        [[[HACAppDelegate instance] window] addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.superview);
            make.height.equalTo(FF_NAV_BAR_HEIGHT);
            make.top.equalTo(self.superview.mas_top).offset(-FF_NAV_BAR_HEIGHT);
        }];
        
        _label = [[UILabel alloc] init];
        _label.textColor = [UIColor whiteColor];
        _label.font = MediumFont(17);
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = message;
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self);
            make.top.equalTo(STATUS_BAR_HEIGHT);
        }];
        
        [self layoutIfNeeded];
        
        @weakify(self)
        [self handleTapGesture:^(UIGestureRecognizer *recognizer) {
            @strongify(self)
            [self dismiss];
        }];
    }
    return self;
}

+ (void)showMessage:(NSString *)message {
    // remove all
    [[[[HACAppDelegate instance] window] subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[PINToast class]]) {
            [obj removeFromSuperview];
        }
    }];
    
    // add a new one
    PINToast *toast = [[PINToast alloc] initWithMessage:message];
    [toast mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(toast.superview);
    }];
    
    [UIView animateWithDuration:0.16 animations:^{
        [toast layoutIfNeeded];
    }];
    
    @weakify(toast)
    delay(1.0, ^{
        @strongify(toast)
        [toast dismiss];
    });
}

- (void)dismiss {
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.superview).offset(-FF_NAV_BAR_HEIGHT);
    }];
    
    [UIView animateWithDuration:0.16 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
