//
//  HACFlatButton.h
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import <FlatUIKit/FlatUIKit.h>

@interface HACFlatButton : FUIButton

@property (nonatomic, copy) NSString *title;

- (void)setColor:(UIColor *)bgColor shadowColor:(UIColor *)shadowColor;

@end
