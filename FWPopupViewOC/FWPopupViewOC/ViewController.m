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
#import "FWCustomView3.h"
#import "Masonry.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) FWCustomView2 *customView2;
@property (nonatomic, strong) FWCustomView3 *customView3;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleArray = @[@"center - scale", @"topCenter - position (支持拖拽关闭弹窗)", @"topCenter - frame（shouldClearSpilthMask属性为YES，不支持横竖屏切换）", @"topCenter - scale", @"leftCenter - position (支持拖拽关闭弹窗)", @"leftCenter - frame (支持拖拽关闭弹窗)", @"leftCenter - scale (支持拖拽关闭弹窗)", @"bottomCenter - position (「弹簧」振动效果)", @"bottomCenter - frame（shouldClearSpilthMask属性为YES，不支持横竖屏切换）", @"bottomCenter - scale", @"rightCenter - position (支持拖拽关闭弹窗)", @"rightCenter - frame (支持拖拽关闭弹窗)", @"rightCenter - scale", @"GuideMaskTest(不支持横竖屏切换)", @"AreaPickerTest", @"同时显示两个弹窗", @"自定义带有箭头的弹窗"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    self.tableView.estimatedRowHeight = 44.0;
    
    // 相关属性可以放FWCustomView2里面，注意这边不需要 addSubview 操作，因为弹窗是默认放在window上面的
    self.customView2 = [[FWCustomView2 alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.6, [UIScreen mainScreen].bounds.size.height * 0.3)];
    self.customView2.backgroundColor = [UIColor yellowColor];
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
            
            [customView showWithStateBlock:^(FWPopupBaseView *popupBaseView, FWPopupState popupState) {
                NSLog(@"%ld", (long)popupState);
            }];
        }
            break;
        case 2:
        {
            FWCustomView *customView2 = [[FWCustomView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.4)];
            
            FWPopupBaseViewProperty *property2 = [FWPopupBaseViewProperty manager];
            property2.popupAlignment = FWPopupAlignmentTopCenter;
            property2.popupAnimationStyle = FWPopupAnimationStyleFrame;
            property2.maskViewColor = [UIColor colorWithWhite:0 alpha:0.5];
            property2.touchWildToHide = @"1";
            property2.popupEdgeInsets = UIEdgeInsetsMake(64, 0, 0, 0);
            property2.animationDuration = 0.5;
            property2.shouldClearSpilthMask = YES;
            customView2.vProperty = property2;
            
            [customView2 showWithStateBlock:^(FWPopupBaseView *popupBaseView, FWPopupState popupState) {
                NSLog(@"弹窗当前状态：%ld",(long)popupState);
            }];
        }
            break;
        case 3:
        {
            /**
             如要初始化视图后要设置当前视图的约束，必须要使用该方法，因为这个方法会提前将当前视图加入父视图，使用该方法有以下几个注意点：
             1、使用该方法不支持更换父视图，即不支持修改：attachedView；
             2、使用该方法不建议把当前视图设置为成员变量，因为调用隐藏方法时会把当前视图从父视图中移除，调用显示方法后会重新添加到父视图，此时约束就会丢失相对于父视图的那部分；
             3、有些约束可能会影响到某些动画的效果。
             */
            FWCustomView *customView = [[FWCustomView alloc] initWithConstraints];
            [customView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(customView.superview.mas_width).multipliedBy(0.5);
                make.height.equalTo(customView.superview.mas_height).multipliedBy(0.4);
            }];
            
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
        case 15:
        {
            [self.customView2 show];
            
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
        case 16:
            [self.customView3 show];
            break;
            
        default:
            break;
    }
}


- (FWCustomView3 *)customView3
{
    if (!_customView3) {
        _customView3 = [[FWCustomView3 alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.6, [UIScreen mainScreen].bounds.size.height * 0.6)];
    }
    return _customView3;
}

@end
