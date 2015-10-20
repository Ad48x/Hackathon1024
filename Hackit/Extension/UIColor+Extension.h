//
//  UIColor+Extension.h
//  FlatUI
//
//  Created by Jack Flintermann on 5/3/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

// Apple Watch Colors
+ (UIColor *) aw_pinkColor;
+ (UIColor *) aw_purpleColor;
+ (UIColor *) aw_blueColor;
+ (UIColor *) aw_greenColor;
+ (UIColor *) aw_yellowColor;
+ (UIColor *) aw_orangeColor;
+ (UIColor *) aw_redColor;
+ (UIColor *) aw_whiteColor;

+ (UIColor *) blendedColorWithForegroundColor:(UIColor *)foregroundColor
                              backgroundColor:(UIColor *)backgroundColor
                                 percentBlend:(CGFloat) percentBlend;

// add by cyan
- (UIColor *) appendAlpha:(CGFloat)alpha;       // 加alpha
- (UIColor *) dimColorWithAlpha:(CGFloat)alpha; // 变淡
- (UIColor *) dimColor;                         // 0.8的alpha
- (UIColor *) inversedColor;                    // 翻转颜色

- (BOOL) isLightColor;                          // 是否Light
- (UIColor *) lighterColor;                     // 更白
- (UIColor *) darkerColor;                      // 更黑
- (UIColor *) diffColor;                        // 无论怎样都能看清的颜色

- (BOOL)isEqualToColor:(UIColor *)otherColor;   // 比较

- (UIImage *)convertToImage;                    // 得到一个像素的纯色图片

@end
