//
//  YJDeal.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/7.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJDeal.h"
#import "YJBusiness.h"

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

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{
             @"businesses":[YJBusiness class]
             };
}

- (void)setCurrentPrice:(NSString *)currentPrice {
    
    _currentPrice = [self dealPrice:currentPrice];
}

- (void)setListPrice:(NSString *)listPrice {
    _listPrice = [self dealPrice:listPrice];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        
        _dealId = [aDecoder decodeObjectForKey:@"dealId"];
        _title = [aDecoder decodeObjectForKey:@"title"];
        _sImageUrl = [aDecoder decodeObjectForKey:@"sImageUrl"];
        _desc = [aDecoder decodeObjectForKey:@"desc"];
        _currentPrice = [aDecoder decodeObjectForKey:@"currentPrice"];
        _listPrice = [aDecoder decodeObjectForKey:@"listPrice"]; 
        _purchaseCount = [aDecoder decodeIntegerForKey:@"purchaseCount"];
        
        _publishDate = [aDecoder decodeObjectForKey:@"publishDate"];
        _purchaseDeadline = [aDecoder decodeObjectForKey:@"purchaseDeadline"];
    }
    return self;
}

- (BOOL)isEqual:(YJDeal *)other {
    
    return [self.dealId isEqualToString:other.dealId];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_dealId forKey:@"dealId"];
    [aCoder encodeObject:_sImageUrl forKey:@"sImageUrl"];
    [aCoder encodeObject:_desc  forKey:@"desc"];
    [aCoder encodeObject:_currentPrice forKey:@"currentPrice"];
    [aCoder encodeObject:_listPrice forKey:@"listPrice"];
    [aCoder encodeInteger:_purchaseCount forKey:@"purchaseCount"];
    
    [aCoder encodeObject:_title forKey:@"title"];
    
    [aCoder encodeObject:_publishDate forKey:@"publishDate"];
    [aCoder encodeObject:_purchaseDeadline forKey:@"purchaseDeadline"];
}

//MJCodingImplementation

- (NSString *)dealPrice:(NSString *)price {
    
    int loc = (int)[price rangeOfString:@"."].location;
    if (loc != -1 && price.length > loc + 3) {
        price = [price substringToIndex:loc + 3];
    }
    return price;
}


@end
