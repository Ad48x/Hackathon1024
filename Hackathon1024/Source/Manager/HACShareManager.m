//
//  HACShareManager.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACShareManager.h"
#import "UIImage+Resize.h"

#define THUMB_SIZE  CGSizeMake(150, 150)
#define SHARE_ICON  @"share_icon"

@interface HACShareManager()

@property (nonatomic, strong) TencentOAuth *tencentOAuth;

@end

@implementation HACShareManager

+ (instancetype)manager {
    SINGLETON(^{
        return [[self alloc] init];
    });
}

- (void)initSDKs {
    [WXApi registerApp:WeChatID]; // 初始化微信开放平台
    
    // 初始化qq互联开放平台
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:OpenQQID
                                                andDelegate:self];
    
    // 初始化新浪微博开放平台
#if DEBUG
    [WeiboSDK enableDebugMode:YES];
#else
    [WeiboSDK enableDebugMode:NO];
#endif
    [WeiboSDK registerApp:WeiboID];
}

- (void)shareToWechatWithText:(NSString *)text scene:(int)scene {
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.text = text;
    req.bText = YES;
    req.scene = scene;
    [WXApi sendReq:req];
}

- (void)shareToWechatSessionWithText:(NSString *)text {
    [self shareToWechatWithText:text scene:WXSceneSession];
}

- (void)shareToWechatTimelineWithText:(NSString *)text {
    [self shareToWechatWithText:text scene:WXSceneTimeline];
}

- (void)shareToQQSessionWithText:(NSString *)text {
    QQApiTextObject *txtObj = [QQApiTextObject objectWithText:text];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:txtObj];
    [QQApiInterface sendReq:req];
}

- (void)shareToQZoneWithText:(NSString *)text {
  
    NSString *utf8String = @"htpp://baidu.com";
    NSString *title = @"QZone 分享标题";
    NSString *description = text;
    
    UIImage *image = [UIImage imageNamed:SHARE_ICON];
    NSData *data = UIImagePNGRepresentation(image);
    
    QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String]
                                                        title:title
                                                  description:description
                                             previewImageData:data];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    [QQApiInterface SendReqToQZone:req];
}

- (void)shareToWeiBoWithText:(NSString *)text {
    WBImageObject *imageObject = [[WBImageObject alloc] init];
    UIImage *image = [UIImage imageNamed:@"wb_share.png"];
    NSData *imageData = UIImagePNGRepresentation(image);
    imageObject.imageData = imageData;
    
    if ([WeiboSDK isWeiboAppInstalled]) { // 使用原生应用分享
        WBMessageObject *msg = [WBMessageObject message];
        msg.text = text;
        msg.imageObject = imageObject;
        WBSendMessageToWeiboRequest *req = [WBSendMessageToWeiboRequest requestWithMessage:msg];
        [WeiboSDK sendRequest:req];
    } else { // 使用web登陆分享
        WBMessageObject *msg = [WBMessageObject message];
        msg.text = text;
        msg.imageObject = imageObject;
        WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:msg authInfo:authRequest access_token:nil];
        [WeiboSDK sendRequest:request];
    }
}

#pragma mark - Public API

- (void)shareToWechatSession {
    [self shareToWechatSessionWithText:@"微信文本分享内容"];
}

- (void)shareToWechatTimeline {
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"微信朋友圈标题";
    message.description = @"微信朋友圈内容";
    [message setThumbImage:[UIImage imageNamed:SHARE_ICON]];
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = @"微信朋友圈链接";
    message.mediaObject = ext;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req];
}

- (void)shareToQZone {
    [self shareToQZoneWithText:@"QZone 文本内容"];
}

- (void)shareToQQSession {
    [self shareToQQSessionWithText:@"QQ 文本内容"];
}

- (void)shareToWeiBo {
    [self shareToWeiBoWithText:@"微博内容"];
}

// MARK: 从1.2版本开始改为发表情
- (void)shareImageToWeChatSession:(UIImage *)image {
    
    WXMediaMessage *message = [WXMediaMessage message];
    UIImage *thumb = [image resizedImageToFitInSize:THUMB_SIZE scaleIfSmaller:NO];
    [message setThumbImage:thumb];
    message.title = @"微信分享名称";
    NSData *imageData = UIImagePNGRepresentation(image);
    
    if (imageData) {
        WXEmoticonObject *ext = [WXEmoticonObject object];
        ext.emoticonData = imageData;
        message.mediaObject = ext;
    }
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
}

- (void)shareImageToWeChatTimeline:(UIImage *)image {
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"微信图片朋友圈标题";
    [message setThumbImage:[image resizedImageToFitInSize:THUMB_SIZE scaleIfSmaller:NO]];
    WXImageObject *ext = [WXImageObject object];
    ext.imageData = UIImagePNGRepresentation(image);
    message.mediaObject = ext;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}

- (void)shareImageToQQ:(UIImage *)image {
    NSData *imageData = UIImagePNGRepresentation(image);
    NSData *thumbData = UIImagePNGRepresentation([image resizedImageToFitInSize:THUMB_SIZE scaleIfSmaller:NO]);
    QQApiImageObject *obj = [QQApiImageObject objectWithData:imageData previewImageData:thumbData title:@"" description:@""];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:obj];
    [QQApiInterface sendReq:req];
}

#pragma mark - QQ Login

- (void)tencentDidNotLogin:(BOOL)cancelled {}
- (void)tencentDidLogin {}
- (void)tencentDidNotNetWork {}

@end
