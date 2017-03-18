//
//  AddressThreeView.h
//  JHB
//
//  Created by JJT on 17/1/6.
//  Copyright © 2017年 SJZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressThreeView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>{

    UIView *addView;
}


- (id)initWithFrame:(CGRect)frame;
@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSMutableArray *proviceArr;
@property (nonatomic, strong) NSMutableArray *cityArr;
@property (nonatomic, strong) NSMutableArray *districtArr;

@property (nonatomic, assign) BOOL isNew;
@end
