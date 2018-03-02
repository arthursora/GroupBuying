//
//  YJGLocationButton.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/1.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJGLocationButton.h"
#import "YJGCityListViewController.h"
#import "YJGCity.h"
#import <CoreLocation/CoreLocation.h>
#import "YJCityTool.h"

@interface YJGLocationButton() <UIPopoverControllerDelegate, CLLocationManagerDelegate>
{
    UIPopoverController *_popover;
    CLLocationManager *_locationManager;
    CLGeocoder *_coder;
}

@end

@implementation YJGLocationButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundImage:[UIImage imageNamed:@"bg_tabbar_item"] forState:UIControlStateHighlighted];
        
        [self setImage:[UIImage imageNamed:@"ic_district"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"ic_district_hl"] forState:UIControlStateSelected];
        self.imageView.contentMode = UIViewContentModeCenter;
        
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        [self addTarget:self action:@selector(locClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self locCurrentCity];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChanged:) name:@"cityChanged" object:nil];
    }
    return self;
}

- (void)locCurrentCity {
    
    _locationManager = [[CLLocationManager alloc] init];
    _coder = [[CLGeocoder alloc] init];
    
    _locationManager.delegate = self;
    [_locationManager requestAlwaysAuthorization];
    [_locationManager requestWhenInUseAuthorization];
    [_locationManager startUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    YJLog(@" locationManager %@", locations);
    [manager stopUpdatingLocation];
    
    CLLocation *location = locations[0];
    
    [_coder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        for (CLPlacemark *mark in placemarks) {
            
            YJLog(@"%@ %@", mark.locality, mark.subLocality);
            
            NSString *cityName = mark.locality;
            cityName = [cityName stringByReplacingOccurrencesOfString:@"市" withString:@""];
            YJGCity *city = [YJCityTool cityWithName:cityName];
            if (city) {
                
                [YJCityTool addRecentCity:city];
            }else {
                YJLog(@"no such city");
            }
        }
    }];
}

- (void)cityChanged:(NSNotification *)note {
    
    YJGCity *city = note.object[@"city"];
    [self setTitle:city.name forState:UIControlStateNormal];
    
    [_popover dismissPopoverAnimated:YES];
    _popover = nil;
    
    self.selected = NO;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)locClick {
    
    self.selected = YES;
    
    YJGCityListViewController *contentVC = [[YJGCityListViewController alloc] init];
    
    _popover = [[UIPopoverController alloc] initWithContentViewController:contentVC];
    _popover.popoverContentSize = CGSizeMake(320, 480);
    _popover.delegate = self;
    [_popover presentPopoverFromRect:self.bounds inView:self permittedArrowDirections:UIPopoverArrowDirectionUnknown animated:YES];
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
    
    self.selected = NO;
    return YES;
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGFloat w = contentRect.size.width;
    CGFloat h = contentRect.size.height * 0.5;
    return CGRectMake(0, 0, w, h);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat w = contentRect.size.width;
    CGFloat h = contentRect.size.height * 0.5;
    return CGRectMake(0, h, w, h);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
