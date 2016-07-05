//
//  CYPhotoListViewController.h
//  CYPhotoKit
//
//  Created by 董招兵 on 16/7/5.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface CYPhotoListViewController : UIViewController

/** PHFetchResult  */
@property (nonatomic,strong,nullable) PHFetchResult <PHAsset *>*fetchResult;


@end
