//
//  YJDealInfoHeader.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/28.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJDealInfoHeader.h"
#import "UIImage+IW.h"
#import "YJDeal.h"

@interface YJDealInfoHeader()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UIButton *anyRefundBtn;
@property (weak, nonatomic) IBOutlet UIButton *expireRefundBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *buyCountBtn;

@end

@implementation YJDealInfoHeader

+ (instancetype)header {
    
    return [[NSBundle mainBundle] loadNibNamed:@"YJDealInfoHeader" owner:nil options:nil][0];
}

- (void)setDeal:(YJDeal *)deal {
    
    _deal = deal;
    
    _anyRefundBtn.enabled = deal.restrictions.is_refundable;
    _expireRefundBtn.enabled = deal.restrictions.is_refundable;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:_deal.imageUrl] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
    
    NSDate *now = [NSDate date];
    
    NSDateFormatter *datefmt = [[NSDateFormatter alloc] init];
    datefmt.dateFormat = @"yyyy-MM-dd";
    NSDate *deadline = [datefmt dateFromString:_deal.purchaseDeadline];
    deadline = [deadline dateByAddingTimeInterval:24 * 60 * 60];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *components = [calendar components:unit fromDate:now toDate:deadline options:0];
    
    NSString *title = [NSString stringWithFormat:@"%ld 天 %ld 小时 %ld 分钟", components.day, components.hour, components.minute];
    [_leftTimeBtn setTitle:title forState:UIControlStateNormal];
    
    [_buyCountBtn setTitle:[NSString stringWithFormat:@"%ld 人已购买", (long)_deal.purchaseCount] forState:UIControlStateNormal];
    _descLabel.text = _deal.desc;
}

- (void)drawRect:(CGRect)rect {
    
    [[UIImage resizedImage:@"bg_order_cell"] drawInRect:rect];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
