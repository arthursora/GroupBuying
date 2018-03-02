//
//  YJDealAnnotation.h
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/3/1.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "YJDeal.h"

@interface YJDealAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) YJDeal *deal;

@end
