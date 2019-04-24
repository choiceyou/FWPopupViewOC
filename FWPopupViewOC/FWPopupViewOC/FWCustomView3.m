//
//  FWCustomView3.m
//  FWPopupViewOC
//
//  Created by xfg on 2019/4/24.
//  Copyright © 2019 xfg. All rights reserved.
//

#import "FWCustomView3.h"
#import "Masonry.h"

static CGFloat kArrowHeight = 15;


@interface FWCustomView3 ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *arrowImgView;

@end


@implementation FWCustomView3

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self);
            make.top.equalTo(self).offset(kArrowHeight);
        }];
        
        [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kArrowHeight*2, kArrowHeight));
            make.centerX.top.equalTo(self);
        }];
        
        [self configProperty];
    }
    return self;
}

- (void)configProperty
{
    FWPopupBaseViewProperty *property = [FWPopupBaseViewProperty manager];
    property.popupAlignment = FWPopupAlignmentTopCenter;
    property.popupAnimationStyle = FWPopupAnimationStyleScale;
    property.touchWildToHide = @"1";
    property.popupArrowStyle = FWPopupArrowStyleRound;
    property.popupArrowSize = CGSizeMake(kArrowHeight*2, kArrowHeight);
    self.vProperty = property;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 5;
        _bgView.clipsToBounds = YES;
        [self addSubview:_bgView];
    }
    return _bgView;
}

- (UIImageView *)arrowImgView
{
    if (!_arrowImgView) {
        _arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fw_arrow_01"]];
        [self addSubview:_arrowImgView];
    }
    return _arrowImgView;
}

@end
