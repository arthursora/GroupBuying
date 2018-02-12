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
    
    _badgeView.image = [UIImage imageNamed:@"ic_deal_new"];
    [_iconView sd_setImageWithURL:[NSURL URLWithString:deal.sImageUrl]];
    
    _iconView.contentMode = UIViewContentModeScaleToFill;
    _titleView.text = deal.title;
    
    [_buyCountButton setTitle:[NSString stringWithFormat:@"%ld", deal.purchaseCount] forState:UIControlStateNormal];
    _priceLabel.text = [NSString stringWithFormat:@"%.2f元", deal.currentPrice];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
