//
//  CYPhotoNavigationController.h
//  CYPhotoKit
//
//  Created by dongzb on 16/3/20.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYPhotoNavigationController : UINavigationController

/**
 *  类方法获取一个 photosNavigationController
 */
+ (_Nullable instancetype)showPhotosViewController;

/**
 *  禁用 init new等方法生成实例
 */
- (_Nullable instancetype)init UNAVAILABLE_ATTRIBUTE;

+ (_Nullable instancetype)new UNAVAILABLE_ATTRIBUTE;

@end
