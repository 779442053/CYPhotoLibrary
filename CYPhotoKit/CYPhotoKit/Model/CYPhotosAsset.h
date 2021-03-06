//
//  CYPhotoAsset.h
//  CYPhotoKit
//
//  Created by 董招兵 on 16/7/6.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
/**
 *  代表一个视频或者照片资源
 */
@interface CYPhotosAsset : NSObject

/** 代表一个图片或者视频 */
@property (nonatomic,strong,nullable) PHAsset *asset;

/** 缩略图  */
@property (nonatomic,strong,nullable) UIImage *thumbnail;

/**  原图  */
@property (nonatomic,strong,nullable) UIImage *originalImg;

/** 视频/图片的本地 url  */
@property (nonatomic,copy,nullable  ) NSURL   *imageUrl;

/** 选取后的图片/视频的二进制文件  */
@property (nonatomic,strong,nullable) NSData *imageData;
/**
 *  是否选中图片
 */
@property (nonatomic,assign,getter =isSelectImage) BOOL selectImage;

@end
