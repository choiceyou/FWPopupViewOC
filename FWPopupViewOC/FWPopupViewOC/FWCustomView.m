//
//  FWCustomView.m
//  FWPopupViewOC
//
//  Created by xfg on 2017/5/28.
//  Copyright © 2018年 xfg. All rights reserved.
//

#import "FWCustomView.h"

@implementation FWCustomView

- (void)dealloc
{
    NSLog(@"111111111111111");
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
