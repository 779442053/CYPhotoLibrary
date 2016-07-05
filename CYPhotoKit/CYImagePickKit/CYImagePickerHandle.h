//
//  CYImagePickerHandle.h
//  CYNetworking-Demo
//
//  Created by dongzb on 16/1/9.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CYImagePickDefine.h"
@interface CYImagePickerHandle : NSObject
/**
 *  展示选择相片和拍照的actionSheet
 *
 *  @param viewController 当前控制器
 *  @param callBack       选择完相片后的回调
 */
+ (void)showCYImagePicerViewControllerInViewController:(UIViewController*)viewController callBack:(CompleteBlock)callBack;

@end
