//
//  YJDealCell.h
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/8.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJDeal.h"

@interface YJDealCell : UICollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong) YJDeal *deal;

@end
