//
//  YJMoreViewController.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/28.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#define cellIdentifier @"cell"

#import "YJMoreViewController.h"

@interface YJMoreViewController ()

@end

@implementation YJMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    self.title = @"更多";
    self.view.backgroundColor = GlobalBGColor;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"给我评分";
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"检查更新";
    }else {
        cell.textLabel.text = @"应用推荐";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        UIApplication *app = [UIApplication sharedApplication];
        NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8", @"1219968605"];
        [app openURL:[NSURL URLWithString:url]];
        
    }else if (indexPath.row == 1) {
        
        NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:(__bridge NSString *)kCFBundleVersionKey];
        YJLog(@"%@", version);
        
    }else {
        
        UIApplication *app = [UIApplication sharedApplication];
        NSURL *url = [NSURL URLWithString:@"carservice://com.carservice.www"];
        url = [NSURL URLWithString:@"app://my.momey"];
        [app openURL:url];
        
        if ([app canOpenURL:url]) {
            
            YJLog(@"can open");
        }else {
            YJLog(@"cannot open");
        }
    }
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
