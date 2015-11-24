//
//  HACTextBar.h
//  Hackathon1024
//
//  Created by cyan on 15/10/22.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HACIMTextField.h"

typedef void (^HACTextBarShowKeyboardCallback)(void);
typedef void (^HACTextBarTextReturnCallback)(NSString *text);

static const CGFloat kHACTextBarHeight = 48;

@interface HACTextBar : UIView

@property (nonatomic, strong) HACIMTextField *textField;
@property (nonatomic, copy) HACTextBarShowKeyboardCallback showKeyboardCallback;
@property (nonatomic, copy) HACTextBarTextReturnCallback textReturnCallback;

@end
