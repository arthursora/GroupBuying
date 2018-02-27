//
//  YJDealTopMunu.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/8.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#define YJMenuBtnW 120
#define YJMenuBtnH 35

#import "YJDealTopMunu.h"
#import "YJDealTopMenuButton.h"
#import "YJDealBottomMenu.h"
#import "YJCategoryTool.h"
#import "YJCover.h"

@interface YJDealTopMunu()
{
    YJDealTopMenuButton *_selectedButton;
    
    YJDealBottomMenu *_selectBottomMenu;
    
    YJDealBottomMenu *_cBottomMenu;
    YJDealBottomMenu *_dBottomMenu;
    YJDealBottomMenu *_oBottomMenu;
}

@property (nonatomic, weak) YJCover *maskView;

@end

@implementation YJDealTopMunu

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        [self addMenuBtnWithTitle:@"全部分类" index:0];
        [self addMenuBtnWithTitle:@"全部商区" index:1];
        [self addMenuBtnWithTitle:@"默认排序" index:2];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuBtnSelected:) name:YJMenuBtnSelectedNote object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChanged:) name:@"cityChanged" object:nil];
    }
    return self;
}

- (void)addMenuBtnWithTitle:(NSString *)title index:(int)index {
    
    YJDealTopMenuButton *menuButton = [[YJDealTopMenuButton alloc] initWithFrame:CGRectMake(index * YJMenuBtnW, 0, YJMenuBtnW, YJMenuBtnH)];
    [menuButton setTitle:title forState:UIControlStateNormal];
    menuButton.tag = index;
    [menuButton addTarget:self action:@selector(menuClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:menuButton];
}

- (void)cityChanged:(NSNotification *)note {
    
    _dBottomMenu = nil;
    
    YJDealTopMenuButton *districtBtn = (YJDealTopMenuButton *)[self viewWithTag:1];
    [districtBtn setTitle:@"全部商区" forState:UIControlStateNormal];
    
    [self maskDismiss];
}

- (void)menuBtnSelected:(NSNotification *)note {
    
    NSString *title = [note object][YJMenuBtnTitleKey];
    [_selectedButton setTitle:title forState:UIControlStateNormal];
    
    [self maskDismiss];
}

- (void)menuClicked:(YJDealTopMenuButton *)button {
    
    if (_selectedButton == button) {
        
        [self maskDismiss];
        
    }else {
        
        if (!_selectedButton) {
            
            _maskView = [YJCover showCoverInView:_contentView frame:_contentView.bounds target:self action:@selector(maskDismiss)];
        }
        
        _selectedButton.selected = NO;
        button.selected = YES;
        _selectedButton = button;
        
        [self addDealButtomView];
    }
}

- (void)addDealButtomView {
    
    [_selectBottomMenu removeFromSuperview];
    
    switch (_selectedButton.tag) {
        case 0:{
            if (!_cBottomMenu) {
                
                _cBottomMenu = [[YJDealBottomMenu alloc] init];
                _cBottomMenu.frame = CGRectMake(0, _maskView.frame.origin.y, _maskView.frame.size.width, 0);
                _cBottomMenu.data = [YJCategoryTool totalCategories];
            }
            _selectBottomMenu = _cBottomMenu;
        }
            break;
        case 1:{
            if (!_dBottomMenu) {
                
                _dBottomMenu = [[YJDealBottomMenu alloc] init];
                _dBottomMenu.frame = CGRectMake(0, _maskView.frame.origin.y, _maskView.frame.size.width, 0);
                _dBottomMenu.data = [YJCategoryTool totalDistricts];
            }
            _selectBottomMenu = _dBottomMenu;
        }
            break;
        case 2:{
            if (!_oBottomMenu) {
                
                _oBottomMenu = [[YJDealBottomMenu alloc] init];
                _oBottomMenu.frame = CGRectMake(0, _maskView.frame.origin.y, _maskView.frame.size.width, 0);
                _oBottomMenu.data = [YJCategoryTool totalOrders];
            }
            _selectBottomMenu = _oBottomMenu;
        }
            break;
    }
    
    _selectBottomMenu.mj_w = _maskView.frame.size.width;
    
    [_contentView addSubview:_selectBottomMenu];
}

- (void)maskDismiss {
    
    [_selectBottomMenu removeFromSuperview];
    _selectBottomMenu = nil;
    
    _selectedButton.selected = NO;
    _selectedButton = nil;
    
    [_maskView removeFromSuperview];
    _maskView = nil;
}

- (void)setFrame:(CGRect)frame {
    
    frame.size = CGSizeMake(YJMenuBtnW * 3, YJMenuBtnH);
    [super setFrame:frame];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
