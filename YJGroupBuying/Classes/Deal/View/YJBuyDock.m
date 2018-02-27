//
//  YJBuyDock.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/24.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJBuyDock.h"

@interface YJBuyDock()

@property (weak, nonatomic) IBOutlet UILabel *currentMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *orginMoneyLabel;

@property (weak, nonatomic) IBOutlet UIButton *buyButton;

@end

@implementation YJBuyDock

+ (instancetype)dock {
    
    return [[NSBundle mainBundle] loadNibNamed:@"YJBuyDock" owner:nil options:nil][0];
}

- (void)setDeal:(YJDeal *)deal {
    
    _deal = deal;
    
    _currentMoneyLabel.text = [NSString stringWithFormat:@"%@ 元", deal.currentPrice];
    _orginMoneyLabel.text = [NSString stringWithFormat:@"%@ 元", deal.listPrice];
}

- (IBAction)buyClicked {
    
    YJLog(@"-----");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
