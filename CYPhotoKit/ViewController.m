//
//  ViewController.m
//  CYPhotoKit
//
//  Created by dongzb on 16/3/20.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import "ViewController.h"
#import "CYPhoto.h"
#import "CYImagePickDefine.h"
#import "CYCollectionViewCell.h"
#import "CYImagePickerHandle.h"

#import "CYPhotosAsset.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout , CYPhotoNavigationControllerDelegate>
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.collectionView registerClass:[CYCollectionViewCell class] forCellWithReuseIdentifier:@"CYCollectionViewCell"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self loadDatas];
    
}
- (void)loadDatas{
    
    CYPhoto *photo = [[CYPhoto alloc] init];
    photo.type     = CYPhotoAssetTypeAdd;
    photo.image    = [UIImage imageNamed:@"hubs_uploadImage"];
    [self.dataSource addObject:photo];
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
    
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak  CYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYCollectionViewCell" forIndexPath:indexPath];
    CYPhoto *photo = self.dataSource[indexPath.item];
    
    if (photo.type == CYPhotoAssetTypeAdd) {
        cell.imageView.image = photo.image;
    } else {
        
        PHImageManager *imageManager = [PHImageManager defaultManager];
        [imageManager requestImageForAsset:photo.asset targetSize:CGSizeMake(200.0f, 200.0f) contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            cell.imageView.image = result;
        }];
        
    }
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CYPhoto *photo = self.dataSource[indexPath.item];
    if (photo.type == CYPhotoAssetTypePhoto) return;
    
    CYPhotoNavigationController *cyNavigationController = [CYPhotoNavigationController showPhotosViewController];
    [self presentViewController:cyNavigationController animated:YES completion:nil];
    cyNavigationController.maxPickerImageCount = 9;
    cyNavigationController.cyPhotosDelegate             = self;
    
//    cyNavigationController.completionBlock = ^(NSArray *result) {
//        
//        
//    };

}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 10, 10, 10);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (self.view.frame.size.width-50)/4;
    CGFloat height = width;
    return CGSizeMake(width, height);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

#pragma mark - CYPhotoNavigationControllerDelegate

/**
 *  照片选择器完成选择照片
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
@end
