//
//  HACLeanUtility.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACLeanUtility.h"

@interface HACLeanUtility()<AVIMClientDelegate>

@property (nonatomic, strong) AVIMClient *client;

@end

@implementation HACLeanUtility

// LeanCloud Samples

- (void)runTestCases {
    [self objectQuery];
}

- (void)objectInsert {
    AVObject *content = [AVObject objectWithClassName:@"iOS_Client_Test"];
    content[@"dict"] = @{ @"k1": @"v1", @"k2": @"v2", @"k3": @"v3" };
    content[@"author"] = @"Cyan";
    content[@"value"] = @(100);
    [content saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"save result: %d", succeeded);
        if (succeeded) {
            // query
            AVQuery *query = [AVQuery queryWithClassName:@"iOS_Client_Test"];
            AVObject *object = [query getFirstObject];
            NSLog(@"object: %@", object);
        }
    }];
}

- (void)objectFetch {
    // fecth
    AVObject *object = [AVObject objectWithoutDataWithClassName:@"iOS_Client_Test" objectId:@"562395bb60b2b199f74e6d7b"];
    object[@"value"] = @(200000);
    [object incrementKey:@"Value"];
    [object addObjectsFromArray:@[ @1, @"2", @(3.0) ] forKey:@"data_list"];
    object[@"newValue"] = @"NewValue";
    [object save];
}

- (void)objectQuery {
    // query
    AVQuery *query = [AVQuery queryWithClassName:@"iOS_Client_Test"];
    [query whereKey:@"value" greaterThanOrEqualTo:@(2000)];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"objects: %@", objects);
    }];
}

- (void)fileUpload {
    UIImage *image = [UIImage imageNamed:@"image.jpeg"];
    NSData *jpegData = UIImageJPEGRepresentation(image, 0.8);
    AVFile *file = [AVFile fileWithName:@"wallpaper.jpeg" data:jpegData];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"image save ok!");
    } progressBlock:^(NSInteger percentDone) {
        NSLog(@"upload percent: %d", (int)percentDone);
    }];
}

- (void)fileBind {
    AVObject *object = [AVObject objectWithoutDataWithClassName:@"iOS_Client_Test" objectId:@"562395bb60b2b199f74e6d7b"];
    [AVFile getFileWithObjectId:@"5623aa0eddb24819b83bc410" withBlock:^(AVFile *file, NSError *error) {
        if (!error) {
            NSLog(@"get file ok!");
            // bind
            object[@"attachment"] = file;
            [object saveInBackground];
        }
    }];
}

- (void)userSignUp {
    AVUser *user = [AVUser user];
    user.username = @"Cyan";
    user.password = @"zy123456";
    user.email = @"log.e@qq.com";
    user[@"phone"] = @"18688993570";
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"signUp: %d", succeeded);
    }];
}

- (void)userBind {
    AVUser *user = [AVUser user];
    user.username = @"Cyan";
    user.mobilePhoneNumber = @"18688993570";
    user.email = @"cyan.me@qq.com";
    user.password = @"zy123456";
    NSError *error = nil;
    [user signUp:&error];
    NSLog(@"error: %@", error);
}

- (void)im {
    // Tom 创建了一个 client
    self.client = [[AVIMClient alloc] init];
    self.client.delegate = self;
    // Tom 用自己的名字作为 ClientId 打开 client
    [self.client openWithClientId:@"Tom" callback:^(BOOL succeeded, NSError *error) {
        // Tom 建立了与 Jerry 的会话
        [self.client createConversationWithName:@"猫和老鼠" clientIds:@[@"Jerry"] callback:^(AVIMConversation *conversation, NSError *error) {
            // Tom 发了一条消息给 Jerry
            [conversation sendMessage:[AVIMTextMessage messageWithText:@"耗子，起床！" attributes:nil] callback:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"发送成功！");
                }
            }];
        }];
    }];
}

#pragma mark - AVIM

- (void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message {
    
}

- (void)conversation:(AVIMConversation *)conversation didReceiveCommonMessage:(AVIMMessage *)message {
    
}

@end
