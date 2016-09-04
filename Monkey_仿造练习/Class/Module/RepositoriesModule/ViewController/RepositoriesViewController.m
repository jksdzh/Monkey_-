//
//  RepositoriesViewController.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/31.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "RepositoriesViewController.h"
#import "YiRefreshFooter.h"
#import "YiRefreshHeader.h"
#import "LanguageViewController.h"
#import "RepositoriesTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "RepositoryDetailViewController.h"




@interface RepositoriesViewController()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * tableView;
    YiRefreshHeader * refreshHeader;
    YiRefreshFooter * refreshFooter;
    NSString * language;
    UILabel * titleText;

}
 @property (nonatomic,strong) DataSourceModel *DataSourceOfPageListObject;
@property (nonatomic,strong) MKNetworkOperation *apiOperation;
@end
@implementation RepositoriesViewController

#pragma mark - lifeCycle


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil ];
    if (self) {
        // Custom initiaalization
        self.DataSourceOfPageListObject = [[DataSourceModel alloc] init];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    NSString * languageAppear = [[NSUserDefaults standardUserDefaults]objectForKey:@"languageAppear1"];
    if ([languageAppear isEqualToString:@"2"]) {
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"languageAppear1"];
        language =[[NSUserDefaults standardUserDefaults]objectForKey:@"language1"];
        if (language == nil || language.length <1) {
            language =@"JavaScript";
        }
        [refreshHeader beginRefreshing];
        if ([language isEqualToString:@"CPP"]) {
            titleText.text =@"C++";
        } else{
            titleText.text =language;
        }

    }


}

-(void)viewDidLoad{
    [super viewDidLoad ];
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight ;
    }
//titleText
    titleText = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth -120)/2, 0, 120, 44)];
    titleText.backgroundColor =[UIColor clearColor];
    titleText.textColor =[UIColor whiteColor];
    titleText.font =[UIFont systemFontOfSize:19.0];
    titleText.textAlignment =NSTextAlignmentCenter;
    self.navigationItem.titleView = titleText;
    language = [[NSUserDefaults standardUserDefaults]objectForKey:@"language1"];
    if (language ==nil || language.length <1) {
        language =@"JavaScript";
    }
    if ([language isEqualToString:@"CPP"]   ) {
        titleText.text = @"C++";
    } else{
        titleText.text =language;
    }
    self.view.backgroundColor =[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets =NO;
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -64-49 ) style:UITableViewStylePlain];
    tableView.delegate =self;
    tableView.dataSource =self;
    tableView.rowHeight =RepositoriesTableViewCellheight;
    tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    [self addTableViewHeader];
    [self addTableViewFooter];
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"language", @"") style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClick)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;


}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning ];
    
}

#pragma mark - Actions or click
-(void)rightBarButtonClick{
    LanguageViewController * languageViewController =[[LanguageViewController alloc]init];
    languageViewController.languageEntranceType = RepositoryLanguageEntranceType;
    [self.navigationController pushViewController:languageViewController animated:YES];


}
#pragma mark - Private
-(void)addTableViewHeader{
    // yiRefreshHeader 头部刷新按钮的使用
    refreshHeader = [[YiRefreshHeader alloc]init];
    refreshHeader.scrollView =tableView;
    [refreshHeader header];
    WEAKSELF
    refreshHeader.beginRefreshingBlock =^(void){
        STRONGSELF
        [strongSelf loadDataFromApiWithIsFirstPage:YES ];

    };
    //是否在进入该界面的时候就开始进入刷新状态
    [refreshHeader beginRefreshing];
}
-(void)addTableViewFooter{
    //YiRefreshFooter 底部刷新按钮的使用
    refreshFooter.scrollView =tableView;
    [refreshFooter footer];
    WEAKSELF
    refreshFooter.beginRefreshingBlock=^(void){
        STRONGSELF
        [strongSelf loadDataFromApiWithIsFirstPage:NO];
    };


}



-(BOOL)loadDataFromApiWithIsFirstPage:(BOOL)isFirstPage{
    NSInteger page = 0;
    if (isFirstPage ) {
        page =1;

    } else{
        page = self.DataSourceOfPageListObject.page +1;
    }
    [ApplicationDelegate.apiEngine searchRepositoriesWithPage:page q:[NSString stringWithFormat:@"language:%@",language]  sort:@"stars" completionHandler:^(NSArray *modelArray, NSInteger page, NSInteger totalCount) {
        if (page <=1) {
            [self.DataSourceOfPageListObject.dataSourceArray removeAllObjects];
        }
        [self.DataSourceOfPageListObject.dataSourceArray addObjectsFromArray:modelArray];
        self.DataSourceOfPageListObject.page
        = page;
        [tableView reloadData];
        if (page >1) {
            [refreshFooter endRefreshing];

        }else{
            [refreshHeader endRefreshing];
        }

    } errorHandler:^(NSError *error) {
        if (isFirstPage) {
            [refreshHeader  endRefreshing];
            
        }else{
            [refreshFooter endRefreshing];
        }

    }];
    return YES;

}

#pragma mark - UITableViewDatasource && Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return  self.DataSourceOfPageListObject.dataSourceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableViewOne cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseableIdentifier=@"reuseCellIdentifier";
    RepositoriesTableViewCell * cell=[tableViewOne dequeueReusableCellWithIdentifier:reuseableIdentifier];
    if(cell==nil){
        cell=[[RepositoriesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    RepositoryModel * repositoryModel = [self.DataSourceOfPageListObject.dataSourceArray objectAtIndex:indexPath.row];
    cell.rankLabel.text = [NSString stringWithFormat:@"%ld",(long)(indexPath.row +1)];
    cell.repositoryLabel.text =[NSString stringWithFormat:@"%@",repositoryModel.name];
    cell.userLabel.text =[NSString stringWithFormat:@"Owner:%@",repositoryModel.owner.login];
    [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:repositoryModel.owner.avatar_url]];
    cell.descriptionLabel.text =[NSString stringWithFormat:@"%@",repositoryModel.Description];
    [cell.homePageButton setTitle:repositoryModel.homepage forState:UIControlStateNormal];
    cell.starLabel.text = [NSString stringWithFormat:@"Star:%ld",(long)repositoryModel.stargazers_count];
    cell.forkLabel.text =[NSString stringWithFormat:@"Fork:%ld",(long)repositoryModel.forks_count];
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RepositoryDetailViewController * repositoryDetailViewController =[[RepositoryDetailViewController alloc]init];
    RepositoryModel * repositoryModel = [self.DataSourceOfPageListObject.dataSourceArray objectAtIndex:indexPath.row];
    repositoryDetailViewController.repositoryModel = repositoryModel;
    [self.navigationController pushViewController:repositoryDetailViewController animated:YES];

}


@end
