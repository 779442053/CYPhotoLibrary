//
//  CYPhotoNavigationController.m
//  CYPhotoKit
//
//  Created by dongzb on 16/3/20.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import "CYPhotoNavigationController.h"
#import "CYPhotoGroupController.h"

@interface CYPhotoNavigationController ()

@property (nonatomic,strong) CYPhotoGroupController *cyPhotoGroupViewController;

@end

@implementation CYPhotoNavigationController

+ (_Nullable instancetype)showPhotosViewController
{
    CYPhotoGroupController *cyPhotoGroupViewController = [[CYPhotoGroupController alloc] init];
    
    CYPhotoNavigationController *navigationController = [[CYPhotoNavigationController alloc] initWithRootViewController:cyPhotoGroupViewController];
    
 
    return navigationController;
}

- (void)back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (instancetype)init{
    if (self = [super init]) {
        [self isEmpty];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target: self action:@selector(back)];

    }
    return self;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
        [self isEmpty];
    }
    return self;
}
- (void)isEmpty {
    UIViewController *rootViewController = [self.viewControllers firstObject];
    BOOL result = (!rootViewController||![rootViewController isKindOfClass:[CYPhotoGroupController class]]);
    NSAssert(!result, @"\n\n请指定 CYPhotoGroupController类型的 rootViewController 或者调用 shareInstance 方法\n");
}

- (void)viewDidLoad{

    [super viewDidLoad];

}


- (CYPhotoGroupController *)cyPhotoGroupViewController{
    if (!_cyPhotoGroupViewController) {
        _cyPhotoGroupViewController = [[CYPhotoGroupController alloc] init];
    }
    return _cyPhotoGroupViewController;
}

@end
