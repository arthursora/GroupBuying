//
//  Restriction.h
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/27.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restriction : NSObject
//  is_reservation_required    int    是否需要预约，0：不是，1：是
@property (nonatomic, assign) BOOL is_reservation_required;

//  is_refundable    int    是否支持随时退款，0：不是，1：是
@property (nonatomic, assign) BOOL is_refundable;

//  special_tips    string    附加信息(一般为团购信息的特别提示)
@property (nonatomic, copy) NSString *special_tips;

@end
