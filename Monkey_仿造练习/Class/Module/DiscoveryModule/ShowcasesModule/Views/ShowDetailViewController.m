//
//  ShowDetailViewController.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/9/5.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "ShowDetailViewController.h"
#import "YiRefreshHeader.h"
#import "YiRefreshFooter.h"
#import "YiNetworkEngine.h"
#import "RepositoriesTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "RepositoryDetailViewController.h"


@interface ShowDetailViewController()<UITableViewDataSource,UITableViewDelegate>{
    UITableView * tableViewOne;
    YiRefreshHeader * refreshHeader;
    YiRefreshFooter * refreshFooter;
    NSString * language;

}
@property (nonatomic,strong) DataSourceModel *dataSourceModel;
//@property (nonatomic,strong)MKNetworkOperation * apiOperation;

@end

@implementation ShowDetailViewController

#pragma mark - lifeCycle
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self =  [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil ];
    if (self) {
        self.dataSourceModel =[[DataSourceModel alloc]init];

    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated ];
//    self.navigationController.navigationBar.hidden =YES;

}
-(void)viewWillDisappear:(BOOL)animated{
//    self.navigationController.navigationBar.hidden =NO;
    //    [activityIndicator removeFromSuperview];

}
-(void)viewDidLoad{
    [super viewDidLoad ];
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight ;
    }
    self.title =self.showCaseModel.name;
    self.view.backgroundColor =[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets =NO;
    tableViewOne = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -64) style:UITableViewStylePlain];
    tableViewOne.delegate =self;
    tableViewOne.dataSource =self;
    tableViewOne.rowHeight =RepositoriesTableViewCellheight;
    tableViewOne.separatorStyle =UITableViewCellSeparatorStyleNone;
    tableViewOne.backgroundColor =[UIColor yellowColor];
    [self.view addSubview:tableViewOne];
    [self addTableViewHeader];
    [self addTableViewFooter];

}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning ];
    
}


#pragma mark - Private
-(void)addTableViewHeader{
    refreshHeader =[[YiRefreshHeader alloc]init];
    refreshHeader.scrollView =tableViewOne;
    [refreshHeader header];
    WEAKSELF
    refreshHeader.beginRefreshingBlock=^(){
        STRONGSELF
        [strongSelf loadDataFromApiWithFirstPage:YES];
    };
    [refreshHeader beginRefreshing];


    
}
-(void)addTableViewFooter{
    refreshFooter =[[YiRefreshFooter alloc]init];
    refreshFooter.scrollView =tableViewOne;
    [refreshFooter footer];
    WEAKSELF
    refreshFooter.beginRefreshingBlock =^(){
        STRONGSELF
        [strongSelf loadDataFromApiWithFirstPage:NO];
    };
}



-(BOOL)loadDataFromApiWithFirstPage:(BOOL)isFirstPage{
    YiNetworkEngine * networkEngine =[[YiNetworkEngine alloc]initWithHostName:@"trending.codehub-app.com" customHeaderFields:nil];
     NSInteger page = 0;
    if (isFirstPage) {
        page = 1;
    }else{
        page =self.dataSourceModel.page+1;
    }

    [networkEngine showcasesDetailListWithShowcase:self.showCaseModel.slug completionHandler:^(NSArray *modelArray, NSInteger page, NSInteger totalCount) {
        if (page<=1) {
            [self.dataSourceModel.dataSourceArray removeAllObjects];
        }
        [self.dataSourceModel.dataSourceArray addObjectsFromArray:modelArray];
        self.dataSourceModel.page = page;
        [tableViewOne reloadData];
        
        if (isFirstPage) {
            [refreshHeader endRefreshing];
        }else{
            [refreshFooter endRefreshing];
        }

    } errorHandler:^(NSError *error) {
        if (isFirstPage) {
            [refreshHeader endRefreshing];
        }else{
            [refreshFooter endRefreshing];
        }

    }];
    return YES;


}
#pragma mark - UITableViewDatasource && Delegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataSourceModel.dataSourceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseableIdentifier=@"reuseableIdentifier";
    RepositoriesTableViewCell * cell=[tableViewOne dequeueReusableCellWithIdentifier:reuseableIdentifier];
    if(cell==nil){
        cell=[[RepositoriesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    RepositoryModel * repositoryModel =[self.dataSourceModel.dataSourceArray objectAtIndex:indexPath.row];
    cell.rankLabel.text =[NSString stringWithFormat:@"%ld",(long)(indexPath.row +1)];
    cell.repositoryLabel.text =[NSString stringWithFormat:@"%@",repositoryModel.name];
    cell.userLabel.text =[NSString stringWithFormat:@"Owner:%@",repositoryModel.userModel.login];
    [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:repositoryModel.userModel.avatar_url]];
    cell.descriptionLabel.text =[NSString stringWithFormat:@"%@",repositoryModel.Description];
    [cell.homePageButton setTitle:repositoryModel.homepage forState:UIControlStateNormal];
    cell.starLabel.text =[NSString stringWithFormat:@"Star:%lu",(long)repositoryModel.stargazers_count];
    cell.forkLabel.text =[NSString stringWithFormat:@"Fork:%lu",repositoryModel.forks_count];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RepositoryDetailViewController * repositoryDetailViewController =[[RepositoryDetailViewController alloc]init];
    RepositoryModel * repositoryModel = [self.dataSourceModel.dataSourceArray objectAtIndex:indexPath.row];
    repositoryDetailViewController.repositoryModel = repositoryModel;
    [self.navigationController pushViewController:repositoryDetailViewController animated:YES];
}








@end
