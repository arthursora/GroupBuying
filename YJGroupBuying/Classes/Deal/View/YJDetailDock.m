//
//  YJDetailDock.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/24.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJDetailDock.h"

@interface YJDetailDock()
{
    UIButton *_selectButton;
}

@property (weak, nonatomic) IBOutlet UIButton *infoBtn;
@property (weak, nonatomic) IBOutlet UIButton *imgBtn;

@end

@implementation YJDetailDock

+ (instancetype)dock {
    
    return [[NSBundle mainBundle] loadNibNamed:@"YJDetailDock" owner:nil options:nil][0];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self dockClicked:_infoBtn];
}

- (IBAction)dockClicked:(UIButton *)sender {
    
    if ([_delegate respondsToSelector:@selector(dockView:didSelectBtnFrom:to:)]) {
        [_delegate dockView:self didSelectBtnFrom:_selectButton.tag to:sender.tag];
    }
    
    _selectButton.enabled = YES;
    sender.enabled = NO;
    _selectButton = sender;
    
    [self bringSubviewToFront:_imgBtn];
    [self bringSubviewToFront:_selectButton];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
