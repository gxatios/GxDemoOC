//
//  ZXUploadImage.m
//  GxDemoOC
//
//  Created by zhxGx on 2017/9/4.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "ZXUploadImage.h"
static ZXUploadImage *zxUploadImage = nil;

@implementation ZXUploadImage
+ (ZXUploadImage *)shareUploadImage {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        zxUploadImage = [[ZXUploadImage alloc] init];
    });
    return zxUploadImage;
}
- (void)showActionSheetInFatherViewController:(UIViewController *)fatherVC
                                     delegate:(id<ZXUploadImageDelegate>)aDelegate {
    zxUploadImage.uploadImageDelegate = aDelegate;
    _fatherViewController = fatherVC;
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"从手机相册上传", @"相机拍照", nil];
    [sheet showInView:fatherVC.view];
}
- (void)showActionSheetInFatherViewController:(UIViewController *)fatherVC
                                        block:(void(^)(UIImage *backImage))back{
    self.upImageBlock = back;
    _fatherViewController = fatherVC;
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"从手机相册上传", @"相机拍照", nil];
    [sheet showInView:fatherVC.view];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self fromPhotos];
    }else if (buttonIndex == 1) {
        [self createPhotoView];
    }
}
#pragma mark - 头像(相机和从相册中选择)
- (void)createPhotoView {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
        imagePC.sourceType                = UIImagePickerControllerSourceTypeCamera;
        imagePC.delegate                  = self;
        imagePC.allowsEditing             = YES;
        [_fatherViewController presentViewController:imagePC
                                            animated:YES
                                          completion:^{
                                          }];
    }else {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                         message:@"该设备没有照相机"
                                                        delegate:nil
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
        [alert show];
    }
}
//图片库方法(从手机的图片库中查找图片)
- (void)fromPhotos {
    UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
    imagePC.sourceType                = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePC.delegate                  = self;
    imagePC.allowsEditing             = YES;
    [_fatherViewController presentViewController:imagePC
                                        animated:YES
                                      completion:^{
                                      }];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        if (self.upImageBlock) {
            self.upImageBlock(image);
        }
    }];

}
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    [picker dismissViewControllerAnimated:YES completion:^{
//    }];
//    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
//    /**
//     *  上传用户头像
//     */
//    if (self.upImageBlock) {
//        self.upImageBlock(image);
//    }
////    
////    if (self.uploadImageDelegate && [self.uploadImageDelegate respondsToSelector:@selector(uploadImageToServerWithImage:)]) {
////        [self.uploadImageDelegate uploadImageToServerWithImage:image];
////    }
//}

@end
