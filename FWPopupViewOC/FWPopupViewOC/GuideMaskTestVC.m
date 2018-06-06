//
//  GuideMaskTestVC.m
//  FWPopupViewOC
//
//  Created by xfg on 2018/6/5.
//  Copyright © 2018年 xfg. All rights reserved.
//

#import "GuideMaskTestVC.h"
#import "FWGuideMaskView.h"

@interface GuideMaskTestVC () <FWGuideMaskViewDataSource>

@end

@implementation GuideMaskTestVC

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)showAction:(id)sender
{
    FWGuideMaskView *guideMaskView = [[FWGuideMaskView alloc] init];
    guideMaskView.dataSource = self;
    [guideMaskView show];
}

- (NSString *)guideMaskView:(FWGuideMaskView *)guideMaskView descriptionForItemAtIndex:(NSInteger)index {
    return [NSString stringWithFormat:@"这是第 %zi 个视图的描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述", index];
}

- (UIView *)guideMaskView:(FWGuideMaskView *)guideMaskView viewForItemAtIndex:(NSInteger)index {
    return self.collectionViews[index];
}

- (NSInteger)numberOfItemsInGuideMaskView:(FWGuideMaskView *)guideMaskView {
    return self.collectionViews.count;
}

- (CGFloat)guideMaskView:(FWGuideMaskView *)guideMaskView cornerRadiusForItemAtIndex:(NSInteger)index
{
    if (index == self.collectionViews.count-1) {
        return 30;
    }
    return 5;
}

@end
