//
//  HACWebController.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACWebController.h"
#import <WebKit/WebKit.h>

static NSString *const kWebServerApi = @"http://u77.club/#/direct";

@interface HACWebController ()<WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation HACWebController

- (instancetype)initWithClientId:(NSString *)clientId {
    if (self = [super init]) {
        _clientId = clientId;
        
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        self.webView.navigationDelegate = self;
        self.webView.scrollView.scrollEnabled = NO;
        self.webView.UIDelegate = self;
        
        [self.view addSubview:self.webView];
        
        [self reload];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Chat";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideNavBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self showNavBar];
}

- (void)reload {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kWebServerApi]]];
}

#pragma mark - WK Delegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {

}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake) {
        [self reload];
    }
    
    if ([super respondsToSelector:@selector(motionEnded:withEvent:)]) {
        [super motionEnded:motion withEvent:event];
    }
}

- (void)initChat {
    NSString *js = [NSString stringWithFormat:@"init(%@, %@);", JsonWithId(self.clientId?:@"5629e6cf60b25974b27f81be", @"http://ac-qp5mlkuc.clouddn.com/4f0707ac69a6cb70.JPG", @"TY"), JsonWithId(@"562a011e60b280457801ca11", @"http://ac-qp5mlkuc.clouddn.com/2e98a01867218239.jpeg", @"Cyan")];
    [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        if (error) {
            Log(@"js error: %@", error);
        }
    }];
}

NSString *JsonWithId(NSString *clientId, NSString *avatar, NSString *name) {
    NSString *json = [NSString stringWithFormat:@"{\"id\":'%@',\"avatar\":'%@',\"name\":'%@'}", clientId, avatar, name];
    return json;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // init request from webView
    NSString *scheme = navigationAction.request.URL.scheme;
    if ([scheme isEqualToString:@"openclient"]) {
        // cancel request
        decisionHandler(WKNavigationActionPolicyCancel);
        // init
        [self initChat];
    } else if ([scheme isEqualToString:@"navback"]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        // nav back
        [self.navigationController popViewControllerAnimated:YES];
    }
    // continue request
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
