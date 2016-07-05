//
//  CYPhoto.h
//  CYPhotoKit
//
//  Created by dongzb on 16/3/20.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CYPhotoAssetType) {
    CYPhotoAssetTypeAdd,
    CYPhotoAssetTypePhoto
};

@interface CYPhoto : NSObject

@property (nonatomic,assign) CYPhotoAssetType type;

@property (nonatomic,strong) UIImage *image;

@end
