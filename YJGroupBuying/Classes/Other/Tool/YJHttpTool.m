//
//  YJHttpTool.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/8.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJHttpTool.h"
#import "DPAPI.h"

typedef void(^ResultBlock)(id result, NSError *error);

@interface YJHttpTool() <DPRequestDelegate>

@end

@implementation YJHttpTool

static DPAPI *_api;
static YJHttpTool *_tool;

static NSMutableDictionary *_blocks;

+ (void)initialize {
    _tool = [[YJHttpTool alloc] init];
    _blocks = [NSMutableDictionary dictionary];
    _api = [[DPAPI alloc] init];
}

//+ (void)postWithUrl:(NSString *)url params:(NSMutableDictionary *)params success:(YJHttpSuccess)success failure:(YJHttpFailure)failure {
//
//}

+ (void)getWithUrl:(NSString *)url params:(NSMutableDictionary *)params success:(YJHttpSuccess)success failure:(YJHttpFailure)failure {
    
    DPRequest *request = [_api requestWithURL:url params:[params mutableCopy] delegate:_tool];
    
    _blocks[request.description] = ^(id result, NSError *error) {
        
        if (result) {
            success(result);
        }else {
            failure(error);
        }
    };
}


#pragma mark - DPRequestDelegate
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error {
    
    ResultBlock block = _blocks[request.description];
    block(nil, error);
    
    [_blocks removeObjectForKey:request.description];
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result {
    
    ResultBlock block = _blocks[request.description];
    block(result, nil);
    
    [_blocks removeObjectForKey:request.description];
}


@end
