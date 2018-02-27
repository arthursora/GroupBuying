//
//  YJDeal.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/7.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJDeal.h"

@implementation YJDeal

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"dealId":@"deal_id",
             @"desc":@"description",
             @"listPrice":@"list_price",
             @"currentPrice":@"current_price",
             @"purchaseCount":@"purchase_count",
             @"imageUrl":@"image_url",
             @"sImageUrl":@"s_image_url",
             @"publishDate":@"publish_date",
             @"purchaseDeadline":@"purchase_deadline",
             @"dealUrl":@"deal_url"
             };
}

- (void)setCurrentPrice:(NSString *)currentPrice {
    
    _currentPrice = [self dealPrice:currentPrice];
}

- (void)setListPrice:(NSString *)listPrice {
    _listPrice = [self dealPrice:listPrice];
}

- (NSString *)dealPrice:(NSString *)price {
    
    int loc = (int)[price rangeOfString:@"."].location;
    if (loc != -1 && price.length > loc + 3) {
        price = [price substringToIndex:loc + 3];
    }
    return price;
}

@end
