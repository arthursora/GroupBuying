//
//  YJGCityListViewController.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/2.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJGCityListViewController.h"
#import "SearchCityViewController.h"
#import "YJCityTool.h"
#import "YJGGroup.h"

@interface YJGCityListViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
{
    NSMutableArray *_groups;
    SearchCityViewController *_searchCityVC;
}

@property (nonatomic, weak) UIView *coverView;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation YJGCityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    _groups = [YJCityTool totalCities];
}

#pragma mark - viewDidLoad
- (void)setupUI {
    
    CGFloat viewW = self.view.bounds.size.width;
    CGFloat viewH = self.view.bounds.size.height;
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.frame = CGRectMake(0, 0, viewW, 56);
    searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    searchBar.placeholder = @"请输入城市名称或者拼音";
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    
    CGFloat tableY = searchBar.frame.size.height;
    UITableView *tableView = [[UITableView alloc] init];
    CGFloat tableHeight = viewH - tableY;
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tableY, viewW, tableHeight) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 44;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"city"];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length == 0) {
        
        [_searchCityVC.view removeFromSuperview];
        [_searchCityVC removeFromParentViewController];
        _searchCityVC = nil;
        
    }else {
        
        if(!_searchCityVC) {
            _searchCityVC = [[SearchCityViewController alloc] init];
            [self addChildViewController:_searchCityVC];
            
            NSMutableArray *cities = [NSMutableArray array];
            for (YJGGroup *group in _groups) {
                if(group.name.length > 1) continue;
                [cities addObjectsFromArray:group.cities];
            }
            _searchCityVC.cities = [cities copy];
        }
        
        _searchCityVC.searchText = searchText;
        
        _searchCityVC.view.frame = _tableView.frame;
        [self.view addSubview:_searchCityVC.view];
    }
}

#pragma mark 开始聚焦
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:YES animated:YES];
    if (_searchCityVC) return;
    
    UIView *coverView = [[UIView alloc] init];
    coverView.frame = _tableView.frame;
    coverView.autoresizingMask = _tableView.autoresizingMask;
    coverView.alpha = 0.0;
    coverView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:coverView];
    _coverView = coverView;
    
    [UIView animateWithDuration:0.5 animations:^{
        coverView.alpha = 0.3;
    }];
}

#pragma mark 失去焦点
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:NO animated:YES];
    
    if (_searchCityVC) return;
    
    [UIView animateWithDuration:0.5 animations:^{
        _coverView.alpha = 0.0;
    }completion:^(BOOL finished) {
        [_coverView removeFromSuperview];
    }];
}

#pragma mark 取消按钮点击事件
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
#pragma mark 返回组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _groups.count;
}

#pragma mark 返回 每一组的头部视图
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    YJGGroup *group = _groups[section];
    return group.name;
}

#pragma mark - 返回总共有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    YJGGroup *group = _groups[section];
    return group.cities.count;
}

#pragma mark 返回 每一行的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIndetifier = @"city";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier forIndexPath:indexPath];
    
    YJGGroup *group = _groups[indexPath.section];
    YJGCity *city = group.cities[indexPath.row];
    cell.textLabel.text = city.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJGGroup *group = _groups[indexPath.section];
    YJGCity *city = group.cities[indexPath.row];
    
    [YJCityTool addRecentCity:city];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return [_groups valueForKeyPath:@"name"];
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
