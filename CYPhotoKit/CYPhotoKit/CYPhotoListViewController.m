
//
//  CYPhotoListViewController.m
//  CYPhotoKit
//
//  Created by 董招兵 on 16/7/5.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import "CYPhotoListViewController.h"
#import <Photos/Photos.h>

static CGFloat const itemMarigin = 5.0f;

@interface CYPhotoListViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) PHCachingImageManager *imageManager;
@property (nonatomic,assign) CGSize itemSize;
@end

@implementation CYPhotoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 

    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat itemW   = (screenW - 3*itemMarigin)/4;
    CGFloat itemH   = itemW;
    self.itemSize   = CGSizeMake(itemW, itemH);

    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    self.collectionView.alwaysBounceVertical = YES;
    

}


- (PHCachingImageManager *)imageManager {
    if (!_imageManager) {
        _imageManager = [[PHCachingImageManager alloc] init];
    }
    return _imageManager;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setFetchResult:(PHFetchResult<PHAsset *> *)fetchResult {
    _fetchResult    = fetchResult;
 

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.fetchResult.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];

   __block UIImageView *imageView     = [[UIImageView alloc] init];
    imageView.frame            = cell.contentView.bounds;
    imageView.contentMode   = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    cell.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:imageView];
    
    PHAsset *asset  = [self.fetchResult objectAtIndex:indexPath.item];
    
    
    [self.imageManager requestImageForAsset:asset
                                 targetSize:CGSizeMake(150.0f, 150.0f)
                                contentMode:PHImageContentModeDefault
                                    options:nil
                              resultHandler:^(UIImage *result, NSDictionary *info) {
                                  
                                  NSLog(@"---%@",result);
                                  // Set the cell's thumbnail image if it's still showing the same asset.
                                  imageView.image = result;
                              }];
    
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.itemSize;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(itemMarigin, 0.0f, itemMarigin, 0.0f);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return itemMarigin;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return itemMarigin;
}
- (void)dealloc {
    
    NSLog(@"-- %s ---",__func__);
    
}
@end
