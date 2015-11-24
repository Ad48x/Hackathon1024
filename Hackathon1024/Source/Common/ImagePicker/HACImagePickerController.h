//
//  HACImagePickerController.h
//  MyBookio
//
//  Created by cyan on 14-3-16.
//  Copyright (c) 2014年 TangPin. All rights reserved.
//

#import "HACBaseController.h"

typedef void (^HACImagePickCallback)(UIImage *image);

@interface HACImagePickerController: HACBaseController <
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate
>

@property (nonatomic, copy) HACImagePickCallback cameraCallback;
@property (nonatomic, copy) HACImagePickCallback photosCallback;

- (void)showImagePickers;
- (void)pickImageFromCamera:(HACImagePickCallback)callback;
- (void)pickImageFromPhotos:(HACImagePickCallback)callback;

@end
