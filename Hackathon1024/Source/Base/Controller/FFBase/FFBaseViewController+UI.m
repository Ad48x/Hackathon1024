//
//  FFBaseViewController+UI.m
//  FFBase
//
//  Created by cyan on 15/7/23.
//  Copyright (c) 2015年 justinjing. All rights reserved.
//

#import "FFBaseViewController+UI.h"

static const NSTimeInterval CSToastDefaultDuration = 3;

@implementation FFBaseViewController (UI)

- (void)clearExtendedLayoutEdges {
    [self setExtendedLayoutEdges:UIRectEdgeNone];
}

- (void)setExtendedLayoutEdges:(UIRectEdge)layout {
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = layout;
    }
}

- (void)setExtendedLayoutEdgesToAll {
    [self setExtendedLayoutEdges:UIRectEdgeAll];
}

#pragma mark - Nav

- (void)hideNavBar {
    [self hideNavBar:YES];
}

- (void)hideNavBar:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self enableSwipeBackGesture];
}

- (void)showNavBar {
    [self showNavBar:YES];
}

- (void)showNavBar:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)enableSwipeBackGesture {
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)disableSwipeBackGesture {
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)setRightBarButtonWithTitle:(NSString *)title action:(void (^)(id sender))handler {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:title style:UIBarButtonItemStylePlain handler:handler];
}

- (void)showToast:(NSString *)toast {
    [self showToast:toast duration:CSToastDefaultDuration position:CSToastPositionCenter];
}

- (void)showToast:(NSString *)toast duration:(NSTimeInterval)duration {
    [self showToast:toast duration:duration position:CSToastPositionCenter];
}

- (void)showToast:(NSString *)toast duration:(NSTimeInterval)duration position:(id)position {
    [self.view makeToast:toast duration:duration position:position];
}

- (void)showLoadingIndicator {
    [self.view makeToastActivity:CSToastPositionCenter];
}

- (void)hideLoadingIndicator {
    [self.view hideToastActivity];
}

@end
