//
//  ZXUploadImage.h
//  GxDemoOC
//
//  Created by zhxGx on 2017/9/4.
//  Copyright © 2017年 gx. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ZXUPLOAD_IMAGE [ZXUploadImage shareUploadImage]
@protocol ZXUploadImageDelegate <NSObject>
@optional
- (void)uploadImageToServerWithImage:(UIImage *)image;
@end

typedef void(^ZXUploadImageBlock)(UIImage *image);

@interface ZXUploadImage : NSObject< UIActionSheetDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate>
{
    //如果你调不出来UIViewController,请添加UIKit头文件
    UIViewController *_fatherViewController;
}
@property (nonatomic, weak) id <ZXUploadImageDelegate> uploadImageDelegate;
@property (nonatomic, copy) ZXUploadImageBlock upImageBlock;
//单例方法
+ (ZXUploadImage *)shareUploadImage;
//弹出选项的方法
- (void)showActionSheetInFatherViewController:(UIViewController *)fatherVC
                                     delegate:(id<ZXUploadImageDelegate>)aDelegate;

//弹出选项的方法
- (void)showActionSheetInFatherViewController:(UIViewController *)fatherVC
                                     block:(void(^)(UIImage *backImage))back;
@end
