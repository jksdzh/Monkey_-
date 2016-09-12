//
//  ShowCasesViewController.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/9/2.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "ShowCasesViewController.h"
#import "YiRefreshHeader.h"
#import "YiRefreshFooter.h"
#import "ShowCasesTableViewCell.h"
#import "YiNetworkEngine.h"
#import "ShowcasesModel.h"
#import "UIImageView+WebCache.h"
#import "UITableView+FDTemplateLayoutCell.h"

#import <SDAutoLayout.h>
#import "ShowDetailViewController.h"

 
@interface ShowCasesViewController()<UITableViewDelegate,UITableViewDataSource>{
    UITableView * tableViewOne;
    YiRefreshHeader * refreshHeader ;
    YiRefreshFooter * refreshFooter;
//    ShowCasesTableViewCell  * cell;


}

@property (nonatomic,strong) id<ReformerProtocol>  ShowCasesReformer;

@property (nonatomic,strong) DataSourceModel *dataSourceModel;
@property (nonatomic,strong) MKNetworkOperation *apiOperation;
@end
@implementation ShowCasesViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self =[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil ];
    if (self) {
        self.dataSourceModel = [[DataSourceModel alloc]init];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated ];
    self.tabBarController.tabBar.hidden =YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated ];
    self.tabBarController.tabBar.hidden =NO;
}


-(void)viewDidLoad{
    [super viewDidLoad ];
    self.view.backgroundColor =[UIColor whiteColor];
    [self setUp];

    [self addTableViewHeader];
    [self addTableViewFooter];
}

-(void)didReceiveMemoryWarning{

}
-(void)setUp{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(67, 0, ScreenWidth - 67 *2, 30)];
    titleLabel.text =@"ShowCases";
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.font =[UIFont systemFontOfSize:19.0];

    self.navigationItem.titleView =titleLabel;

    tableViewOne =[[UITableView alloc]initWithFrame:CGRectMake(0,64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    tableViewOne.estimatedRowHeight =100;
    tableViewOne.rowHeight = 100;

    tableViewOne.delegate =self;
    tableViewOne.dataSource =self;
    tableViewOne.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableViewOne];
    
}
#pragma mark - UITableViewDatasource && Delegate
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    ShowcasesModel * showCasesModel =[[ShowcasesModel alloc]init];
//    showCasesModel =(ShowcasesModel * )self.dataSourceModel.dataSourceArray[indexPath.row];
//    return [tableViewOne fd_heightForCellWithIdentifier:@"reuseCellIdentifier" cacheByIndexPath:indexPath configuration:^(ShowCasesTableViewCell * cell) {
//        cell.model =showCasesModel;
//    }];
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return self.dataSourceModel.dataSourceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ShowCasesTableViewCell *cell =[[ShowCasesTableViewCell alloc]init];
    NSString * reuseIdentifier =@"reuseCellIdentifier";
    [tableViewOne registerClass:[ShowCasesTableViewCell class] forCellReuseIdentifier:reuseIdentifier];

    if(cell==nil){
        cell =[tableViewOne dequeueReusableCellWithIdentifier:reuseIdentifier];

        cell.selectionStyle =UITableViewCellSelectionStyleNone;


    }
    ShowcasesModel * showCasesModel =[[ShowcasesModel alloc]init];
    showCasesModel =(ShowcasesModel * )self.dataSourceModel.dataSourceArray[indexPath.row];
    cell.model =showCasesModel;
    return cell;
}
 

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShowDetailViewController *showDetailViewController =[[ShowDetailViewController alloc]init];

    ShowcasesModel *showCaseModel =[self.dataSourceModel.dataSourceArray objectAtIndex:indexPath.row];

    showDetailViewController.showCaseModel =showCaseModel;
    [self.navigationController pushViewController:showDetailViewController animated:YES];
}


-(void)loadTableViewDataFromApiWithisFirstPage:(BOOL)isFirstPage{
    YiNetworkEngine * netWorkEngine =[[YiNetworkEngine  alloc]initWithHostName:@"trending.codehub-app.com" customHeaderFields:nil];
    NSInteger page =0;
    if (isFirstPage) {
        page =1;
    } else {
        page =self.dataSourceModel.page +1;
    }
    [netWorkEngine showcasesWithCompletionHandler:^(NSArray *modelArray, NSInteger page, NSInteger totalCount) {
        if (page <=1) {
            [self.dataSourceModel.dataSourceArray removeAllObjects];
        }
        [self.dataSourceModel.dataSourceArray addObjectsFromArray:modelArray];
        self.dataSourceModel.page =page;
        self.dataSourceModel.totalCount = totalCount;
        [tableViewOne reloadData];
        if (!isFirstPage) {
            [refreshFooter endRefreshing];
        } else {
            [refreshHeader endRefreshing];
        }
      } errorHandler:^(NSError *error) {
          if (isFirstPage) {
              [refreshHeader endRefreshing];
          } else {
              [refreshFooter endRefreshing];
          }
     }];

}
-(void)addTableViewHeader{
    refreshHeader =[[YiRefreshHeader alloc]init];
    refreshHeader.scrollView =tableViewOne;
    [refreshHeader header];
    WEAKSELF
    refreshHeader.beginRefreshingBlock=^(){
        STRONGSELF
        [strongSelf loadTableViewDataFromApiWithisFirstPage:YES];
    };
    // 是否在进入该界面的时候就开始进入刷新状态
    [refreshHeader beginRefreshing];

}

-(void)addTableViewFooter{
    //底部刷新按钮的使用
    refreshFooter =[[YiRefreshFooter alloc]init];
    refreshFooter.scrollView =tableViewOne;
    [refreshFooter  footer];
    WEAKSELF
    refreshFooter.beginRefreshingBlock=^(){
        STRONGSELF
        [strongSelf loadTableViewDataFromApiWithisFirstPage:NO];

    };
}









@end
