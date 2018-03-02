//
//  YJBusiness.h
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/3/1.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface YJBusiness : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *businessId;
@property (nonatomic, copy) NSString *city;

@property (nonatomic, assign) CLLocationDegrees latitude;
@property (nonatomic, assign) CLLocationDegrees longitude;

//"url": "http://dpurl.cn/p/dxswF4kgTz",
//"h5_url": "http://dpurl.cn/p/0UawX9SWzK

@end
