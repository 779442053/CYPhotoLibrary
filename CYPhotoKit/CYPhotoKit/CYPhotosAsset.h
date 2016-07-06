//
//  CYPhotoAsset.h
//  CYPhotoKit
//
//  Created by 董招兵 on 16/7/6.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
@interface CYPhotosAsset : NSObject

/** asset  */
@property (nonatomic,strong,nullable) PHAsset *asset;

/** thumbnail  */
@property (nonatomic,strong,nullable) UIImage *thumbnail;

/** originalImg  */
@property (nonatomic,strong,nullable) UIImage *originalImg;

/** imageUrl  */
@property (nonatomic,copy,nullable  ) NSURL   *imageUrl;

/** imageData  */
@property (nonatomic,strong,nullable) NSData *imageData;

@end
