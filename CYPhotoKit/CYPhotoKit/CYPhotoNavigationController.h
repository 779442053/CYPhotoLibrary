//
//  CYPhotoNavigationController.h
//  CYPhotoKit
//
//  Created by dongzb on 16/3/20.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PhotosCompletion)(NSArray *_Nullable result);

@protocol CYPhotoNavigationControllerDelegate;

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

/** completionBlock  */
@property (nonatomic,copy,nullable) PhotosCompletion completionBlock;

/** cyPhotosDelegate */
@property (nonatomic,weak,nullable) id <CYPhotoNavigationControllerDelegate> cyPhotosDelegate;

@end

@protocol CYPhotoNavigationControllerDelegate <NSObject,UINavigationControllerDelegate>

@optional

/**
 *  照片选择器完成选择照片
 */
- (void)cyPhotoNavigationController:(CYPhotoNavigationController *_Nullable)controller didFinishedSelectPhotos:(NSArray *_Nullable)result;

@end