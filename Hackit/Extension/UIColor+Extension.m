//
//  UIColor+Extension.m
//  FlatUI
//
//  Created by Jack Flintermann on 5/3/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

// Thanks to http://stackoverflow.com/questions/3805177/how-to-convert-hex-rgb-color-codes-to-uicolor
+ (UIColor *) colorFromHexCode:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if ([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)aw_pinkColor {
    static UIColor *aw_pink = nil;
    static dispatch_once_t aw_pinkToken;
    
    dispatch_once(&aw_pinkToken, ^{
        aw_pink = [UIColor colorFromHexCode:@"FC5B67"];
    });
    
    return aw_pink;
}

+ (UIColor *)aw_purpleColor {
    static UIColor *aw_purple = nil;
    static dispatch_once_t aw_purpleToken;
    
    dispatch_once(&aw_purpleToken, ^{
        aw_purple = [UIColor colorFromHexCode:@"9980F4"];
    });
    
    return aw_purple;
}

+ (UIColor *)aw_blueColor {
    static UIColor *aw_blue = nil;
    static dispatch_once_t aw_blueToken;
    
    dispatch_once(&aw_blueToken, ^{
        aw_blue = [UIColor colorFromHexCode:@"2AB6F9"];
    });
    
    return aw_blue;
}

+ (UIColor *)aw_greenColor {
    static UIColor *aw_green = nil;
    static dispatch_once_t aw_greenToken;
    
    dispatch_once(&aw_greenToken, ^{
        aw_green = [UIColor colorFromHexCode:@"8FE13C"];
    });
    
    return aw_green;
}

+ (UIColor *)aw_yellowColor {
    static UIColor *aw_yellow = nil;
    static dispatch_once_t aw_yellowToken;
    
    dispatch_once(&aw_yellowToken, ^{
        aw_yellow = [UIColor colorFromHexCode:@"FEEC48"];
    });
    
    return aw_yellow;
}

+ (UIColor *)aw_orangeColor {
    static UIColor *aw_orange = nil;
    static dispatch_once_t aw_orangeToken;
    
    dispatch_once(&aw_orangeToken, ^{
        aw_orange = [UIColor colorFromHexCode:@"FD9427"];
    });
    
    return aw_orange;
}

+ (UIColor *)aw_redColor {
    static UIColor *aw_red = nil;
    static dispatch_once_t aw_redToken;
    
    dispatch_once(&aw_redToken, ^{
        aw_red = [UIColor colorFromHexCode:@"EA2925"];
    });
    
    return aw_red;
}

+ (UIColor *)aw_whiteColor {
    static UIColor *aw_white = nil;
    static dispatch_once_t aw_whiteToken;
    
    dispatch_once(&aw_whiteToken, ^{
        aw_white = [UIColor colorFromHexCode:@"FFFFFF"];
    });
    
    return aw_white;
}

+ (UIColor *) blendedColorWithForegroundColor:(UIColor *)foregroundColor
                              backgroundColor:(UIColor *)backgroundColor
                                 percentBlend:(CGFloat) percentBlend {
    CGFloat onRed, offRed, newRed, onGreen, offGreen, newGreen, onBlue, offBlue, newBlue, onWhite, offWhite;
    if (![foregroundColor getRed:&onRed green:&onGreen blue:&onBlue alpha:nil]) {
        [foregroundColor getWhite:&onWhite alpha:nil];
        onRed = onWhite;
        onBlue = onWhite;
        onGreen = onWhite;
    }
    if (![backgroundColor getRed:&offRed green:&offGreen blue:&offBlue alpha:nil]) {
        [backgroundColor getWhite:&offWhite alpha:nil];
        offRed = offWhite;
        offBlue = offWhite;
        offGreen = offWhite;
    }
    newRed = onRed * percentBlend + offRed * (1-percentBlend);
    newGreen = onGreen * percentBlend + offGreen * (1-percentBlend);
    newBlue = onBlue * percentBlend + offBlue * (1-percentBlend);
    return [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:1.0];
}

- (UIColor *) appendAlpha:(CGFloat)alpha {
    CGFloat red = 0.0, green = 0.0, blue = 0.0, a = 0.0;
    [self getRed:&red green:&green blue:&blue alpha:&a];
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (UIColor *) dimColorWithAlpha:(CGFloat)alpha {
    CGFloat red = 0.0, green = 0.0, blue = 0.0, a = 0.0;
    [self getRed:&red green:&green blue:&blue alpha:&a];
    return [UIColor colorWithRed:red*alpha green:green*alpha blue:blue*alpha alpha:a];
}

- (UIColor *)dimColor {
    return [self dimColorWithAlpha:0.8];
}

- (UIColor*) inversedColor {
    CGFloat r, g, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return [UIColor colorWithRed:1.-r green:1.-g blue:1.-b alpha:a];
}

- (CGFloat)colorBrightness {
    CGFloat _colorBrightness = 0;
    CGColorSpaceRef colorSpace = CGColorGetColorSpace(self.CGColor);
    CGColorSpaceModel colorSpaceModel = CGColorSpaceGetModel(colorSpace);
    if (colorSpaceModel == kCGColorSpaceModelRGB){
        const CGFloat *componentColors = CGColorGetComponents(self.CGColor);
        _colorBrightness = ((componentColors[0] * 299) + (componentColors[1] * 587) + (componentColors[2] * 114)) / 1000;
    } else {
        [self getWhite:&_colorBrightness alpha:0];
    }
    return _colorBrightness;
}

- (BOOL) isLightColor {
    return (self.colorBrightness >= 0.66f);
}

- (UIColor *) lighterColor {
    CGFloat r, g, b, a;
    if ([self getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MIN(r + 0.66, 1.0)
                               green:MIN(g + 0.66, 1.0)
                                blue:MIN(b + 0.66, 1.0)
                               alpha:a];
    return nil;
}

- (UIColor *) darkerColor {
    CGFloat r, g, b, a;
    if ([self getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.66, 0.0)
                               green:MAX(g - 0.66, 0.0)
                                blue:MAX(b - 0.66, 0.0)
                               alpha:a];
    return nil;
}

- (UIColor *) diffColor {
    return (self.colorBrightness >= 0.5) ? [self darkerColor] : [self lighterColor];
}

- (BOOL)isEqualToColor:(UIColor *)otherColor {
    CGColorSpaceRef colorSpaceRGB = CGColorSpaceCreateDeviceRGB();
    
    UIColor *(^convertColorToRGBSpace)(UIColor*) = ^(UIColor *color) {
        if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) == kCGColorSpaceModelMonochrome) {
            const CGFloat *oldComponents = CGColorGetComponents(color.CGColor);
            CGFloat components[4] = {oldComponents[0], oldComponents[0], oldComponents[0], oldComponents[1]};
            CGColorRef colorRef = CGColorCreate( colorSpaceRGB, components );
            
            UIColor *color = [UIColor colorWithCGColor:colorRef];
            CGColorRelease(colorRef);
            return color;
        } else
            return color;
    };
    
    UIColor *selfColor = convertColorToRGBSpace(self);
    otherColor = convertColorToRGBSpace(otherColor);
    CGColorSpaceRelease(colorSpaceRGB);
    
    return [selfColor isEqual:otherColor];
}

- (UIImage *)convertToImage {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, self.CGColor);
    CGContextFillRect(ctx, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
