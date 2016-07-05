//
//  CYImagPickerViewController.m
//  CYNetworking-Demo
//
//  Created by 董招兵 on 16/1/8.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import "CYImagPickerViewController.h"
#import "CYImagePickDefine.h"
#import "UIViewController+ImagePickerController.h"

@interface CYImagPickerViewController ()

@end

@implementation CYImagPickerViewController

/**
 *  弹出一个照片选择器
 *
 *  @param type          相机或相册
 *  @param allowsEditing 是否可以编辑图片
 *  @param callBlock     回调 blcok
 */
+ (void)showImagePickerViewContollerInViewController:(UIViewController*)viewController
                                          sourceType:(CYSourceType)type
                                       allowsEditing:(BOOL)allowsEditing
                                            callBack:(CompleteBlock)callBlock
{
    [viewController showImagePickerViewSourceType:type allowsEditing:allowsEditing callBack:callBlock];
}

@end
