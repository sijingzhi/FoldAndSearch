//
//  ViewController.m
//  FoldAndSearch
//
//  Created by JJT on 17/3/17.
//  Copyright © 2017年 SJZ. All rights reserved.
//

#import "ViewController.h"
#import "AddressThreeView.h"
#import "FoldViewController.h"
#import "SearchViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *arr = @[@"索引搜索",@"QQ列表折叠",@"三级地址选择器"];
    
    for (int i = 0; i < 3; i ++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((self.view.frame.size.width-160)/2, 70+75*i, 160, 60);
        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.layer.borderWidth = 1.f;
        btn.tag = 10086+i;
        [btn addTarget:self action:@selector(btnbtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];

    }
    
}

- (void)btnbtn:(UIButton*)btn{
    
    
    switch (btn.tag) {
            
        case 10086:
        {
            
        SearchViewController *searchVC = [SearchViewController new];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:searchVC];
        [self presentViewController:nav animated:YES completion:^{
             
         }];
            
        }
            break;
        case 10087:
        {
            FoldViewController *foldVC = [FoldViewController new];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:foldVC];
            [self presentViewController:nav animated:YES completion:^{
                
            }];
            
        }
            
            break;
        case 10088:
        {
            
            AddressThreeView *addressV = [[AddressThreeView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            
            [self.view addSubview:addressV];
            
        }
            
            
            break;
            
        default:
            break;
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
