//
//  YJHttpTool.h
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/8.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^YJHttpSuccess)(id json);
typedef void(^YJHttpFailure)(NSError *error);

@interface YJHttpTool : NSObject

+ (void)getWithUrl:(NSString *)url params:(NSDictionary *)params success:(YJHttpSuccess)success failure:(YJHttpFailure)failure;

//+ (void)postWithUrl:(NSString *)url params:(NSMutableDictionary *)params success:(YJHttpSuccess)success failure:(YJHttpFailure)failure;

@end
