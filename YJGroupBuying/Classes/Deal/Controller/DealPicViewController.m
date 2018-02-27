//
//  DealPicViewController.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/26.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "DealPicViewController.h"
#import "YJDeal.h"

@interface DealPicViewController () <UIWebViewDelegate>
{
    UIWebView *_webView;
}
@end

@implementation DealPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger loc = [_deal.dealId rangeOfString:@"-"].location + 1;
    NSString *dealId = [_deal.dealId substringFromIndex:loc];
    NSString *urlStr = [NSString stringWithFormat:@"http://m.dianping.com/tuan/deal/moreinfo/%@", dealId];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    [MBProgressHUD showMessage:@"正在加载..." toView:self.view];
}

- (void)loadView {
    
    _webView = [[UIWebView alloc] init];
    _webView.frame = [UIScreen mainScreen].applicationFrame;
    _webView.delegate = self;
    self.view = _webView;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    YJLog(@"%@", request.URL);
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    for (UIView *child in webView.scrollView.subviews) {
        if ([child isKindOfClass:[UIImageView class]]) {
            [child removeFromSuperview];
        }
    }
    
    NSMutableString *js = [NSMutableString string];
    [js appendString:@"var body = document.body;"];
//    [js appendString:@"var section = document.getElementsByClassName('group-detail')[0];"];
//    [js appendString:@"var section1 = document.getElementsByClassName('group-detail')[1];"];
//    [js appendString:@"var section2 = document.getElementsByClassName('group-detail')[2];"];
//    [js appendString:@"body.innerHTML = '';"];
//    [js appendString:@"body.appendChild(section);"];
//    [js appendString:@"body.appendChild(section1);"];
//    [js appendString:@"body.appendChild(section2);"];
    [js appendString:@"body.removeChild(document.getElementsByTagName('header')[0]);"];
    [js appendString:@"body.removeChild(document.getElementsByClassName('cost-box')[0]);"];
    [js appendString:@"body.removeChild(document.getElementsByClassName('footer')[0]);"];
    [js appendString:@"b ody.removeChild(document.getElementsByClassName('buy-now')[0]);"];
    
    [webView stringByEvaluatingJavaScriptFromString:js];
    
    _webView.scrollView.contentInset = UIEdgeInsetsMake(130, 0, 0, 0);
    _webView.scrollView.contentOffset = CGPointMake(0, -130);
    _webView.hidden = NO;
    [MBProgressHUD hideHUDForView:self.view];
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
