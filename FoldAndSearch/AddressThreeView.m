//
//  AddressThreeView.m
//  JHB
//
//  Created by JJT on 17/1/6.
//  Copyright © 2017年 SJZ. All rights reserved.
//

#import "AddressThreeView.h"
#import "HttpService.h"
#import "AddressModel.h"

@implementation AddressThreeView

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        _isNew = YES;
        self.proviceArr = @[].mutableCopy;
        self.cityArr = @[].mutableCopy;
        self.districtArr = @[].mutableCopy;
       
        [self creatAlertView];

    }
    
    return self;
}

- (void)creatAlertView{

    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.5;
    [self addSubview:backView];
    
    
    addView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-200, self.frame.size.width, 200)];
    addView.backgroundColor = [UIColor whiteColor];
    [self addSubview:addView];
    
    
    UIButton * leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 50)];
    [leftBtn addTarget:self action:@selector(deleBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [addView addSubview:leftBtn];
    

    UIButton * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-60, 0, 60, 50)];
    [rightBtn addTarget:self action:@selector(deterBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [addView addSubview:rightBtn];
    
    UILabel *xixianL = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(rightBtn.frame), self.frame.size.width, 0.5)];
    xixianL.backgroundColor = [UIColor grayColor];
    [addView addSubview:xixianL];
    
    
    [self getPickerData:@"1" parentAreaNo:@"10000"];
    
    
}

- (void)deterBtnPress{
    AddressModel *addressM = self.proviceArr[[self.pickerView selectedRowInComponent:0]];
    AddressModel *addressMM = self.cityArr[[self.pickerView selectedRowInComponent:1]];
    AddressModel *addressMMM = self.districtArr[[self.pickerView selectedRowInComponent:2]];
    
    NSString *provice = addressM.areaname;
    NSString *city = addressMM.areaname;
    NSString *district = addressMMM.areaname;
    
    NSLog(@"%@-%@-%@",provice,city,district);
    
    NSDictionary *dic = @{@"provice":@{@"areaname":addressM.areaname,@"areano":addressM.areano},@"city":@{@"areaname":addressMM.areaname,@"areano":addressMM.areano},@"district":@{@"areaname":addressMMM.areaname,@"areano":addressMMM.areano}};
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"defaultCenterVCVC" object:nil userInfo:dic];
    self.hidden = YES;

}
//省
- (void)getPickerData:(NSString*)areaType parentAreaNo:(NSString*)parentAreaNo{

    [HttpService getServiceWithMothedName:@"app/area/listByParentAreaNo" params:@{@"parentAreaNo":parentAreaNo,@"areaType":areaType} succeed:^(id response) {
        NSLog(@"response:%@",response);
        
        if ([[response objectForKey:@"success"] integerValue]==1) {
            
            NSArray *dataArr = [response objectForKey:@"data"];
            
            
            for (int i = 0; i < dataArr.count; i ++) {
                
                NSDictionary *dic = dataArr[i];
                AddressModel *addressM = [[AddressModel alloc]init];
                addressM.areaname = [dic objectForKey:@"areaname"];
                addressM.areano = [dic objectForKey:@"areano"];
                addressM.areatype = [dic objectForKey:@"areatype"];
                addressM.parentareaname = [dic objectForKey:@"parentareaname"];
                addressM.parentareano = [dic objectForKey:@"parentareano"];
      
                [self.proviceArr addObject:addressM];
                NSLog(@"proviceArr:%lu",(unsigned long)self.proviceArr.count);
                
                
                if (i==0) {
                    
                [self getPickerData:@"2" cityAreaNo:addressM.areano];
                    
                }
        
            }

            
            
        }

    
    }];

}
//市
- (void)getPickerData:(NSString*)areaType cityAreaNo:(NSString*)parentAreaNo{

    [HttpService getServiceWithMothedName:@"app/area/listByParentAreaNo" params:@{@"parentAreaNo":parentAreaNo,@"areaType":areaType} succeed:^(id response) {
        NSLog(@"response:%@",response);
        [self.cityArr removeAllObjects];
        if ([[response objectForKey:@"success"] integerValue]==1) {
            
            NSArray *dataArr = [response objectForKey:@"data"];
            for (int i = 0; i < dataArr.count; i ++) {
                
                NSDictionary *dic = dataArr[i];
                AddressModel *addressM = [[AddressModel alloc]init];
                addressM.areaname = [dic objectForKey:@"areaname"];
                addressM.areano = [dic objectForKey:@"areano"];
                addressM.areatype = [dic objectForKey:@"areatype"];
                addressM.parentareaname = [dic objectForKey:@"parentareaname"];
                addressM.parentareano = [dic objectForKey:@"parentareano"];

                [self.cityArr addObject:addressM];
                if (i==0) {
                    
                    [self getPickerData:@"3" districtAreaNo:addressM.areano];
                    
                }
                
            }
            [_pickerView reloadComponent:1];
        }
        
    }];
    
}


//区
- (void)getPickerData:(NSString*)areaType districtAreaNo:(NSString*)parentAreaNo{
    static NSInteger count = 1;
    [HttpService getServiceWithMothedName:@"app/area/listByParentAreaNo" params:@{@"parentAreaNo":parentAreaNo,@"areaType":areaType} succeed:^(id response) {
        NSLog(@"response:%@",response);
        [self.districtArr removeAllObjects];
        if ([[response objectForKey:@"success"] integerValue]==1) {
            
            NSArray *dataArr = [response objectForKey:@"data"];
   
            for (int i = 0; i < dataArr.count; i ++) {
                
                NSDictionary *dic = dataArr[i];
                AddressModel *addressM = [[AddressModel alloc]init];
                addressM.areaname = [dic objectForKey:@"areaname"];
                addressM.areano = [dic objectForKey:@"areano"];
                addressM.areatype = [dic objectForKey:@"areatype"];
                addressM.parentareaname = [dic objectForKey:@"parentareaname"];
                addressM.parentareano = [dic objectForKey:@"parentareano"];
  
                [self.districtArr addObject:addressM];
                
            }
            [_pickerView reloadComponent:2];
            NSLog(@"count:%ld",(long)count);
            if (count == 1) {
                _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0,51, self.frame.size.width, 150)];
                _pickerView.dataSource = self;
                _pickerView.backgroundColor = [UIColor whiteColor];
                _pickerView.delegate = self;
                [addView addSubview:_pickerView];
                count++;
                
            }

        }

    }];
    
}



- (void)deleBtnPress{

    self.hidden = YES;
}

// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 3;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0) {
        
        return self.proviceArr.count;
    } else if (component == 1) {
        
        return self.cityArr.count;
    } else {
        
        return self.districtArr.count;
    }
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    if (component == 0) {
        return self.frame.size.width/3-10;
    } else if (component == 1) {
        return self.frame.size.width/3-10;
    } else {
        return self.frame.size.width/3-10;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    
    return 50;
}


//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        
        AddressModel *addressM = self.proviceArr[row];
        return addressM.areaname;
        
    } else if (component == 1) {
    
        AddressModel *addressM = self.cityArr[row];
        return addressM.areaname;
        
    } else {
        
        AddressModel *addressM = self.districtArr[row];
        return addressM.areaname;
        
    }
}

// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        
        AddressModel *addressM = self.proviceArr[row];
        [self getPickerData:@"2" cityAreaNo:addressM.areano];
        
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    
    if (component == 1) {

        AddressModel *addressM = self.cityArr[row];
//        [self getPickerData:@"3" cityAreaNo:addressM.areano];
        [self getPickerData:@"3" districtAreaNo:addressM.areano];
    }
    
     [pickerView reloadComponent:2];

}


//重写方法
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = [UIColor grayColor];
        }
    }
    UILabel* pickerLabel = (UILabel*)view;
    
    
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:16]];

    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}



@end
