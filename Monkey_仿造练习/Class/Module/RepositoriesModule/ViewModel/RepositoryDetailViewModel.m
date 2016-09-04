//
//  RepositoryDetaiViewModel.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/31.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "RepositoryDetailViewModel.h"
#import "DataSourceModel.h"

@interface RepositoryDetailViewModel()
@property (nonatomic,strong) DataSourceModel * contributorsDataSourceOfpageListObject;
@property (nonatomic,strong) DataSourceModel * folksDataSourceOfpageListObject;
@property (nonatomic,strong) DataSourceModel * stargazesDataSourceOfpageListObject;
@end
@implementation RepositoryDetailViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.contributorsDataSourceOfpageListObject =[[DataSourceModel alloc]init];
        self.folksDataSourceOfpageListObject = [[DataSourceModel alloc]init];
        self.stargazesDataSourceOfpageListObject =[[DataSourceModel alloc]init];
    }
    return self;
}
-(BOOL)loadDataFromApiWithIsFirstPage:(BOOL)isFirstPage currentIndex:(int)currentIndex firstTableData:(RepositoryDetailDataSourceModelResponseBlock)firstCompletionBlock secondTableData:(RepositoryDetailDataSourceModelResponseBlock)secondCompletionBlock thirdTableData:(RepositoryDetailDataSourceModelResponseBlock)thirdCompletionBlock{
    if (currentIndex ==1) {
        NSInteger page = 0;
        if (isFirstPage) {
            page =1;
        } else{
            page =self.contributorsDataSourceOfpageListObject.page +1;
        }

        [ApplicationDelegate.apiEngine repositoriesDetailCategoryWithPage:page userName:self.repositoryModel.owner.login repositoryName:self.repositoryModel.name category:@"contributors" completionHandler:^(NSArray *modelArray, NSInteger page, NSInteger totalCount) {
            if (page <=1) {
                [self.contributorsDataSourceOfpageListObject.dataSourceArray removeAllObjects];
            }
            [self.contributorsDataSourceOfpageListObject.dataSourceArray addObjectsFromArray: modelArray];
            self.contributorsDataSourceOfpageListObject.page = page;
            self.contributorsDataSourceOfpageListObject.totalCount =totalCount;
            firstCompletionBlock(self.contributorsDataSourceOfpageListObject);
        } errorHandler:^(NSError *error) {
            firstCompletionBlock(self.contributorsDataSourceOfpageListObject);
        }];
        return YES;
    } else if (currentIndex ==2){
        NSInteger page = 0;
        if (isFirstPage) {
            page =1;
        }else{
            page =self.folksDataSourceOfpageListObject.page +1;
        }
        [ApplicationDelegate.apiEngine repositoriesDetailCategoryWithPage:page userName:self.repositoryModel.owner.login repositoryName:self.repositoryModel.name category:@"forks" completionHandler:^(NSArray *modelArray, NSInteger page, NSInteger totalCount) {
            if (page <=1) {
                [self.folksDataSourceOfpageListObject.dataSourceArray removeAllObjects];
                [self.folksDataSourceOfpageListObject.dataSourceArray addObjectsFromArray:modelArray];
                self.folksDataSourceOfpageListObject.page = page;
                self.folksDataSourceOfpageListObject.totalCount =totalCount;
            }
            secondCompletionBlock(self.folksDataSourceOfpageListObject);
        } errorHandler:^(NSError *error) {
            secondCompletionBlock(self.folksDataSourceOfpageListObject);
        }];
        return YES;

    } else if (currentIndex ==3){
        NSInteger page = 0;
        if (isFirstPage) {
            page =1;
        }else{
            page =self.stargazesDataSourceOfpageListObject.page+1;
        }
        [ApplicationDelegate.apiEngine repositoriesDetailCategoryWithPage:page userName:self.repositoryModel.owner.login repositoryName:self.repositoryModel.name category:@"stargazers" completionHandler:^(NSArray *modelArray, NSInteger page, NSInteger totalCount) {
            if (page <=1) {
                [self.stargazesDataSourceOfpageListObject.dataSourceArray removeAllObjects];
            }
            [self.stargazesDataSourceOfpageListObject.dataSourceArray addObjectsFromArray:modelArray];
            self.stargazesDataSourceOfpageListObject.page =page;
            self.stargazesDataSourceOfpageListObject.totalCount =totalCount;
            thirdCompletionBlock(self.stargazesDataSourceOfpageListObject);
        } errorHandler:^(NSError *error) {
            thirdCompletionBlock(self.stargazesDataSourceOfpageListObject);
        }];
        return YES;
    }
    return YES;
}

@end
