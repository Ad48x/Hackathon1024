//
//  AppMacros.h
//  Hackathon1024
//
//  Created by cyanzhong on 15/2/5.
//  Copyright (c) 2015年 FunCube. All rights reserved.
//  一些比较常用的宏

#ifndef Pin_AppMacros_h
#define Pin_AppMacros_h

#import <Foundation/Foundation.h>
// find . -name "*.[hm]" -print0 | xargs -0 wc -l

//  AppGroups
#define kAppGroupId         @"group.hackathon1024.share"
#define ComDefaults         [[NSUserDefaults alloc] initWithSuiteName:kAppGroupId]
#define kSharedContainerUrl [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:kAppGroupId]

// 用于生成单例
#define SINGLETON(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
    _sharedObject = block(); \
}); \
return _sharedObject; \

// 输出
#ifdef DEBUG
#   define Log(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define Log(...)
#endif

// 屏幕
#define SCREEN_WIDTH        ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT       ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_SCALE        ([UIScreen mainScreen].scale)
#define ONE_PIXEL           (1.0f/SCREEN_SCALE)
#define STATUS_BAR_HEIGHT   ([UIApplication sharedApplication].statusBarFrame.size.height)

// 颜色
#define RGBA(R, G, B, A)    [UIColor colorWithRed: R/255.0 green: G/255.0 blue: B/255.0 alpha: A]
#define RGB(R, G, B)        RGBA(R, G, B, 1.0)
#define HexColor(v)         RGB((double)((v&0xff0000)>>16), (double)((v&0xff00)>>8), (double)(v&0xff))

// 机型判定 这个地方注意横竖屏会影响判断结果
#define DEVICE_PORTRAIT     (SCREEN_WIDTH < SCREEN_HEIGHT)
#define DEVICE_LANDSCAPE    (!DEVICE_PORTRAIT)
#define DEVICE_HEIGHT       (DEVICE_PORTRAIT ? SCREEN_HEIGHT : SCREEN_WIDTH)
#define DEVICE_WIDTH        (DEVICE_PORTRAIT ? SCREEN_WIDTH : SCREEN_HEIGHT)
#define IS_IPHONE4_TO_5S    (DEVICE_WIDTH  <= 320)
#define IS_IPHONE5_OR_LATER (DEVICE_HEIGHT >= 568)
#define IS_IPHONE4          (DEVICE_HEIGHT <= 480)
#define IS_IPHONE6          (DEVICE_HEIGHT >= 667 && DEVICE_HEIGHT < 736)
#define IS_IPAD             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IPAD_WIDGET_WIDTH   (590.0)
#define IS_IPHONE6_PLUS     ((DEVICE_HEIGHT >= 736) && !IS_IPAD)

#define DYNAMIC_SIZE(I5, I6, I6P) (IS_IPHONE4_TO_5S ? (I5) : (IS_IPHONE6 ? (I6) : (I6P)))

// 版本号
#define IOS_VERSION         [[[UIDevice currentDevice] systemVersion] floatValue]
#define IS_OS_5_OR_LATER    (IOS_VERSION >= 5.0)
#define IS_OS_6_OR_LATER    (IOS_VERSION >= 6.0)
#define IS_OS_7_OR_LATER    (IOS_VERSION >= 7.0)
#define IS_OS_8_OR_LATER    (IOS_VERSION >= 8.0)
#define IS_OS_9_OR_LATER    (IOS_VERSION >= 9.0)

#define IS_CLASS(obj, clz)  ([obj isKindOfClass:[clz class]])
#define IS_NOT_CLASS(obj, clz) (!IS_CLASS(obj, clz))

// 获取本地化字符串
#define i18n(text)          NSLocalizedStringFromTable(text , @"InfoPlist", nil)
// 返回不为空的字符串
#define NON_EMPTY_STR(str)  (str ?: @"")
// 判断字符串是否为空
#define IS_EMPTY_STR(str)       (str == nil || [str isEqualToString:@""])
#define IS_NOT_EMPTY_STR(str)   (!IS_EMPTY_STR(str))
// 得到一个不为null的NSNumber
#define NS_NUM(x)           @([x intValue])
// 默认语言
#define PREF_LANG           [[NSLocale preferredLanguages] firstObject]
// 是否中国用户
#define IS_CHINESE_USER     ([PREF_LANG hasPrefix:@"zh-Hans"] || [PREF_LANG hasPrefix:@"zh-Hant"] || [PREF_LANG hasPrefix:@"zh-HK"])
// 打印i18n
#define PRINT_I18N(k, v)    printf("\"%s\" = \"%s\";\n", [k UTF8String], [v UTF8String])

// App ID
#define APP_STORE_ID            (1044525102)
// App Bundle ID
#define APP_BUNDLE_ID           @"app.cyan.hackathon1024"
// App首页
#define APP_STORE_HOME(appId)   [NSString stringWithFormat:@"http://itunes.apple.com/app/id%d?mt=8", appId]
// App评分页
#define APP_STORE_RATE(appId)   [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%d&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8", appId]

//#define APP_SHORT_URL           @"https://appsto.re/cn/vuYL6.i"

#define APP_RATE_URL            [NSURL URLWithString:APP_STORE_RATE(APP_STORE_ID)]

#define APP_VERSION             ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])

// 时间相关
#define CURRENT_TIME_SEC    ([[NSDate date] timeIntervalSince1970])
#define CURRENT_SYSUP_SEC   ([[NSProcessInfo processInfo] systemUptime])

// App/Documents文件夹
#define DOC_PATH(name)      [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:name]

// App Bundle文件夹
#define BUNDLE_PATH(name, type) [[NSBundle mainBundle] pathForResource:name ofType:type]

// 按行读取文件
#define LINES_DATA(path)    [[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]

// 生成一个a~b闭区间的随机数
#define RANDOM_NUM(from, to)    (arc4random_uniform(to - from + 1) + from)

// 计时
#define TIME_BEGIN \
double beginTime = CURRENT_TIME_SEC; \

#define TIME_END \
double endTime = CURRENT_TIME_SEC; \
NSLog(@"time used: %lf", (endTime - beginTime)); \

// 增强方法
#define NSIndexPathMake(row, section)   [NSIndexPath indexPathForRow:row inSection:section]
#define NSIndexPathZero                 NSIndexPathMake(0, 0)
#define NSIndexSetMake(index)           [NSIndexSet indexSetWithIndex:index]

#define IGNORE_TOUCH        [[UIApplication sharedApplication] beginIgnoringInteractionEvents]
#define RESUME_TOUCH        [[UIApplication sharedApplication] endIgnoringInteractionEvents]

// 模拟器检测
#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

// Blocks
typedef void(^VoidCallback) (void);
typedef void(^BoolCallback) (BOOL success);
typedef void(^ArrayCallback) (NSArray *array);
typedef void(^DictionaryCallback) (NSDictionary *dictionary);

#endif
