//
//  MBProgressHUD+DST.h
//  YuanCheng
//
//  Created by dongshangtong on 16/3/14.
//  Copyright © 2016年 dongshangtong. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (DST)


+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;
+ (void)failureShowMessage:(NSString *)message;
+ (void)successShowMessage:(NSString *)message;


+(void)loadingDataHUDForView:(UIView *)view;

+(void)loadingQuestionsHUDForView:(UIView *)view;

+(void)loadingAnimationDataHUDForView:(UIView *)view;
@end
