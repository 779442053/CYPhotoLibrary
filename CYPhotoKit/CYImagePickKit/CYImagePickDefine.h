//
//  CYImagePickDefine.h
//  CYNetworking-Demo
//
//  Created by dongzb on 16/1/9.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#ifndef CYImagePickDefine_h
#define CYImagePickDefine_h
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CYSourceType) {
    CYSourceTypePhotoLibrary,  /**< 相册 */
    CYSourceTypeCamera,  /**< 相机 */
    CYSourceTypeSavedPhotosAlbum  /**< 只打开相册的照片 */
};

/**
 *  选取完照片后的回调
 *  @param image    选择的 image
 *  @param infoDict  图片信息的字典
 */
typedef void(^CompleteBlock)(UIImage *image,NSDictionary *infoDict);

/* 上传图片的标题 不设置则 actionTitle 为 nil */
#define K_UploadImageTitle @""
/* 默认是 拍照 */
#define K_OpenCameraTitle @""
/* 默认是 从相册选取 */
#define K_OpenPhotoLibraryTitle @""

#endif /* CYImagePickDefine_h */
