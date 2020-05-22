//
//  FWNavigationController.m
//  FWPopupViewOC
//
//  Created by xfg on 2019/7/20.
//  Copyright © 2019 xfg. All rights reserved.
//

#import "FWNavigationController.h"

@interface FWNavigationController ()

@end

@implementation FWNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)prefersStatusBarHidden
{
    if (self.topViewController) {
        return [self.topViewController prefersStatusBarHidden];
    } else {
        return YES;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (self.topViewController) {
        return [self.topViewController preferredStatusBarStyle];
    } else {
        return UIStatusBarStyleDefault;
    }
}

@end
