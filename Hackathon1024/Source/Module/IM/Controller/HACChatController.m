//
//  HACChatController.m
//  Hackathon1024
//
//  Created by cyan on 15/10/21.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACChatController.h"
#import "HACChatDataSource.h"
#import "HACTextBar.h"

static const CGFloat kHACKeyboardInset = -258;

@interface HACChatController ()

@property (nonatomic, assign) BOOL keyboardVisible;
@property (nonatomic, copy) NSString *clientId;
@property (nonatomic, strong) HACTextBar *textBar;

@end

@implementation HACChatController

- (instancetype)initWithClientId:(NSString *)clientId {
    if (self = [super init]) {
        _clientId = clientId;
    }
    return self;
}

- (CGFloat)tableHeight {
    return SCREEN_HEIGHT-FF_NAV_BAR_HEIGHT-kHACTextBarHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.clientId;

    self.dataSource = [[HACChatDataSource alloc] init];
    [self initTableWithFrame:CGRectMake(0, 0, self.view.width, self.tableHeight) refreshType:FFDataRefreshMaskNone];
    self.tableView.dataSource = self.dataSource;
    self.tableView.allowsSelection = NO;

    delay(0.5, ^{
        [self scrollToBottom];
    });
    
    self.textBar = [[HACTextBar alloc] initWithFrame:CGRectMake(0, self.tableView.bottom, self.view.width, kHACTextBarHeight)];
    [self.view addSubview:self.textBar];
    
    @weakify(self)
    self.textBar.showKeyboardCallback = ^{
        @strongify(self)
        [self showKeyboard];
    };
    
    self.textBar.textReturnCallback = ^(NSString *text) {
        @strongify(self)
        [self sendText:text];
    };
}

- (void)showKeyboard {
    self.keyboardVisible = YES;
    [self moveTextBar];
}

- (void)hideKeyboard {
    if (self.keyboardVisible) {
        self.keyboardVisible = NO;
        [self moveTextBar];
        [self.view endEditing:YES];
    }
}

- (void)sendText:(NSString *)text {
    [self hideKeyboard];
    Log(@"send text: %@", text);
}

- (void)moveTextBar {
    CGFloat inset = self.keyboardVisible ? kHACKeyboardInset : 0;
    CGRect tableRect = CGRectMake(0, inset, self.view.width, self.tableHeight);
    CGRect barRect = CGRectMake(0, self.tableHeight+inset, self.view.width, self.textBar.height);
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame = tableRect;
        self.textBar.frame = barRect;
    }];
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource heightForRowAtIndexPath:indexPath];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self hideKeyboard];
}

@end
