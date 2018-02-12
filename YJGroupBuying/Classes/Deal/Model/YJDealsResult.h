//
//  YJDealsResult.h
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/7.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJDealsResult : NSObject

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) NSArray *deals;

@end
