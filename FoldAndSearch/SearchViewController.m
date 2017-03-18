//
//  SearchViewController.m
//  FoldAndSearch
//
//  Created by JJT on 17/3/17.
//  Copyright © 2017年 SJZ. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource>{

    UILabel *titleLL;
    NSMutableArray *nameArr;
    NSMutableDictionary *kindDic;
    UILabel *backL;
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *titleArr;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"2017年3月NBA球员";
    
    nameArr = @[].mutableCopy;
    
    nameArr = [NSMutableArray arrayWithObjects:@"德马库斯-考辛斯(鹈鹕)",@"安东尼-戴维斯(鹈鹕)",@"朱-霍勒迪(鹈鹕)",@"欧米尔-阿西克(鹈鹕)",@"昆西-庞德塞特(鹈鹕)",@"德克-诺维茨基(小牛)",@"哈里森-巴恩斯(小牛)",@"纳伦斯-诺埃尔(小牛)",@"何塞-巴里亚(小牛)",@"韦斯利-马修斯(小牛)",@"詹姆斯-哈登(火箭)",@"埃里克-戈登(火箭)",@"帕特里克-贝弗利(火箭)",@"特雷沃-阿里扎(火箭)" ,@"莱恩-安德森(火箭)",@"扎克-兰多夫(灰熊)",@"托尼-阿伦(灰熊)",@"文斯-卡特(灰熊)",@"迈克-康利(灰熊)",@"马克-加索尔(灰熊)",@"马努-吉诺比利(马刺)",@"保罗-加索尔(马刺)",@"拉马库斯-阿尔德里奇(马刺)",@"科怀-伦纳德(马刺)",@"托尼-帕克(马刺)",@"威尔森-钱德勒(掘金)",@"达尼罗-加里纳利(掘金)",@"梅森-普拉姆利(掘金)",@"肯尼思-法里德(掘金)",@"伊曼纽尔-穆迪埃(掘金)",@"里基-卢比奥(森林狼)",@"安德鲁-威金斯(森林狼)",@"扎克-拉文(森林狼)",@"卡尔-安东尼-唐斯(森林狼)",@"克里斯-邓恩(森林狼)",@"乔-约翰逊(爵士)",@"德里克-费沃斯(爵士)",@"戈登-海沃德(爵士)",@"鲁迪-戈贝尔(爵士)",@"丹特-埃克萨姆(爵士)",@"达米安-利拉德(开拓者)",@"CJ-麦科勒姆(开拓者)",@"埃文-特纳(开拓者)",@"艾尔-法鲁克-阿米奴(开拓者)",@"沙巴兹-内皮尔(开拓者)",@"拉塞尔-威斯布鲁克(雷霆)",@"泰-吉布森(雷霆)",@"埃内斯-坎特(雷霆)",@"维克托-奥拉迪波(雷霆)",@"多曼塔斯-萨博尼斯(雷霆)",@"鲁迪-盖伊(国王)",@"阿隆-阿弗拉罗(国王)",@"泰瑞克-埃文斯(国王)",@"巴迪-希尔德(国王)",@"泰-劳森(国王)",@"洛尔-邓(湖人)",@"乔丹-克拉克森(湖人)",@"朱利叶斯-兰德尔(湖人)",@"丹吉洛-拉塞尔(湖人)",@"布兰登-英格拉姆(湖人)",@"莱昂德罗-巴博萨(太阳)",@"埃里克-布莱索(太阳)",@"德文-布克(太阳)",@"泰森-钱德勒(太阳)",@"德拉甘-本德尔(太阳)",@"凯文-杜兰特(勇士)",@"斯蒂芬-库里(勇士)",@"克莱-汤普森(勇士)",@"德雷蒙德-格林(勇士)",@"安德烈-伊格达拉(勇士)",@"克里斯-保罗(快船)",@"布雷克-格里芬(快船)",@"德安德鲁-乔丹(快船)",@"JJ-雷迪克(快船)",@"贾马尔-克劳福德(快船)",@"艾尔-霍弗德(凯尔特人)",@"以赛亚-托马斯(凯尔特人)",@"马库斯-斯马特(凯尔特人)",@"埃弗里-布拉德利(凯尔特人)",@"凯利-奥利尼克(凯尔特人)",@"布鲁克-洛佩斯(篮网)",@"林书豪(篮网)",@"肖恩-基尔帕特里克(篮网)",@"卡里斯-勒韦尔(篮网)",@"朗戴-霍利斯-杰弗森(篮网)",@"卡梅罗-安东尼(尼克斯)",@"德里克-罗斯(尼克斯)",@"克里斯塔普斯-波尔津吉斯(尼克斯)",@"乔金-诺阿(尼克斯)",@"考特尼-李(尼克斯)",@"乔尔-恩比德(76人)",@"达里奥-沙里奇(76人)",@"贾利尔-奥卡福(76人)",@"本-西蒙斯(76人)",@"尼克-斯陶斯卡斯(76人)",@"凯尔-洛瑞(猛龙)",@"赛尔吉-伊巴卡(猛龙)",@"德马尔-德罗赞(猛龙)",@"约纳斯-瓦兰丘纳斯(猛龙)",@"德马雷-卡罗尔(猛龙)",@"克里斯-波什(热火)",@"戈兰-德拉季奇(热火)",@"迪昂-韦特斯(热火)",@"韦恩-艾灵顿(热火)",@"犹多尼斯-哈斯勒姆(热火)",@"俾斯麦-比永博(魔术)",@"杰夫-格林(魔术)",@"特伦斯-罗斯(魔术)",@"埃文-富尼耶(魔术)",@"阿龙-戈登(魔术)",@"约翰-沃尔(奇才)",@"马尔钦-戈塔特(奇才)",@"布拉德利-比尔(奇才)",@"伊安-马辛米(奇才)",@"奥托-波特(奇才)",@"德怀特-霍华德(老鹰)",@"迈克-邓利维(老鹰)",@"何塞-卡尔德隆(老鹰)",@"保罗-米尔萨普(老鹰)",@"小蒂姆-哈达威(老鹰)",@"尼古拉斯-巴图姆(黄蜂)",@"肯巴-沃克(黄蜂)",@"迈克尔-基德-吉尔克里斯特(黄蜂)",@"马科-贝里内利(黄蜂)",@"迈尔斯-普拉姆利(黄蜂)",@"德维恩-韦德(公牛)",@"拉简-隆多(公牛)",@"吉米-巴特勒(公牛)",@"迈克尔-卡特-威廉姆斯(公牛)",@"尼古拉-米罗蒂奇(公牛)",@"勒布朗-詹姆斯(骑士)",@"凯文-乐福(骑士)",@"凯里-欧文(骑士)",@"特里斯坦-汤普森(骑士)",@"德隆-威廉姆斯(骑士)",@"安德烈-德拉蒙德(活塞)",@"斯坦利-约翰逊(活塞)",@"肯塔维厄斯-考德威尔-波普(活塞)",@"马库斯-莫里斯(活塞)",@"雷吉-杰克逊(活塞)",@"杰夫-蒂格(步行者)",@"保罗-乔治(步行者)",@"阿隆-布鲁克斯(步行者)",@"蒙塔-埃利斯(步行者)",@"艾尔-杰弗森(步行者)",@"扬尼斯-阿德托昆博(雄鹿)",@"克里斯-米德尔顿(雄鹿)",@"贾巴里-帕克(雄鹿)",@"马修-戴拉维多瓦(雄鹿)",@"马尔科姆-布罗格登(雄鹿)",@"韦德（公牛）",nil];
    
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"返回", nil)
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self action:@selector(goToBack)];
    leftButton.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.userInteractionEnabled = YES;
    [self.view addSubview:_tableView];
    
    // 索引文字的颜色  默认蓝色
    _tableView.sectionIndexColor = [UIColor blackColor];
    _tableView.sectionIndexMinimumDisplayRowCount = 3;
    // 索引背景颜色   默认透明
    _tableView.sectionIndexBackgroundColor = [UIColor whiteColor];
    // 点击索引后出现的颜色  默认透明
    _tableView.sectionIndexTrackingBackgroundColor = [UIColor whiteColor];

    
    kindDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    for (char i = 'A'; i <= 'Z'; i ++)
    {
        NSMutableArray * arr = [[NSMutableArray alloc]init];
        
        [kindDic setObject:arr forKey:[NSString stringWithFormat:@"%c",i]];
    }
  
    NSLog(@"___%@",kindDic);
  
    
    [self cityArrWithArray:nameArr];
    
    backL = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-80)/2,(self.view.frame.size.height-80-64)/2 , 80, 80)];
//    backL
    backL.backgroundColor = [UIColor blackColor];
    backL.text = @"A";
    backL.hidden = YES;
    backL.textColor = [UIColor whiteColor];
    backL.font = [UIFont boldSystemFontOfSize:26.f];
    backL.alpha = 0.5;
    backL.textAlignment = NSTextAlignmentCenter;
    backL.layer.cornerRadius = 5.f;
    backL.layer.masksToBounds = YES;
    [self.view addSubview:backL];
    
}

- (void)goToBack{

    [self dismissViewControllerAnimated:YES completion:nil];
}
//城市字典
-(void)cityArrWithArray:(NSMutableArray *)arr
{
    for (char i = 'A'; i <= 'Z'; i ++)
    {
        NSMutableArray * arra = [kindDic objectForKey:[NSString stringWithFormat:@"%c",i]];
        [arra removeAllObjects];
    }
    
    for (int j = 0; j < arr.count; j ++)
    {
        NSLog(@"arr:%@",arr);
      
        NSString * ziMuStr = [self firstCharactor:arr[j]];
        
        for (char i = 'A'; i <= 'Z'; i++)
        {
            NSString *ziM = [NSString stringWithFormat:@"%c",i];
            if ([ziM isEqualToString:ziMuStr])
            {
                NSMutableArray * arrar = [kindDic objectForKey:[NSString stringWithFormat:@"%c",i]];
                
                [arrar addObject:arr[j]];
            }
        }
    }
    NSLog(@"kindDic++kindDic:%@",kindDic);
    
    [_tableView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 26;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    unichar ch = 65 + section;
    NSString *str =[NSString stringWithUTF8String:(char *)&ch];
    NSMutableArray * arr = [kindDic objectForKey:[NSString stringWithFormat:@"%@",str]];
    return arr.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    unichar ch = 65 + section;
    NSString *str =[NSString stringWithUTF8String:(char *)&ch];
    NSMutableArray * arr = [kindDic objectForKey:[NSString stringWithFormat:@"%@",str]];
    if (arr.count == 0)
    {
        return 0.1;
    }
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"iden";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    
    unichar ch = 65 + indexPath.section;
    NSString *str =[NSString stringWithUTF8String:(char *)&ch];
    
    NSMutableArray * arra = [kindDic objectForKey:[NSString stringWithFormat:@"%@",str]];
    cell.textLabel.text = arra[indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    unichar ch = 65 + section;
    NSString *str =[NSString stringWithUTF8String:(char *)&ch];
    NSMutableArray * arr = [kindDic objectForKey:[NSString stringWithFormat:@"%@",str]];
    
    if (arr.count == 0)
    {
        str = @"";
    }
    NSLog(@"str:%@",str);
  
    backL.text = str;
    
    return str;
}

// 根据索引数组返回到对应tableView的某段
- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (index == 0)
    {
        [tableView setContentOffset:CGPointZero animated:NO];
        return NSNotFound;
    }
    backL.hidden = NO;
    backL.alpha = 0.5;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5];
    backL.alpha = 0;
    [UIView commitAnimations];
    
    backL.text = title;
    return index - 1;
}

// 索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{

    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
    // 搜索的小图标
    [arr addObject:UITableViewIndexSearch];
    
    for (char i = 'A'; i <= 'Z'; i ++) {
        
        [arr addObject:[NSString stringWithFormat:@"%c",i]];
    }
    

    return arr;
}

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
- (NSString *)firstCharactor:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    // 获取开始拖拽时tableview偏移量
    backL.hidden = NO;
    backL.alpha = 0.5;
    backL.backgroundColor = [UIColor blackColor];
    [self performSelector:@selector(per) withObject:nil afterDelay:2];
    
}

- (void)per{
    
    backL.hidden = YES;
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
