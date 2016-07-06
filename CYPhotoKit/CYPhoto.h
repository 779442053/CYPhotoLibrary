//
//  CYPhoto.h
//  CYPhotoKit
//
//  Created by dongzb on 16/3/20.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

typedef NS_ENUM(NSInteger,CYPhotoAssetType) {
    CYPhotoAssetTypeAdd,
    CYPhotoAssetTypePhoto
};

@interface CYPhoto : NSObject

@property (nonatomic,assign) CYPhotoAssetType type;

@property (nonatomic,strong,nullable) UIImage *image;

/** asset  */
@property (nonatomic,strong,nullable) PHAsset *asset;



@end
