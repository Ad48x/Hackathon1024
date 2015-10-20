//
//  UIView+Extension.m
//  Hackathon1024
//
//  Created by cyan on 14/11/30.
//  Copyright (c) 2014年 FunCube. All rights reserved.
//

#import "UIView+Extension.h"
#import <objc/runtime.h>

@interface UIView()

@property (nonatomic, copy) void (^tapHandler)(UITapGestureRecognizer *recognizer);

@end

@implementation UIView (Extension)

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}

- (void)setSize:(CGSize)size center:(CGPoint)center {
    self.frame = CGRectMake(center.x-size.width/2, center.y-size.height/2, size.width, size.height);
}

- (void)setWidth:(CGFloat)w height:(CGFloat)h {
    [self setSize:CGSizeMake(w, h)];
}

- (void)setWidth:(CGFloat)width {
    [self setWidth:width height:self.height];
}

- (void)setHeight:(CGFloat)height {
    [self setWidth:self.width height:height];
}

- (void)setX:(CGFloat)x y:(CGFloat)y {
    CGRect frame = { x, y, self.width, self.height };
    self.frame = frame;
}

- (CGFloat)left {
    return self.x;
}

- (CGFloat)right {
    return self.x + self.width;
}

- (CGFloat)top {
    return self.y;
}

- (CGFloat)bottom {
    return self.y + self.height;
}

- (UIImage *)capturedImage {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)capturedImageWithQuality:(CGFloat)quality {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale/quality);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)capturedImageInRect:(CGRect)rect {
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale/2);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
    [self.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)removeSubviews {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)scaleTo:(CGFloat)scale {
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
}

- (void)shakeVertical {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    anim.values = @[pack_y(6.0), pack_y(-4.0), pack_y(2.0), pack_y(-1.0), pack_y(0.0)];
    anim.duration = 0.36;
    [self.layer addAnimation:anim forKey:nil];
}

- (void)shakeHorizontal {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    anim.values = @[pack_x(-16.0), pack_x(8.0), pack_x(-4.0), pack_x(2.0), pack_x(-1.0), pack_x(0.0)];
    anim.duration = 0.5;
    [self.layer addAnimation:anim forKey:nil];
}

NSValue *pack_x(float x) {
    return [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(x, 0, 0)];
}

NSValue *pack_y(float y) {
    return [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, y, 0)];
}

- (void)bounceHorizontal {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    anim.values = @[pack_x(4.0), pack_x(-2.0), pack_x(1.0), pack_x(0.0)];
    anim.duration = 0.5;
    [self.layer addAnimation:anim forKey:nil];
}

- (void)setTapHandler:(void (^)(UITapGestureRecognizer *))tapHandler {
    objc_setAssociatedObject(self, @selector(tapHandler), tapHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UITapGestureRecognizer *))tapHandler {
    return objc_getAssociatedObject(self, @selector(tapHandler));
}

- (void)handleTapGesture:(void (^)(UIGestureRecognizer *recognizer))handler {
    self.tapHandler = handler;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_handleTapGesture:)];
    [self addGestureRecognizer:gesture];
}

- (void)_handleTapGesture:(UITapGestureRecognizer *)gesture {
    void (^handler)(UITapGestureRecognizer *recognizer) = [self tapHandler];
    if (handler && gesture) {
        handler(gesture);
    }
}

@end
