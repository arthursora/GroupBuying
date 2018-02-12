//
//  MBProgressHUD+DST.m
//  YuanCheng
//
//  Created by dongshangtong on 16/3/14.
//  Copyright © 2016年 dongshangtong. All rights reserved.
//

#import "MBProgressHUD+DST.h"

@implementation MBProgressHUD (DST)

#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    //hud.dimBackground =YES;
    
    // 1秒之后再消失
    NSTimeInterval timeInter = text.length * 0.15;
    [hud hide:YES afterDelay:timeInter];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    return hud;
}

#pragma mark 显示正在加载....
+ (void)loadingDataHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText= @"正在加载";
    //hud.dimBackground = YES;
    hud.backgroundColor = [UIColor whiteColor];

    hud.removeFromSuperViewOnHide = YES;

}

+ (void)loadingQuestionsHUDForView:(UIView *)view {
    
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText= @"正在加载题库，请稍后！";
    //hud.dimBackground = YES;
    hud.backgroundColor = [UIColor whiteColor];
    
    hud.removeFromSuperViewOnHide = YES;
}

#pragma mark 显示正在动画加载....

+(void)loadingAnimationDataHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    UIImageView * gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
    gifImageView.contentMode = UIViewContentModeCenter;

    NSMutableArray * frames = [YJTool resolutionGitImage];
    gifImageView.animationImages = frames; //获取Gif图片列表
    gifImageView.animationDuration = 5;     //执行一次完整动画所需的时长
    gifImageView.animationRepeatCount = 0;  //动画重复次数
    [gifImageView startAnimating];
    hud.customView= gifImageView;
    hud.minSize= CGSizeMake(300, 60);
    hud.backgroundColor = [UIColor clearColor];
    hud.removeFromSuperViewOnHide = YES;
 
}


+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (void)successShowMessage:(NSString *)message
{
  [self show:message icon:@"success@2x.png"  view:nil];
}

+ (void)failureShowMessage:(NSString *)message
{
    [self show:message icon:@"error@2x.png"  view:nil];
}


+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

-(NSMutableArray *)praseGIFDataToImageArray:(NSData *)data;
{
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    CGImageSourceRef src = CGImageSourceCreateWithData((CFDataRef)data, NULL);
    CGFloat animationTime = 0.f;
    if (src) {
        size_t l = CGImageSourceGetCount(src);
        frames = [NSMutableArray arrayWithCapacity:l];
        for (size_t i = 0; i < l; i++) {
            CGImageRef img = CGImageSourceCreateImageAtIndex(src, i, NULL);
            NSDictionary *properties = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(src, i, NULL));
            NSDictionary *frameProperties = [properties objectForKey:(NSString *)kCGImagePropertyGIFDictionary];
            NSNumber *delayTime = [frameProperties objectForKey:(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
            animationTime += [delayTime floatValue];
            if (img) {
                [frames addObject:[UIImage imageWithCGImage:img]];
                CGImageRelease(img);
            }
        }
        CFRelease(src);
    }
    return frames;
}

@end
