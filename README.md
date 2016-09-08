# CYPhotoLibrary
自定义相册,支持单选 多选 查看相片 视频等


如果要打开设置隐私界面 修改plist文件，在里面添加 URL types 并设置一项URL Schemes为prefs

详细过程可以查看简书

http://www.jianshu.com/p/dc2c07449d90


CYPhotosAsset : 代表单个照片或者视频资源
/**
*   图片的原始资源
*/
@property (nonatomic,strong,nullable) PHAsset *asset;

/** 缩略图片  */
@property (nonatomic,strong,nullable) UIImage *thumbnail;

/** 原图片  */
@property (nonatomic,strong,nullable) UIImage *originalImg;

/** 图片的 url  */
@property (nonatomic,copy,nullable  ) NSURL   *imageUrl;

/**  图片的二进制数据  */
@property (nonatomic,strong,nullable) NSData *imageData;

// 初始化一个照片选择器控制器

CYPhotoNavigationController *cyNavigationController = [CYPhotoNavigationController showPhotosViewController];
[self presentViewController:cyNavigationController animated:YES completion:nil];
// 做多可以选择几张图片
cyNavigationController.maxPickerImageCount = 10;

// 代理和 block 可以二选一
cyNavigationController.cyPhotosDelegate             = self;

cyNavigationController.completionBlock = ^(NSArray *result) {


};


#pragma mark - CYPhotoNavigationControllerDelegate

/**
*  照片选择器完成选择照片协议方法
*/
- (void)cyPhotoNavigationController:(CYPhotoNavigationController *_Nullable)controller didFinishedSelectPhotos:(NSArray *_Nullable)result {

[self.dataSource removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, self.dataSource.count-1)]];
__weak typeof(self)weakSelf = self;

[result enumerateObjectsUsingBlock:^(CYPhotosAsset *photoAsset, NSUInteger idx, BOOL * _Nonnull stop) {

    __strong typeof(weakSelf)strongSelf = weakSelf;
    CYPhoto *photo = [CYPhoto new];
    photo.type     = CYPhotoAssetTypePhoto;
    photo.image    = nil;
    photo.asset    = photoAsset.asset;
    [strongSelf.dataSource addObject:photo];

}];


[self.collectionView reloadData];

}
