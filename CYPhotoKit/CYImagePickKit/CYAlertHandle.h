//
//  CYAlertKit.h
//  CYAlertController
//
//  Created by 董招兵 on 16/1/7.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CYAlertHandle : NSObject
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
                             callBack:(void(^)(NSInteger index))callBack;
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
                                   callBack:(void(^)(NSInteger index))callBack;
/**
 *  简单的弹出一个警告框 不做任何响应 默认在 window 根控制器弹出
 *
 *  @param message 警告框信息
 */
+ (void)showAlertMessage:(NSString*)message;
/**
 *  可以设置alert在那个控制器模态出来
 *
 *  @param controller 控制器
 *  @param body       弹出内容
 */
+ (void)showAlertWithController:(UIViewController*)controller alertBody:(NSString*)body;

@end
