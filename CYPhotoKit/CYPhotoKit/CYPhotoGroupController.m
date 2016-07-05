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
#import "CYPhotosManager.h"
#import "CYPhotoListViewController.h"
#import "CYPhotosAsset.h"

static NSString *const photoLibrayGroupCell   = @"CYPhotoLibrayGroupCell";
static NSString *const smartAlbumsIdentifier = @"smartAlbumsIdentifier";


@interface CYPhotoGroupController () <PHPhotoLibraryChangeObserver,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray     *sectionFetchResults;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CYPhotoGroupController

- (void)viewDidLoad{
    [super viewDidLoad];

    self.title                             = @"照片";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismiss)];

    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];

    CYPhotosManager *photosManager         = [CYPhotosManager defaultManager];

    self.sectionFetchResults = @[[photosManager requestAllPhotosOptions], [photosManager requestSmartAlbums], [photosManager requestTopLevelUserCollections]];
  
    [self.view addSubview:self.tableView];
    
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

    NSArray *fetchResult = self.sectionFetchResults[indexPath.section];
    CYPhotosAsset *photoAsset = fetchResult[indexPath.row];

    cell.photoImageView.image = photoAsset.thumbnail;
    cell.titleLabel.text      = [NSString stringWithFormat:@"%@ (%@)",photoAsset.localizedTitle,photoAsset.count];

    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *fetchResult = self.sectionFetchResults[indexPath.section];
    CYPhotosAsset *photoAsset = fetchResult[indexPath.row];
 
    
    CYPhotoListViewController *photoDetailVC = [[CYPhotoListViewController alloc] init];
    photoDetailVC.fetchResult                = photoAsset.fetchResult;
    photoDetailVC.title                      = photoAsset.localizedTitle;
    [self.navigationController pushViewController:photoDetailVC animated:YES];

}


- (void)dealloc {
    
    NSLog(@"-- %s ---\n",__func__);

    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}

@end
