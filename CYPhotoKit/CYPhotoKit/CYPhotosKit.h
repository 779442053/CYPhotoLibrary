//
//  CYPhotosKit.h
//  CYPhotoKit
//
//  Created by 董招兵 on 16/7/5.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#ifndef CYPhotosKit_h
#define CYPhotosKit_h

#import "CYPhotoNavigationController.h"
#import "CYPhotoGroupController.h"
#import "CYPhotosManager.h"
#import "CYPhotoLibrayGroupCell.h"
#import "CYPhotoListViewController.h"

typedef void (^CYRun)(void);


#define dispatch_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#define dispatch_global_safe(block)   if (![NSThread isMainThread]) {\
block();\
} else {\
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);\
}

/**
 *  最大选取照片的数量
 */
static NSInteger const maxSelectPhotoCount  = 9;


#endif /* CYPhotosKit_h */
