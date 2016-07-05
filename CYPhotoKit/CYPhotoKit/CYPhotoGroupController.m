//
//  CYPhotoGroupController.m
//  CYPhotoKit
//
//  Created by dongzb on 16/3/20.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import "CYPhotoGroupController.h"
#import <Photos/Photos.h>
#import "CYPhotoLibrayGroupCell.h"

static NSString *const photoLibrayGroupCell   = @"CYPhotoLibrayGroupCell";
static NSString *const smartAlbumsIdentifier = @"smartAlbumsIdentifier";


@interface CYPhotoGroupController () <PHPhotoLibraryChangeObserver,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray     *sectionFetchResults;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CYPhotoGroupController

- (void)viewDidLoad{
    [super viewDidLoad];

    
    self.title = @"照片";
    self.view.backgroundColor = [UIColor yellowColor];
    
    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismiss)];
    
    
    // Create a PHFetchResult object for each section in the table view.
    PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    
    // 过滤掉没有相册的 group
    __block NSMutableArray *photoGroups = [NSMutableArray array];
    [smartAlbums enumerateObjectsUsingBlock:^(PHAssetCollection *collection, NSUInteger idx, BOOL * _Nonnull stop) {
        PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        if ([self needAddPhotoGroup:collection] && assetsFetchResult.count>0) {
            [photoGroups addObject:collection];
        }
    }];
    
    
    __block NSMutableArray *userPhotoGroups = [NSMutableArray array];
    [topLevelUserCollections enumerateObjectsUsingBlock:^(PHAssetCollection *collection, NSUInteger idx, BOOL * _Nonnull stop) {
        PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        if (assetsFetchResult.count>0) {
            [userPhotoGroups addObject:collection];
        }
    }];
    
    // Store the PHFetchResult objects and localized titles for each section.
    self.sectionFetchResults = @[allPhotos, photoGroups, userPhotoGroups];
  
    [self.view addSubview:self.tableView];
    
    
}
/**
 *  每个相册组最近一张照片的缩略图
 */
- (UIImage *)getNearByImage:(PHAssetCollection *)collection {
    // Configure the AAPLAssetGridViewController with the asset collection.
    PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    if (assetsFetchResult.count ==0) {
        return [UIImage imageNamed:@"xiangqing_add2"];
    }
    PHAsset *asset =[assetsFetchResult firstObject];
    return [self getImageWithAsset:asset];
    
}
/**
 *  根据已 asset 获取一张图片资源
 */
- (UIImage *)getImageWithAsset:(PHAsset *)asset {
    PHImageManager *imageManager = [PHImageManager defaultManager];
    __block  UIImage *sourceImage = nil;
    [imageManager requestImageForAsset:asset targetSize:CGSizeMake(1000.0f, 1000.0f) contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        sourceImage = result;
    }];
    return sourceImage;
}

/**
 *  判断是否将一个photoGroup展示出来
 */
- (BOOL)needAddPhotoGroup:(PHAssetCollection *)collection {
    if ([collection.localizedTitle isEqualToString:@"Screenshots"]) {
        return YES;
    }else if ([collection.localizedTitle isEqualToString:@"Selfies"]) {
        return YES;
    }else if ([collection.localizedTitle isEqualToString:@"Recently Added"]) {
        return YES;
    }else if ([collection.localizedTitle isEqualToString:@"Favorites"]) {
        return YES;
    }else if ([collection.localizedTitle isEqualToString:@"Videos"]) {
        return YES;
    }
    return NO;
}
/**
 *  得到每个组的中文名称
 */
- (NSString *)getPhotoGroupName:(PHCollection *)collection {
    if ([collection.localizedTitle isEqualToString:@"Screenshots"]) {
        return @"屏幕快照";
    }else if ([collection.localizedTitle isEqualToString:@"Selfies"]) {
        return @"自拍";
    }else if ([collection.localizedTitle isEqualToString:@"Recently Added"]) {
        return @"最新添加";
    }else if ([collection.localizedTitle isEqualToString:@"Favorites"]) {
        return @"个人收藏";
    }else if ([collection.localizedTitle isEqualToString:@"Videos"]) {
        return @"视频";
    }
    return collection.localizedTitle;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"CYPhotoLibrayGroupCell" bundle:nil] forCellReuseIdentifier:photoLibrayGroupCell];
    }
    return _tableView;
}

- (void)dismiss {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - 相册资源发生改变

- (void)photoLibraryDidChange:(PHChange *)changeInstance {



}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionFetchResults.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 1;
    else {
        
        PHFetchResult *result = self.sectionFetchResults[section];
        return result.count;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CYPhotoLibrayGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:photoLibrayGroupCell];

    UIImage *img    = nil;
    NSString *title = nil;
    
    if (indexPath.section == 0) {
        PHFetchResult *collectonResults = [self.sectionFetchResults objectAtIndex:indexPath.section];
        PHAsset *asset = [collectonResults firstObject];
        img= [self getImageWithAsset:asset];
        title = [NSString stringWithFormat:@"相机胶卷 (%lu)",(unsigned long)collectonResults.count];
    } else {
        
        PHFetchResult *fetchResult = self.sectionFetchResults[indexPath.section];
        PHCollection *collection = fetchResult[indexPath.row];
        PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:(PHAssetCollection *)collection options:nil];
        
        title  = [NSString stringWithFormat:@"%@ (%@)",[self getPhotoGroupName:collection],@(assetsFetchResult.count)];
        img = [self getNearByImage:(PHAssetCollection *)collection];
        
    }
    
    cell.photoImageView.image = img;
    cell.titleLabel.text      = title;

    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
    }else {
        PHFetchResult *fetchResult = self.sectionFetchResults[indexPath.section];
        PHCollection *collection = fetchResult[indexPath.row];
        // Configure the AAPLAssetGridViewController with the asset collection.
        PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
        PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];

//        [assetsFetchResult enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL * _Nonnull stop) {
//            
//            PHImageManager *imageManager = [PHImageManager defaultManager];
//            [imageManager requestImageForAsset:asset targetSize:CGSizeMake(10000.0f, 10000.0f) contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//               
//                NSLog(@"---%@",result);
//                
//                
//            }];
//            
//        }];
        
    }
}


- (void)dealloc {
    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}

@end
