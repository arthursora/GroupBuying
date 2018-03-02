//
//  DealInfoTextView.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/28.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "DealInfoTextView.h"

@interface DealInfoTextView()

@property (weak, nonatomic) IBOutlet UIButton *titleBtn;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation DealInfoTextView

+ (instancetype)textView {
    
    return [[NSBundle mainBundle] loadNibNamed:@"DealInfoTextView" owner:nil options:nil][0];
}

- (void)setIcon:(NSString *)icon {
    
    _icon = icon;
    [_titleBtn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    [_titleBtn setTitle:title forState:UIControlStateNormal];
}

- (void)setDetail:(NSString *)detail {
    
    _detail = detail;
    _detailLabel.text = detail;
    
    CGFloat detailW = _detailLabel.mj_w;
    CGFloat detailH = [YJTool heightWithStr:detail lineSpacing:3 fontSize:15 maxLabelWidth:detailW];
    
    _detailLabel.mj_h = detailH;
    
    self.mj_h = CGRectGetMaxY(_detailLabel.frame) + 10;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
