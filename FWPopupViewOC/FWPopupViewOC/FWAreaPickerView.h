//
//  FWAreaPickerView.h
//  SafeAreaTest
//
//  Created by xfg on 2018/6/6.
//  Copyright © 2018年 xfg. All rights reserved.
//

#import "FWPopupBaseView.h"

/**
 点击确定按钮回调

 @param province 省
 @param city 市
 @param area 区（县）
 */
typedef void(^FWAraePickerConfirmBlock)(NSString *province, NSString *city, NSString *area);

@interface FWAreaPickerView : FWPopupBaseView

@property (nonatomic, copy) FWAraePickerConfirmBlock confirmBlock;

@end
