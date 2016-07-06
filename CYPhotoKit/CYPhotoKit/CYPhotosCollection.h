//
//  CYPhotosAsset.h
//  CYPhotoKit
//
//  Created by 董招兵 on 16/7/5.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
/**
 *  代表一个集合可能是一个相册组也可能是所有 PHAsset 的集合
 */
@interface CYPhotosCollection : NSObject

/** fetchResult  */
@property (nonatomic,strong,nullable) PHFetchResult *fetchResult;

/** localTitle  */
@property (nonatomic,copy,nullable  ) NSString      *localizedTitle;

/** count */
@property (nonatomic,nullable,copy  ) NSString      *count;

/** thumbnail  */
@property (nonatomic,strong,nullable) UIImage       *thumbnail;

@end
