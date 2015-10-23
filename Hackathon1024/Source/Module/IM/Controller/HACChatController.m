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

#define kHACKeyboardInset   (IS_IPHONE6_PLUS ? -270.0 : -258.0)

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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self moveToBottom];
    
    self.textBar = [[HACTextBar alloc] initWithFrame:CGRectMake(0, self.tableView.bottom, self.view.width, kHACTextBarHeight)];
    [self.view addSubview:self.textBar];
    
    [self bind];
}

// notifications & callbacks
- (void)bind {

    @weakify(self);
    [self registerNotification:UIKeyboardWillShowNotification handler:^(NSNotification *notification) {
        @strongify(self)
        [self showKeyboard];
    }];
    
    [self registerNotification:UIKeyboardWillHideNotification handler:^(NSNotification *notification) {
        @strongify(self)
        [self hideKeyboard];
    }];
    
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
    self.keyboardVisible = NO;
    [self moveTextBar];
}

- (void)sendText:(NSString *)text {
    
    if (text.length == 0) {
        return ;
    }
    
    [[HACIMManager manager] sendText:text to:self.clientId callback:^(BOOL succeeded, NSError *error) {
        Log(@"send text: %@ (%d)", text, succeeded);
        if (succeeded) { // append cell
            
        }
    }];
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
    [self.view endEditing:YES];
}

@end
