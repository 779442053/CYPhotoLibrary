//
//  CYAlertKit.m
//  CYAlertController
//
//  Created by 董招兵 on 16/1/7.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import "CYAlertHandle.h"

@implementation CYAlertHandle

/**
 *  弹出一个 alertView 类型的 alertController
 *
 *  @param viewController  当前控制器
 *  @param title          标题
 *  @param message        消息
 *  @param cancel         取消标题
 *  @param otherTitles    其他标题 依次放数组里将来索引从1 开始
 *  @param destructive    破坏性按钮 红色的标题
 *  @param callBack       回调方法
 */
+ (void)showAlertViewInViewController:(UIViewController*)viewController
                                title:(NSString*)title
                              message:(NSString*)message
                          cancelTitle:(NSString*)cancel
                           otherTitle:(NSArray*)otherTitles
                          destructive:(NSString*)destructive
                             callBack:(void(^)(NSInteger index))callBack
{
    [self showBaseViewController:viewController preferredStyle:UIAlertControllerStyleAlert title:title message:message cancelTitle:cancel otherTitle:otherTitles destructive:destructive callBack:callBack];
}
/**
 *  弹出一个 actionSheet 类型的 alertController
 *
 *  @param viewController  当前控制器
 *  @param title          标题
 *  @param message        消息
 *  @param cancel         取消标题
 *  @param otherTitles    其他标题 依次放数组里将来索引从1 开始
 *  @param destructive    破坏性按钮 红色的标题
 *  @param callBack       回调方法
 */
+ (void)showActionSheetViewInViewController:(UIViewController*)viewController
                                      title:(NSString*)title
                                    message:(NSString*)message
                                cancelTitle:(NSString*)cancel
                                 otherTitle:(NSArray*)otherTitles
                                destructive:(NSString*)destructive
                                   callBack:(void(^)(NSInteger index))callBack
{
    [self showBaseViewController:viewController preferredStyle:UIAlertControllerStyleActionSheet title:title message:message cancelTitle:cancel otherTitle:otherTitles destructive:destructive callBack:callBack];
}
+ (void)showAlertMessage:(NSString*)message
{
    UIViewController *controller = [[UIApplication sharedApplication].delegate window].rootViewController;
    [self showAlertWithController:controller alertBody:message];
}
/**
 *  简单的弹出一个警告框 不做任何响应
 *
 *  @param message 警告框信息
 */
+ (void)showAlertWithController:(UIViewController*)controller alertBody:(NSString*)body
{
    [self showBaseViewController:controller preferredStyle:UIAlertControllerStyleAlert title:@"提示" message:body cancelTitle:@"我知道了" otherTitle:nil destructive:nil callBack:nil];
}

/**
 *  公共方法传不同的类型显示不同类型的提示框
 *
 *  @param viewController   当前控制器
 *  @param title            标题
 *  @param message          消息
 *  @param cancel           取消标题
 *  @param otherTitles      其他标题 依次放数组里将来索引从1 开始
 *  @param destructive      破坏性按钮 红色的标题
 *  @param callBack         回调方法
 */
+ (void)showBaseViewController:(UIViewController*)viewController
                preferredStyle:(UIAlertControllerStyle)style
                         title:(NSString*)title
                       message:(NSString*)message
                   cancelTitle:(NSString*)cancel
                    otherTitle:(NSArray*)otherTitles
                   destructive:(NSString*)destructive
                      callBack:(void(^)(NSInteger index))callBack
{
    __block NSInteger index = 0;
    __block UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    if (cancel) {
        [alertController addAction:[UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (callBack) {
                callBack(index);
            }
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }]];
    }
    if (destructive) {
        [alertController addAction:[UIAlertAction actionWithTitle:destructive style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if (callBack) {
                callBack(1000);
            }
        }]];
    }
    if (otherTitles&&[otherTitles count]>0)
    {
        for (int i =0; i<otherTitles.count; i++)
        {
            __block NSInteger otherIndex = i+1;
            [alertController addAction:[UIAlertAction actionWithTitle:otherTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (callBack) {
                    callBack(otherIndex);
                }
            }]];
        }
    }
    [viewController presentViewController:alertController animated:YES completion:nil];
}

@end
