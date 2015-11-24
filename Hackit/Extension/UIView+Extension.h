//
//  UIView+Extension.h
//  Hackathon1024
//
//  Created by cyan on 14/11/30.
//  Copyright (c) 2014年 FunCube. All rights reserved.
//  封装了一些UIView的快捷方法

#import <UIKit/UIKit.h>

@interface UIView (Extension)

- (CGFloat)width;
- (CGFloat)height;
- (CGFloat)x;
- (CGFloat)y;
- (CGSize)size;

- (void)setSize:(CGSize)size;
- (void)setWidth:(CGFloat)w height:(CGFloat)h;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setX:(CGFloat)x y:(CGFloat)y;
- (void)setSize:(CGSize)size center:(CGPoint)center;
- (CGFloat)left;
- (CGFloat)right;
- (CGFloat)top;
- (CGFloat)bottom;

- (UIImage *)capturedImage;
- (UIImage *)capturedImageWithQuality:(CGFloat)quality;
- (UIImage *)capturedImageInRect:(CGRect)rect;

- (void)removeSubviews;

- (void)scaleTo:(CGFloat)scale;

- (void)shakeVertical;
- (void)shakeHorizontal;
- (void)bounceHorizontal;

- (void)handleTapGesture:(void (^)(UIGestureRecognizer *recognizer))handler;

@end
