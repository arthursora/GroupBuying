//
//  YJGCity.h
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/2.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJGCity : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) BOOL hot;

@property (nonatomic, strong) NSArray *districts;

@end
