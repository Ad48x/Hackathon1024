//
//  NSString+Extension.h
//  Hackathon1024
//
//  Created by cyan on 15/9/12.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@interface NSString (Extension)

- (NSString *)trimmedString;

- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;

- (NSString *)base64EncodedString;
- (NSString *)base64DecodedString;

- (NSString *)MD5;

@end
