//
//  XDMultTableView.h
//  XDMultTableView
//
//  Created by JJT on 17/3/17.
//  Copyright © 2017年 SJZ. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol XDMultTableViewDelegate,XDMultTableViewDatasource;

typedef UITableViewCell XDMultTableViewCell;

typedef UITableViewRowAnimation XDMultTableViewRowAnimation;

typedef NS_ENUM(NSInteger, XDMultTableViewCellEditingStyle) {
    XDMultTableViewCellEditingStyleNone,
    XDMultTableViewCellEditingStyleDelete,
    XDMultTableViewCellEditingStyleInsert
};

@interface XDMultTableView : UIView<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong, readonly) UITableView *tableView;

@property (nonatomic, assign, readwrite) id<XDMultTableViewDatasource> datasource;

@property (nonatomic, assign, readwrite) id<XDMultTableViewDelegate> delegate;

@property (nonatomic, copy, readwrite) NSArray *openSectionArray;

@property (nonatomic, strong, readwrite) UIView *tableViewHeader;

/**
 *  Cell重用机制（一）
 *
 *  @param identifier Cell标识
 *
 *  @return Cell
 */
- (XDMultTableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;

/**
 *  Cell重用机制（二）
 */
- (XDMultTableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
                                               forIndexPath:(NSIndexPath *)indexPath;
/**
 *  刷新数据源
 */
- (void)reloadData;

/**
 *  注册cell（一）
 *
 */
- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier ;

/**
 *  注册cell（二）
 *

 */
- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier;

/**
 *  删除cell
 *

 */
- (void)deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;

@end

/**
 *  数据源
 */
@protocol XDMultTableViewDatasource <NSObject>

@required

/**
 *  每个section的行数
 */
- (NSInteger)mTableView:(XDMultTableView *)mTableView numberOfRowsInSection:(NSInteger)section;

/**
 *  Cell显示
 *  @return Cell
 */
- (XDMultTableViewCell *)mTableView:(XDMultTableView *)mTableView
               cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

/**
 *  section的数量
 */
- (NSInteger)numberOfSectionsInTableView:(XDMultTableView *)mTableView;              // Default is 1

/**
 *  头部的title
 */
-(NSString *)mTableView:(XDMultTableView *)mTableView titleForHeaderInSection:(NSInteger)section;


/**
 *  cell是否可以编辑
 */
- (BOOL)mTableView:(XDMultTableView *)mTableView canEditRowAtIndexPath:(NSIndexPath  *)indexPath;

/**
 *  cell编辑后回调
 *
 */
- (void)mTableView:(XDMultTableView *)tableView commitEditingStyle:(XDMultTableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

@end

/**
 *  代理
 */
@protocol XDMultTableViewDelegate <NSObject>

@optional
/**
 *  每个Cell的高度
 *
 *  @return 每个Cell的高度
 */
- (CGFloat)mTableView:(XDMultTableView *)mTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  每个section的高度
 *
 *  @return 每个section的高度
 */
- (CGFloat)mTableView:(XDMultTableView *)mTableView heightForHeaderInSection:(NSInteger)section;

/**
 *  section View
 */
- (UIView *)mTableView:(XDMultTableView *)mTableView viewForHeaderInSection:(NSInteger)section;

/**
 *  即将打开指定列表回调
 */
- (void)mTableView:(XDMultTableView *)mTableView willOpenHeaderAtSection:(NSInteger)section;

/**
 *
 *  即将关闭列表回调
 */
- (void)mTableView:(XDMultTableView *)mTableView willCloseHeaderAtSection:(NSInteger)section;

/**
 *  点击Cell回调
 *
 */
- (void)mTableView:(XDMultTableView *)mTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

//Edit

/**
 *
 *  设置cell的编辑类型
 */
- (XDMultTableViewCellEditingStyle)mTableView:(XDMultTableView *)mTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  设置cell编辑状态之删除的文本
 *
 */
- (NSString *)mTableView:(XDMultTableView *)mTableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  ...易拓展出你想要的tableview的功能，写法可以参照上面的定义
 */

@end

