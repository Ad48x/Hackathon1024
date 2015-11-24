//
//  HACImagePickerController.m
//  MyBookio
//
//  Created by cyan on 14-3-16.
//  Copyright (c) 2014年 TangPin. All rights reserved.
//

#import "HACImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define kSorry              i18n(@"Sorry")
#define kCameraNotFound     i18n(@"CameraNotFound")
#define kOkay               i18n(@"Okay")

@interface HACImagePickerController()

@end

@implementation HACImagePickerController

- (void)dealloc {
    _cameraCallback = nil;
    _photosCallback = nil;
}

- (void)pickImageFromCamera:(HACImagePickCallback)callback {
    self.cameraCallback = callback;
    [self pickImageFromCamera];
}

- (void)pickImageFromPhotos:(HACImagePickCallback)callback {
    self.photosCallback = callback;
    [self pickImageFromPhotos];
}

- (void)pickImageFromCamera {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        [UIAlertView bk_showAlertViewWithTitle:kSorry
                                       message:kCameraNotFound
                             cancelButtonTitle:kOkay
                             otherButtonTitles:nil
                                       handler:nil];
    }
}

- (void)pickImageFromPhotos {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePicker Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];

    if ([info[UIImagePickerControllerMediaType] isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        if (image) {
            if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary &&
                self.photosCallback) {
                self.photosCallback(image);
            } else if (picker.sourceType == UIImagePickerControllerSourceTypeCamera &&
                       self.cameraCallback) {
                self.cameraCallback(image);
            }
        }
    }
}

- (void)showImagePickers {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    @weakify(self)
    UIAlertAction *photosAction = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self)
        [self pickImageFromPhotos];
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"使用摄像头拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self)
        [self pickImageFromCamera];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:photosAction];
    [alertController addAction:cameraAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
