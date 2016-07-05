//
//  UIViewController+ImagePickerController.m
//  CYNetworking-Demo
//
//  Created by dongzb on 16/1/9.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import "UIViewController+ImagePickerController.h"
#import <objc/runtime.h>
#import "CYAlertHandle.h"
const char oldDelegateKey;
const char completionHandlerKey;
const char allowsEditingKey;

@implementation UIViewController (ImagePickerController)

- (void)showImagePickerViewSourceType:(CYSourceType)type
                        allowsEditing:(BOOL)allowsEditing
                             callBack:(CompleteBlock)callBlock
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    switch (type) {
        case CYSourceTypePhotoLibrary:
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary ;
            break ;
        case CYSourceTypeCamera:
            sourceType = UIImagePickerControllerSourceTypeCamera ;
            break ;
        case CYSourceTypeSavedPhotosAlbum:
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum ;
            break ;
    }
    if (type == CYSourceTypeCamera) {
        BOOL isCameraSupport = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        if (!isCameraSupport) {
            [CYAlertHandle showAlertViewInViewController:self title:@"提示" message:@"打开手机相机失败!" cancelTitle:@"取消" otherTitle:nil destructive:nil callBack:nil];
            return;
        }
    }
    UIImagePickerController *pic = [[UIImagePickerController alloc] init];
    pic.allowsEditing            = allowsEditing;
    pic.sourceType               = sourceType;
    [self presentViewController:pic animated:YES completion:nil];
    if (callBlock) {
        id oldDelegate = objc_getAssociatedObject(self, &oldDelegateKey);
        if (oldDelegate == nil)
        {
            objc_setAssociatedObject(self, &oldDelegateKey, oldDelegate, OBJC_ASSOCIATION_ASSIGN);
        }
        NSNumber *editingNum = [NSNumber numberWithBool:allowsEditing];
        oldDelegate = pic.delegate;
        pic.delegate = (id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)self;
        objc_setAssociatedObject(self, &completionHandlerKey,callBlock, OBJC_ASSOCIATION_COPY);
        objc_setAssociatedObject(self, &allowsEditingKey, editingNum, OBJC_ASSOCIATION_COPY);
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
  __block  NSNumber *editingNum = objc_getAssociatedObject(self, &allowsEditingKey);
    BOOL canEditing = editingNum.boolValue;

    // UIImagePickerControllerOriginalImage
    UIImage *image = canEditing ?info[@"UIImagePickerControllerEditedImage"]:info[@"UIImagePickerControllerOriginalImage"];
    void(^CompleteBlock)(UIImage *image,NSDictionary *infoDict) = objc_getAssociatedObject(self, &completionHandlerKey);
    if (CompleteBlock) {
        CompleteBlock (image,info);
    }
    [self dismissViewControllerAnimated:YES completion:^{
        objc_removeAssociatedObjects(editingNum);
        objc_removeAssociatedObjects(CompleteBlock);
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
