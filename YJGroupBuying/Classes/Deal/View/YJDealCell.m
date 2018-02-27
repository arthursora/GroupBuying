//
//  YJDealCell.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/8.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJDealCell.h"

@interface YJDealCell()
@property (weak, nonatomic) IBOutlet UIImageView *badgeView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;

@property (weak, nonatomic) IBOutlet UIButton *buyCountButton;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation YJDealCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"deal";
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        UINib *nib = [UINib nibWithNibName:@"YJDealCell" bundle:nil];
        [collectionView registerNib:nib forCellWithReuseIdentifier:ID];
    });
    
    return [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
}

- (void)setDeal:(YJDeal *)deal {
    
    _deal = deal;
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *nowDate = [fmt stringFromDate:[NSDate date]];
    if ([nowDate isEqualToString:_deal.publishDate]) {
        _badgeView.image  = [UIImage imageNamed:@"ic_deal_new"];
        _badgeView.hidden = NO;
    }else if([nowDate compare:_deal.purchaseDeadline] == NSOrderedDescending){
        _badgeView.image  = [UIImage imageNamed:@"ic_deal_over"];
        _badgeView.hidden = NO;
    }else if([nowDate isEqualToString:_deal.purchaseDeadline]){
        _badgeView.image  = [UIImage imageNamed:@"ic_deal_soonOver"];
        _badgeView.hidden = NO;
    }else {
        _badgeView.hidden = YES;
    }
    
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:deal.sImageUrl]];
    
    _iconView.contentMode = UIViewContentModeScaleToFill;
    _titleView.text = deal.title;
    
    [_buyCountButton setTitle:[NSString stringWithFormat:@"%ld", deal.purchaseCount] forState:UIControlStateNormal];
    _priceLabel.text = [NSString stringWithFormat:@"%@元", deal.currentPrice];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
