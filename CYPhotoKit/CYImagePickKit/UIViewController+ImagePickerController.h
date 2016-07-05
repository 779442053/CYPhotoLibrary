//
//  UIViewController+ImagePickerController.h
//  CYNetworking-Demo
//
//  Created by dongzb on 16/1/9.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYImagePickDefine.h"
@interface UIViewController (ImagePickerController)<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

/**
 *  弹出一个照片选择器
 *
 *  @param viewController    当前的控制器
 *  @param type              相机或相册
 *  @param allowsEditing     是否可以编辑图片
 *  @param callBlock         回调 blcok
 */
- (void)showImagePickerViewSourceType:(CYSourceType)type
                        allowsEditing:(BOOL)allowsEditing
                             callBack:(CompleteBlock)callBlock;

@end
