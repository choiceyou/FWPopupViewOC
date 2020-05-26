//
//  FWAreaPickerView.m
//  SafeAreaTest
//
//  Created by xfg on 2018/6/6.
//  Copyright © 2018年 xfg. All rights reserved.
//

#import "FWAreaPickerView.h"

static const float kBtnWidth = 50;

@interface FWAreaPickerView() <UIPickerViewDelegate, UIPickerViewDataSource>

/**
 城市列表最原始数据
 */
@property (nonatomic, strong) NSArray *originArray;

@property (nonatomic, strong) NSMutableArray *provinceArray;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, strong) NSMutableArray *areaArray;
@property (nonatomic, strong) NSMutableArray *selectedArray;

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation FWAreaPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    if (self.frame.size.width == 0 || self.frame.size.height == 0) {
        CGRect tmpFrame = self.frame;
        tmpFrame.size.width = self.attachedView.frame.size.width;
        tmpFrame.size.height = 280;
        self.frame = tmpFrame;
    }
    
    if (!self.vProperty) {
        self.vProperty = [[FWPopupBaseViewProperty alloc] init];
    }
    
    [self addSubview:self.pickerView];
    [self addSubview:self.confirmBtn];
    [self addSubview:self.cancelBtn];
    
    [self.originArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.provinceArray addObject:obj[@"state"]];
    }];
    
    NSMutableArray *citys = [NSMutableArray arrayWithArray:[self.originArray firstObject][@"cities"]];
    [citys enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.cityArray addObject:obj[@"city"]];
    }];
    
    self.areaArray = [citys firstObject][@"area"];
}

- (void)showWithStateBlock:(FWPopupStateBlock)stateBlock
{
    self.vProperty.popupAlignment = FWPopupAlignmentBottomCenter;
    self.vProperty.touchWildToHide = @"1";
    
    [super showWithStateBlock:stateBlock];
}


#pragma mark - ----------------------- UIPickerViewDataSource -----------------------

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return self.areaArray.count;
    }
}


#pragma mark - ----------------------- UIPickerViewDelegate -----------------------

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        self.selectedArray = self.originArray[row][@"cities"];
        
        [self.cityArray removeAllObjects];
        [self.selectedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.cityArray addObject:obj[@"city"]];
        }];
        
        self.areaArray = [NSMutableArray arrayWithArray:[self.selectedArray firstObject][@"areas"]];
        
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    else if (component == 1)
    {
        if (self.selectedArray.count == 0)
        {
            self.selectedArray = [self.originArray firstObject][@"cities"];
        }
        
        self.areaArray = [NSMutableArray arrayWithArray:[self.selectedArray objectAtIndex:row][@"areas"]];
        
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    else
    {
        
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    //设置分割线的颜色
    [pickerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.frame.size.height <=1) {
            obj.backgroundColor = self.vProperty.splitColor;
        }
    }];
    
    NSString *text;
    if (component == 0) {
        text =  self.provinceArray[row];
    }else if (component == 1){
        text =  self.cityArray[row];
    }else{
        if (self.areaArray.count > 0) {
            text = self.areaArray[row];
        }else{
            text =  @"";
        }
    }
    
    UILabel *label = [[UILabel alloc]init];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:17]];
    [label setText:text];
    return label;
}


#pragma mark - ----------------------- private methods 私有方法 -----------------------

- (void)confirmAction
{
    NSInteger index0 = [self.pickerView selectedRowInComponent:0];
    NSInteger index1 = [self.pickerView selectedRowInComponent:1];
    NSInteger index2 = [self.pickerView selectedRowInComponent:2];
    
    NSString *province = self.provinceArray[index0];
    NSString *city = self.cityArray[index1];
    NSString *area = @"";
    if (self.areaArray.count != 0) {
        area = self.areaArray[index2];
    }
    
    if (self.confirmBlock) {
        self.confirmBlock(province, city, area);
    }
    
    [self hide];
}

- (void)cancelAction
{
    [self hide];
}


#pragma mark - ----------------------- GET/SET -----------------------

- (NSArray *)originArray
{
    if (!_originArray) {
        NSString *path = [[NSBundle bundleForClass:[FWAreaPickerView class]] pathForResource:@"area_cn" ofType:@"plist"];
        _originArray = [[NSArray alloc]initWithContentsOfFile:path];
    }
    return _originArray;
}

- (NSMutableArray *)provinceArray
{
    if (!_provinceArray) {
        _provinceArray = [NSMutableArray array];
    }
    return _provinceArray;
}

- (NSMutableArray *)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}

- (NSMutableArray *)areaArray
{
    if (!_areaArray) {
        _areaArray = [NSMutableArray array];
    }
    return _areaArray;
}

- (NSMutableArray *)selectedArray
{
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.vProperty.buttonHeight, self.frame.size.width, self.frame.size.height)];
        _pickerView.backgroundColor = [UIColor clearColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (UIButton *)confirmBtn
{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(self.attachedView.frame.size.width-kBtnWidth, 0, kBtnWidth, self.vProperty.buttonHeight);
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:self.vProperty.itemNormalColor forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = [UIColor clearColor];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:self.vProperty.buttonFontSize];
        [_confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(0, 0, kBtnWidth, self.vProperty.buttonHeight);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:self.vProperty.itemNormalColor forState:UIControlStateNormal];
        _cancelBtn.backgroundColor = [UIColor clearColor];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:self.vProperty.buttonFontSize];
        [_cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

@end
