//
//  FWCustomAdView.h
//  FWPopupViewOC
//
//  Created by xfg on 2019/4/24.
//  Copyright © 2019 xfg. All rights reserved.
//

#import "FWPopupBaseView.h"

/**
 关闭按钮位置

 - FWCustomAdCloseBtnBottom: 正下方
 - FWCustomAdCloseBtnRightTop: 右上角
 */
typedef NS_ENUM(NSUInteger, FWCustomAdCloseBtnType) {
    FWCustomAdCloseBtnBottom = 0,
    FWCustomAdCloseBtnRightTop,
};


NS_ASSUME_NONNULL_BEGIN

@interface FWCustomAdView : FWPopupBaseView

- (instancetype)initWithCloseBtnType:(FWCustomAdCloseBtnType)adCloseBtnType;

@end

NS_ASSUME_NONNULL_END
