//
//  FWCustomAdView.m
//  FWPopupViewOC
//
//  Created by xfg on 2019/4/24.
//  Copyright © 2019 xfg. All rights reserved.
//

#import "FWCustomAdView.h"
#import "Masonry.h"

/// 关闭按钮尺寸
#define kCloseBtnSize CGSizeMake(50, 50)
/// 关闭按钮上下
static CGFloat kCloseBtnMargin = 20;
/// 广告图宽高比
static float kAdViewScale = 0.7;
/// 广告图宽
#define kAdViewWidth ([UIScreen mainScreen].bounds.size.width * 0.7)

@interface FWCustomAdView ()

@property (nonatomic, strong) UIImageView *adImgView;
@property (nonatomic, strong) UIButton *closeBtn;

@end


@implementation FWCustomAdView

- (instancetype)initWithCloseBtnType:(FWCustomAdCloseBtnType)adCloseBtnType
{
    self = [super init];
    if (self) {
        
        CGFloat height = 0.0;
        if (adCloseBtnType == FWCustomAdCloseBtnBottom) {
            height = kAdViewWidth/kAdViewScale + kCloseBtnSize.height + kCloseBtnMargin;
        } else if (adCloseBtnType == FWCustomAdCloseBtnRightTop) {
            height = kAdViewWidth/kAdViewScale;
        }
        self.frame = CGRectMake(0, 0, kAdViewWidth, height);
        
        
        self.backgroundColor = [UIColor clearColor];
        
        [self.adImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            if (adCloseBtnType == FWCustomAdCloseBtnBottom) {
                make.bottom.equalTo(self).offset(-kCloseBtnSize.height-kCloseBtnMargin);
            } else if (adCloseBtnType == FWCustomAdCloseBtnRightTop) {
                make.bottom.equalTo(self);
            }
        }];
        
        if (adCloseBtnType == FWCustomAdCloseBtnBottom) {
            [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(kCloseBtnSize);
                make.centerX.bottom.equalTo(self);
            }];
        } else if (adCloseBtnType == FWCustomAdCloseBtnRightTop) {
            [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kCloseBtnSize.width/1.5, kCloseBtnSize.height/1.5));
                make.top.equalTo(self).offset(kCloseBtnMargin/2);
                make.right.equalTo(self).offset(-kCloseBtnMargin/2);
            }];
        }
        
        [self configProperty];
    }
    return self;
}

- (void)configProperty
{
    FWPopupBaseViewProperty *property = [FWPopupBaseViewProperty manager];
    property.popupAlignment = FWPopupAlignmentCenter;
    property.popupAnimationStyle = FWPopupAnimationStyleScale;
    // property.maskViewColor = [UIColor colorWithWhite:0 alpha:0.2];
    self.vProperty = property;
}

- (void)closeBtnAction
{
    [self hide];
}

- (UIImageView *)adImgView
{
    if (!_adImgView) {
        _adImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fw_ad"]];
        _adImgView.layer.cornerRadius = 5;
        _adImgView.clipsToBounds = YES;
        [self addSubview:_adImgView];
    }
    return _adImgView;
}

- (UIButton *)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"fw_close"] forState:UIControlStateNormal];
        [self addSubview:_closeBtn];
    }
    return _closeBtn;
}

@end
