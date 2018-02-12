//
//  YJGCity.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/2.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJGCity.h"
#import "YJGDistrict.h"

@implementation YJGCity

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"cityId":@"city_id"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{
             @"districts":[YJGDistrict class]
             };
}

- (NSString *)pinyinWithChinese:(NSString *)city {
    
    NSMutableString *cityMutableString = [NSMutableString stringWithString:city];
    CFStringTransform((CFMutableStringRef)cityMutableString,NULL, kCFStringTransformMandarinLatin,NO);
    CFStringTransform((CFMutableStringRef)cityMutableString,NULL, kCFStringTransformStripDiacritics,NO);
    
    NSString *cityString = [[NSString stringWithFormat:@"%@",cityMutableString] lowercaseString];
    return cityString;
}

- (void)setDistricts:(NSArray *)districts {
    
    NSMutableArray *array = [NSMutableArray array];
    YJGDistrict *district = [[YJGDistrict alloc] init];
    district.name = @"全部商区";
    [array addObject:district];
    [array addObjectsFromArray:districts];
    _districts = array;
}

- (void)setName:(NSString *)name {
    
    _name = name;
    NSString *pinyin = [self pinyinWithChinese:name];
    
    _pinyin = [pinyin stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSArray *words = [pinyin componentsSeparatedByString:@" "];
    
    NSString *firstName = @"";
    for (NSString *str in words) {
        NSString *firstWord = [str substringToIndex:1];
        firstName = [[NSString alloc] initWithFormat:@"%@%@", firstName, firstWord];
    }
    _firstName = firstName;
}

@end
