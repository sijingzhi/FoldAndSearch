//
//  FoldViewController.m
//  FoldAndSearch
//
//  Created by JJT on 17/3/17.
//  Copyright © 2017年 SJZ. All rights reserved.
//

#import "FoldViewController.h"
#import "XDMultTableView.h"
@interface FoldViewController ()<XDMultTableViewDatasource,XDMultTableViewDelegate>{


    UIView *view;
    NSArray *titleArr;
    NSMutableArray *nameArr;
    
    NSArray *SFArr;
    NSArray *CFArr;
    NSArray *PFArr;
    NSArray *SGArr;
    NSArray *PGArr;
}


@property(nonatomic, readwrite, strong) XDMultTableView *tableView;

@end

@implementation FoldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人观点";
    
    nameArr = @[].mutableCopy;
    _tableView = [[XDMultTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.openSectionArray = [NSArray arrayWithObjects:@1,@2, nil];
    _tableView.delegate = self;
    _tableView.datasource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    
    titleArr = @[@"小前锋",@"大前锋",@"中锋",@"得分后卫",@"控球后卫"];
    SFArr = @[@"詹姆斯",@"杜兰特",@"伦纳德",@"安东尼"];
    CFArr = @[@"奥尼尔",@"张伯伦",@"霍华德",@"姚明",@"考辛斯",@"加索尔"];
    PFArr = @[@"邓肯",@"诺维茨基",@"格里芬",@"阿尔德里奇",@"波什"];
    SGArr = @[@"乔丹",@"科比",@"韦德",@"哈登"];
    PGArr = @[@"魔术师",@"保罗",@"斯托克斯",@"纳什",@"韦少",@"库里",@"欧文"];
    
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"返回", nil)
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self action:@selector(goToBack)];
    leftButton.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    
}

- (void)goToBack{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - datasource
- (NSInteger)mTableView:(XDMultTableView *)mTableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (XDMultTableViewCell *)mTableView:(XDMultTableView *)mTableView
              cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [mTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 160)] ;
    view.backgroundColor = [UIColor yellowColor];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addSubview:view];
    
    switch (indexPath.section) {
        case 0:
            
            nameArr = [NSMutableArray arrayWithArray:SFArr];
            break;
        case 1:
            
            nameArr = [NSMutableArray arrayWithArray:PFArr];
            break;
        case 2:
            
            nameArr = [NSMutableArray arrayWithArray:CFArr];
            break;
        case 3:
            
            nameArr = [NSMutableArray arrayWithArray:SGArr];
            break;
        case 4:
            
            nameArr = [NSMutableArray arrayWithArray:PGArr];
            break;
       
        default:
            break;
    }

    for (int i = 0; i < nameArr.count; i ++)
    {
        UILabel *  nameL  = [[UILabel alloc]init];
        nameL.center = CGPointMake(self.view.frame.size.width/8 * (i%3 + 1)*2,(i/3 +2) * 45 - 60);
        nameL.bounds = CGRectMake(0, 0, 76, 40);
        nameL.layer.cornerRadius = 5.f;
        nameL.layer.masksToBounds = YES;
        nameL.backgroundColor = [UIColor redColor];
        nameL.font = [UIFont systemFontOfSize:14];
        nameL.textAlignment = NSTextAlignmentCenter;
        nameL.text = nameArr[i];
        [view addSubview:nameL];
        
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(XDMultTableView *)mTableView{
    return 5;
}



- (NSString *)mTableView:(XDMultTableView *)mTableView titleForHeaderInSection:(NSInteger)section{
 
    return [NSString stringWithFormat:@"%@",titleArr[section]];
}

#pragma mark - delegate
- (CGFloat)mTableView:(XDMultTableView *)mTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 160;
    
  
}

- (CGFloat)mTableView:(XDMultTableView *)mTableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}


- (void)mTableView:(XDMultTableView *)mTableView willOpenHeaderAtSection:(NSInteger)section{
    NSLog(@"即将展开:%ld",(long)section);
 
    
}

- (void)mTableView:(XDMultTableView *)mTableView willCloseHeaderAtSection:(NSInteger)section{
    NSLog(@"即将关闭5555:%ld",(long)section);
    
    
}

- (void)mTableView:(XDMultTableView *)mTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击%ld",(long)indexPath.row);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
