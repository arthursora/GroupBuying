//
//  MapViewController.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/1.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#define YJLatitude 0.61
#define YJLongitude 1.12

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "YJDealParam.h"
#import "YJDealTool.h"
#import "YJDeal.h"
#import "YJDealsResult.h"
#import "YJBusiness.h"
#import "YJDealAnnotation.h"
#import "YJCover.h"
#import "DealDetailViewController.h"

@interface MapViewController () <MKMapViewDelegate>
{
    NSMutableArray *_showingDeals;
    MKMapView *_mapView;
}
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _showingDeals = [NSMutableArray array];
    
    self.title = @"地图";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _mapView = [[MKMapView alloc] init];
    _mapView.frame = self.view.bounds;
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_mapView];
    
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    _mapView.delegate = self;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    MKCoordinateSpan span = MKCoordinateSpanMake(YJLatitude, YJLongitude);
    [mapView setRegion:MKCoordinateRegionMake(userLocation.location.coordinate, span)];
    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    
    YJDealParam *param = [[YJDealParam alloc] init];
    param.city = @"北京";
    param.longitude = @(mapView.region.center.longitude);
    param.latitude = @(mapView.region.center.latitude);
    param.radius = @(5000);
    
    [YJDealTool dealsWithParam:param success:^(YJDealsResult *result) {
        for (YJDeal *deal in result.deals) {
            
            if ([_showingDeals containsObject:deal]) continue;
            [_showingDeals addObject:deal];
            
            for (YJBusiness *business in deal.businesses) {
                
                YJDealAnnotation *anno = [[YJDealAnnotation alloc] init];
                anno.coordinate = CLLocationCoordinate2DMake(business.latitude, business.longitude);
                anno.deal = deal;
                [mapView addAnnotation:anno];
            }
        };
    } failure:^(NSError *error) {
        [MBProgressHUD showError:error.localizedDescription];
    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if (![annotation isKindOfClass:[YJDealAnnotation class]]) return nil;
    
    static NSString *reuseID = @"customReuseIndetifier";
    MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseID];
    if (annoView == nil) {
        annoView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseID];
    }
    
    annoView.image = [UIImage imageNamed:@"ic_collect_suc"];
    
    return annoView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    YJDealAnnotation *anno = (YJDealAnnotation *)view.annotation;
    [YJCover showCoverInView:self.navigationController.view frame:self.navigationController.view.bounds target:self action:@selector(coverDismiss)];
    
    DealDetailViewController *detailVC = [[DealDetailViewController alloc] init];
    detailVC.deal = anno.deal;
    detailVC.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"btn_nav_close" higlightedImage:@"btn_nav_close_hl" target:self action:@selector(coverDismiss)];
    
    YJNavigationController *nav = [[YJNavigationController alloc] initWithRootViewController:detailVC];
    nav.view.backgroundColor = GlobalBGColor;
    CGFloat navW = YJGDetailViewWidth;
    CGFloat navH = self.navigationController.view.frame.size.height;
    CGFloat navX = self.navigationController.view.frame.size.width - YJGDetailViewWidth;
    
    nav.view.frame = CGRectMake(navX, 0, navW, navH);
    nav.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    
    [self.navigationController addChildViewController:nav];
    [self.navigationController.view addSubview:nav.view];
}

- (void)coverDismiss {
    
    [YJCover hideCoverInView:self.navigationController.view];
    
    UINavigationController *nav = [self.navigationController.childViewControllers lastObject];
    [nav.view removeFromSuperview];
    [nav removeFromParentViewController];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
