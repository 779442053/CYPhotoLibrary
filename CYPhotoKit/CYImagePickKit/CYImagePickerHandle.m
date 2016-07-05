//
//  CYImagePickerHandle.m
//  CYNetworking-Demo
//
//  Created by dongzb on 16/1/9.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import "CYImagePickerHandle.h"
#import "CYAlertHandle.h"
#import "CYImagPickerViewController.h"

@implementation CYImagePickerHandle
/**
 *  展示选择相片和拍照的actionSheet
 *
 *  @param viewController 当前控制器
 *  @param callBack       选择完相片后的回调
 */
+ (void)showCYImagePicerViewControllerInViewController:(UIViewController*)viewController callBack:(CompleteBlock)callBack
{
    NSString *title = [K_UploadImageTitle length]==0?nil:K_UploadImageTitle;
    NSString *cameraTitle = K_OpenCameraTitle.length==0?@"拍照":K_OpenCameraTitle;
    NSString *photoLibraryTitle = K_OpenPhotoLibraryTitle.length ==0?@"从手机相机选择":K_OpenPhotoLibraryTitle;
    [CYAlertHandle showActionSheetViewInViewController:viewController title:title message:nil cancelTitle:@"取消" otherTitle:@[cameraTitle,photoLibraryTitle] destructive:nil callBack:^(NSInteger index) {
        if (index!=0) {
            CYSourceType type = index ==1?CYSourceTypeCamera:CYSourceTypePhotoLibrary;
            [CYImagPickerViewController showImagePickerViewContollerInViewController:viewController sourceType:type allowsEditing:YES callBack:callBack];
        }
    }];
}
@end
