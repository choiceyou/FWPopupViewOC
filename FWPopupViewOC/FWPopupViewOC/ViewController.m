//
//  ViewController.m
//  FWPopupViewOC
//
//  Created by xfg on 2017/5/25.
//  Copyright © 2018年 xfg. All rights reserved.
//

#import "ViewController.h"
#import "FWCustomView.h"
#import "GuideMaskTestVC.h"
#import "FWAreaPickerView.h"
#import "FWPanPopupView.h"
#import "FWCustomView2.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) FWCustomView2 *customView2;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleArray = @[@"center - scale", @"topCenter - position (支持拖拽关闭弹窗)", @"topCenter - frame", @"topCenter - scale", @"leftCenter - position (支持拖拽关闭弹窗)", @"leftCenter - frame (支持拖拽关闭弹窗)", @"leftCenter - scale (支持拖拽关闭弹窗)", @"bottomCenter - position (「弹簧」振动效果)", @"bottomCenter - frame", @"bottomCenter - scale", @"rightCenter - position (支持拖拽关闭弹窗)", @"rightCenter - frame (支持拖拽关闭弹窗)", @"rightCenter - scale", @"GuideMaskTest", @"AreaPickerTest"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    self.tableView.estimatedRowHeight = 44.0;
    
    // 相关属性可以放FWCustomView2里面，注意这边不需要 addSubview 操作，因为弹窗是默认放在window上面的
    self.customView2 = [[FWCustomView2 alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.6, [UIScreen mainScreen].bounds.size.height * 0.3)];
    // 当然，也可以手动修改弹窗放置在某一个view上面
    //    self.customView2.attachedView = self.view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    if (indexPath.row == 13) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            // 显示弹窗时相当简单，只需要调用 show 方法即可
            [self.customView2 show];
        }
            break;
        case 1:
        {
            // 这边演示可拖拽的弹窗，非常适合上下左右侧滑菜单的实现
            FWPanPopupView *customView = [[FWPanPopupView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.4)];
            
            FWPopupBaseViewProperty *property = [FWPopupBaseViewProperty manager];
            property.popupAlignment = FWPopupAlignmentTopCenter;
            property.popupAnimationStyle = FWPopupAnimationStylePosition;
            property.maskViewColor = [UIColor colorWithWhite:0 alpha:0.5];
            property.touchWildToHide = @"1";
            property.popupEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            property.animationDuration = 0.5;
            customView.vProperty = property;
            
            [customView showWithDidAppearBlock:^(FWPopupBaseView *popupBaseView) {
                NSLog(@"showWithDidAppearBlock");
            }];
        }
            break;
        case 2:
        {
            FWCustomView *customView = [[FWCustomView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.4)];
            
            FWPopupBaseViewProperty *property = [FWPopupBaseViewProperty manager];
            property.popupAlignment = FWPopupAlignmentTopCenter;
            property.popupAnimationStyle = FWPopupAnimationStyleFrame;
            property.maskViewColor = [UIColor colorWithWhite:0 alpha:0.5];
            property.touchWildToHide = @"1";
            property.popupEdgeInsets = UIEdgeInsetsMake(64, 0, 0, 0);
            property.animationDuration = 0.5;
            property.shouldClearSpilthMask = YES;
            customView.vProperty = property;
            
            [customView showWithStateBlock:^(FWPopupBaseView *popupBaseView, FWPopupState popupState) {
                NSLog(@"弹窗当前状态：%ld",(long)popupState);
            }];
        }
            break;
        case 3:
        {
            FWCustomView *customView = [[FWCustomView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height * 0.4)];
            
            FWPopupBaseViewProperty *property = [FWPopupBaseViewProperty manager];
            property.popupAlignment = FWPopupAlignmentTopCenter;
            property.popupAnimationStyle = FWPopupAnimationStyleScale;
            property.maskViewColor = [UIColor colorWithWhite:0 alpha:0.5];
            property.touchWildToHide = @"1";
            property.popupEdgeInsets = UIEdgeInsetsMake(64, 0, 0, 0);
            property.animationDuration = 0.5;
            customView.vProperty = property;
            
            [customView show];
        }
            break;
            
        case 4:
        {
            FWPanPopupView *customView = [[FWPanPopupView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.6, [UIScreen mainScreen].bounds.size.height)];
            
            FWPopupBaseViewProperty *property = [FWPopupBaseViewProperty manager];
            property.popupAlignment = FWPopupAlignmentLeftCenter;
            property.popupAnimationStyle = FWPopupAnimationStylePosition;
            property.maskViewColor = [UIColor colorWithWhite:0 alpha:0.5];
            property.touchWildToHide = @"1";
            property.popupEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            property.animationDuration = 0.3;
            customView.vProperty = property;
            
            [customView show];
        }
            break;
        case 5:
        {
            FWPanPopupView *customView = [[FWPanPopupView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height)];
            
            FWPopupBaseViewProperty *property = [FWPopupBaseViewProperty manager];
            property.popupAlignment = FWPopupAlignmentLeftCenter;
            property.popupAnimationStyle = FWPopupAnimationStyleFrame;
            property.maskViewColor = [UIColor colorWithWhite:0 alpha:0.5];
            property.touchWildToHide = @"1";
            property.popupEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            property.animationDuration = 0.3;
            customView.vProperty = property;
            
            [customView show];
        }
            break;
        case 6:
        {
            FWPanPopupView *customView = [[FWPanPopupView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.4, [UIScreen mainScreen].bounds.size.height * 0.5)];
            
            FWPopupBaseViewProperty *property = [FWPopupBaseViewProperty manager];
            property.popupAlignment = FWPopupAlignmentLeftCenter;
            property.popupAnimationStyle = FWPopupAnimationStyleScale;
            property.maskViewColor = [UIColor colorWithWhite:0 alpha:0.5];
            property.touchWildToHide = @"1";
            property.popupEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
            property.animationDuration = 0.3;
            customView.vProperty = property;
            
            [customView show];
        }
            break;
            
        case 7:
        {
            FWCustomView *customView = [[FWCustomView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-20, [UIScreen mainScreen].bounds.size.height * 0.4)];
            
            FWPopupBaseViewProperty *property = [FWPopupBaseViewProperty manager];
            property.popupAlignment = FWPopupAlignmentBottomCenter;
            property.popupAnimationStyle = FWPopupAnimationStylePosition;
            property.maskViewColor = [UIColor colorWithWhite:0 alpha:0.5];
            property.touchWildToHide = @"1";
            property.popupEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0);
            property.animationDuration = 0.5;
            property.usingSpringWithDamping = 0.7;
            customView.vProperty = property;
            
            [customView show];
        }
            break;
        case 8:
        {
            FWCustomView *customView = [[FWCustomView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.4)];
            
            FWPopupBaseViewProperty *property = [FWPopupBaseViewProperty manager];
            property.popupAlignment = FWPopupAlignmentBottomCenter;
            property.popupAnimationStyle = FWPopupAnimationStyleFrame;
            property.maskViewColor = [UIColor colorWithWhite:0 alpha:0.5];
            property.touchWildToHide = @"1";
            property.popupEdgeInsets = UIEdgeInsetsMake(0, 0, 64, 0);
            property.animationDuration = 0.5;
            property.shouldClearSpilthMask = YES;
            customView.vProperty = property;
            
            [customView show];
        }
            break;
        case 9:
        {
            FWCustomView *customView = [[FWCustomView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height * 0.4)];
            
            FWPopupBaseViewProperty *property = [FWPopupBaseViewProperty manager];
            property.popupAlignment = FWPopupAlignmentBottomCenter;
            property.popupAnimationStyle = FWPopupAnimationStyleScale;
            property.maskViewColor = [UIColor colorWithWhite:0 alpha:0.5];
            property.touchWildToHide = @"1";
            property.popupEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            property.animationDuration = 0.5;
            customView.vProperty = property;
            
            [customView show];
        }
            break;
            
        case 10:
        {
            FWPanPopupView *customView = [[FWPanPopupView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.6, [UIScreen mainScreen].bounds.size.height)];
            
            FWPopupBaseViewProperty *property = [FWPopupBaseViewProperty manager];
            property.popupAlignment = FWPopupAlignmentRightCenter;
            property.popupAnimationStyle = FWPopupAnimationStylePosition;
            property.maskViewColor = [UIColor colorWithWhite:0 alpha:0.5];
            property.touchWildToHide = @"1";
            property.popupEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            property.animationDuration = 0.3;
            customView.vProperty = property;
            
            [customView show];
        }
            break;
        case 11:
        {
            FWPanPopupView *customView = [[FWPanPopupView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height)];
            
            FWPopupBaseViewProperty *property = [FWPopupBaseViewProperty manager];
            property.popupAlignment = FWPopupAlignmentRightCenter;
            property.popupAnimationStyle = FWPopupAnimationStyleFrame;
            property.maskViewColor = [UIColor colorWithWhite:0 alpha:0.5];
            property.touchWildToHide = @"1";
            property.popupEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50);
            property.animationDuration = 0.3;
            customView.vProperty = property;
            
            [customView show];
        }
            break;
        case 12:
        {
            FWCustomView *customView = [[FWCustomView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.4, [UIScreen mainScreen].bounds.size.height * 0.5)];
            
            FWPopupBaseViewProperty *property = [FWPopupBaseViewProperty manager];
            property.popupAlignment = FWPopupAlignmentRightCenter;
            property.popupAnimationStyle = FWPopupAnimationStyleScale;
            property.maskViewColor = [UIColor colorWithWhite:0 alpha:0.5];
            property.touchWildToHide = @"1";
            property.popupEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            property.animationDuration = 0.3;
            customView.vProperty = property;
            
            customView.attachedView = self.view;
            
            [customView show];
        }
            break;
        case 13:
            [self.navigationController pushViewController:[[GuideMaskTestVC alloc] init] animated:YES];
            break;
        case 14:
        {
            FWAreaPickerView *areaPickerView = [[FWAreaPickerView alloc] init];
            areaPickerView.confirmBlock = ^(NSString *province, NSString *city, NSString *area) {
                NSLog(@"您当前选择了：%@ %@ %@",province,city,area);
            };
            [areaPickerView show];
        }
            break;
            
        default:
            break;
    }
}

@end
