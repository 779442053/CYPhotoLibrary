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
#import "CYPhotoNavigationController.h"
#import "CYPhotoGroupController.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
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
    photo.image    = [UIImage imageNamed:@"xiangqing_tianjiatupian"];
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
    
    CYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYCollectionViewCell" forIndexPath:indexPath];
    CYPhoto *photo = self.dataSource[indexPath.item];

    cell.imageView.image = photo.image;
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CYPhoto *photo = self.dataSource[indexPath.item];
    if (photo.type == CYPhotoAssetTypePhoto) return;
    CYPhotoNavigationController *cyNavigationController = [CYPhotoNavigationController showPhotosViewController];
    [self presentViewController:cyNavigationController animated:YES completion:nil];
//    __weak typeof(self)weakSelf = self;
//    
//    [CYImagePickerHandle showCYImagePicerViewControllerInViewController:self callBack:^(UIImage *image, NSDictionary *infoDict) {
//        __strong typeof(weakSelf)strongSelf = weakSelf;
//        
//        if (!image) return ;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [strongSelf.collectionView performBatchUpdates:^{
//                CYPhoto *photo = [CYPhoto new];
//                photo.image    = image;
//                photo.type     = CYPhotoAssetTypePhoto;
//                [strongSelf.dataSource insertObjects:@[photo] atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 1)]];
//                [strongSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
//                
//            } completion:^(BOOL finished) {
//                
//            }];
//        });
//    }];
    
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

@end
