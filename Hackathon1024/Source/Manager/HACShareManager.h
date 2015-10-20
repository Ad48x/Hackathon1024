//
//  HACShareManager.h
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import "WeiboSDK.h"

static NSString *const WeChatID = @"wx88ce5bbddd087850";
static NSString *const WeChatKey = @"48a23d9f383e6cf2720a7273cbd2106b";
static NSString *const OpenQQID = @"1103838326";
static NSString *const OpenQQKey = @"qtlGLpv6hX1a958L";
static NSString *const WeiboID = @"1364745285";
static NSString *const WeiboKey = @"8e9234913bc082770dd44dbcf15e4637";

@interface HACShareManager : NSObject<
    TencentSessionDelegate,
    WBHttpRequestDelegate
>

+ (instancetype)manager;

- (void)initSDKs;

- (void)shareToWechatSession;  // 分享到微信会话
- (void)shareToWechatTimeline; // 分享到微信朋友圈
- (void)shareToQQSession;      // 分享到QQ会话
- (void)shareToQZone;          // 分享到QZone
- (void)shareToWeiBo;          // 分享到新浪微博

- (void)shareImageToWeChatSession:(UIImage *)image;
- (void)shareImageToWeChatTimeline:(UIImage *)image;
- (void)shareImageToQQ:(UIImage *)image;

@end
