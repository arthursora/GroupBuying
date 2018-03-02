//
//  DealInfoTextView.h
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/28.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealInfoTextView : UIView

+ (instancetype)textView;

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;

@end
