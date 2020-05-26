//
//  FWCustomView2.m
//  FWPopupViewOC
//
//  Created by xfg on 2018/6/20.
//  Copyright © 2018年 xfg. All rights reserved.
//

#import "FWCustomView2.h"

@implementation FWCustomView2

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self configProperty];
    }
    return self;
}

- (void)configProperty
{
    FWPopupBaseViewProperty *property = [FWPopupBaseViewProperty manager];
    property.popupAlignment = FWPopupAlignmentCenter;
    property.popupAnimationStyle = FWPopupAnimationStyleScale;
    property.touchWildToHide = @"1";
    //    property.maskViewColor = [UIColor colorWithWhite:0 alpha:0.3];
    //    property.popupEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    //    property.animationDuration = 0.2;
    self.vProperty = property;
}

@end
