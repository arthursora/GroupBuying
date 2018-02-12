//
//  YJDealBottomMenu.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/9.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#define kButtonH 45

#import "YJDealBottomMenu.h"
#import "YJDealBottomMenuButton.h"
#import "YJDealBottomModel.h"
#import "YJDealBottomSecMenuButton.h"

@interface YJDealBottomMenu()
{
    UIImageView *_showingSecView;
    YJDealBottomMenuButton *_selectedButton;
    YJDealBottomSecMenuButton *_selectedSecondButton;
    
    YJDealBottomModel *_selectModel;
}
@end

@implementation YJDealBottomMenu

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

- (void)setData:(NSArray *)data {
    
    _data = data;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kButtonH)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.bounces = YES;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    
    CGFloat buttonW = 120;
    NSInteger dataCount = data.count;
    for (int i = 0; i < dataCount; i++) {
        
        YJDealBottomModel *bottomModel = data[i];
        
        YJDealBottomMenuButton *button = [[YJDealBottomMenuButton alloc] initWithFrame:CGRectMake(buttonW * i, 0, buttonW, kButtonH)];
        button.bottomModel = bottomModel;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:button];
        
        if (i == 0) {
            
            button.selected = YES;
            _selectedButton = button;
        }
    }
    scrollView.contentSize = CGSizeMake(buttonW * dataCount, 0);
    
    CGRect bottomF = self.frame;
    bottomF.size.height = kButtonH;
    self.frame = bottomF;
}

- (void)buttonClicked:(YJDealBottomMenuButton *)button {
    
    YJDealBottomModel *bottomModel = button.bottomModel;
    if (bottomModel.children.count) {
        
        if (button == _selectedButton) return;
        [self addSecondButton:bottomModel];
    }else {
        
        NSDictionary *dict = @{
                               YJMenuBtnTitleKey:[button titleForState:UIControlStateNormal],
                               YJMenuBtnModelKey:button.bottomModel
                               };
        [[NSNotificationCenter defaultCenter] postNotificationName:YJMenuBtnSelectedNote object:dict];
        
        [_showingSecView removeFromSuperview];
        _showingSecView = nil;
        _selectedSecondButton = nil;
        
        CGRect bottomF = self.frame;
        bottomF.size.height = kButtonH;
        self.frame = bottomF;
    }
    
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
}

- (void)addSecondButton:(YJDealBottomModel *)bottomModel {
    
    [_showingSecView removeFromSuperview];
    _showingSecView = nil;
    
    _showingSecView = [[UIImageView alloc] initWithImage:[UIImage resizedImage:@"bg_subfilter_other"]];
    _showingSecView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    NSArray *children = bottomModel.children;
    NSInteger dataCount = children.count;
    
    for (int i = 0; i < dataCount; i++) {
        
        YJDealBottomSecMenuButton *secButton = [[YJDealBottomSecMenuButton alloc] init];
        [secButton setTitle:children[i] forState:UIControlStateNormal];
        
        if ([children[i] isEqualToString:[_selectedSecondButton titleForState:UIControlStateNormal]] && bottomModel == _selectModel) {
            
            _selectedSecondButton = secButton;
            secButton.selected = YES;
        }
        [secButton addTarget:self action:@selector(secondButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_showingSecView addSubview:secButton];
    }
    
    _showingSecView.userInteractionEnabled = YES;
    [self addSubview:_showingSecView];
    
    [self layoutSubviews];
}

#pragma mark 当一个控件的尺寸发生改变的时候，就会自动调用这个方法
- (void)layoutSubviews {

    [super layoutSubviews];
    
    if (_showingSecView.superview == nil) return;
    
    CGFloat buttonW = 130;
    CGFloat buttonH = 40;

    NSArray *children = _selectedButton.bottomModel.children;

    NSInteger dataCount = children.count;
    NSInteger totalColumns = self.frame.size.width / buttonW;
    NSInteger totalRows = (dataCount + totalColumns - 1) / totalColumns;

    for (int i = 0; i < dataCount; i++) {

        NSInteger col = i % totalColumns;
        NSInteger row = i / totalColumns;

        CGFloat buttonX = col * buttonW;
        CGFloat buttonY = row * buttonH;
        
        YJDealBottomSecMenuButton *secButton = _showingSecView.subviews[i];
        secButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
    
    CGFloat showH = totalRows * buttonH;
    _showingSecView.frame = CGRectMake(0, kButtonH, self.frame.size.width, showH);
    
    self.mj_h = kButtonH + showH;
}

- (void)secondButtonClicked:(YJDealBottomSecMenuButton *)button {
    
    _selectModel = _selectedButton.bottomModel;
    
    if (button == _selectedSecondButton) return;
    
    _selectedSecondButton.selected = NO;
    button.selected = YES;
    _selectedSecondButton = button;
    
    NSString *title = [button titleForState:UIControlStateNormal];
    if ([title isEqualToString:@"全部"]) {
        title = _selectedButton.bottomModel.name;
    }
    
    NSDictionary *dict = @{
                           YJMenuBtnTitleKey:title,
                           YJMenuBtnModelKey:_selectedButton.bottomModel
                           };
    [[NSNotificationCenter defaultCenter] postNotificationName:YJMenuBtnSelectedNote object:dict];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
