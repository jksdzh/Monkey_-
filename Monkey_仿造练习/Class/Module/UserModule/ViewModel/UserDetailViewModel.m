//
//  UserDetailViewModel.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/30.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "UserDetailViewModel.h"
@interface UserDetailViewModel()
@property (nonatomic,strong) DataSourceModel *repositoryDatasourceOfPageListObject;
@property (nonatomic,strong) DataSourceModel *followingDatasourceOfPageListObject;
@property (nonatomic,strong) DataSourceModel *followerDatasourceOfPageListObject;
@end


@implementation UserDetailViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.repositoryDatasourceOfPageListObject =[[DataSourceModel   alloc]init];
                self.followingDatasourceOfPageListObject =[[DataSourceModel   alloc]init];
                self.followerDatasourceOfPageListObject =[[DataSourceModel   alloc]init];
    }
    return self;
}

-(BOOL)loadDataFromApiWithIsFirstPage:(BOOL)isFirstPage currentIndex:(int)currentIndex firstTableData:(UserDetailDataSourceModelResponseBlock)firstCompletionBlock secondTableData:(UserDetailDataSourceModelResponseBlock)secondCompletionBlock thirdTableData:(UserDetailDataSourceModelResponseBlock)thirdCompletionBlock
{
    if (currentIndex ==1) {
        NSInteger page = 0;
        if (isFirstPage) {
            page = 1;
        }else{
            page =self.repositoryDatasourceOfPageListObject.page +1;
        }
    [ApplicationDelegate.apiEngine userRepositoriesWithPage:page userName:self.userModel.login completionHandler:^(NSArray *modelArray, NSInteger page, NSInteger totalCount) {
        if (page <=1) {
            [self.repositoryDatasourceOfPageListObject.dataSourceArray removeAllObjects];
        }
        [self.repositoryDatasourceOfPageListObject.dataSourceArray addObjectsFromArray:modelArray];
        self.repositoryDatasourceOfPageListObject.page = page;
        firstCompletionBlock(self.repositoryDatasourceOfPageListObject);
    } errorHandler:^(NSError *error) {
        firstCompletionBlock(self.repositoryDatasourceOfPageListObject);
    }];
        return YES;


    }else if (currentIndex ==2){
        NSInteger page = 0;
        if (isFirstPage) {
            page = 1;
        } else{
            page =self.followingDatasourceOfPageListObject.page +1;
        }
        [ApplicationDelegate.apiEngine userFollowingWithPage:page userName:self.userModel.login completionHandler:^(NSArray *modelArray, NSInteger page, NSInteger totalCount) {
            if (page <=1) {
                [self.followingDatasourceOfPageListObject.dataSourceArray removeAllObjects];
            }
            [self.followingDatasourceOfPageListObject.dataSourceArray addObjectsFromArray:modelArray];
            self.followingDatasourceOfPageListObject.page = page;
            secondCompletionBlock(self.followingDatasourceOfPageListObject);

        } errorHandler:^(NSError *error) {
            secondCompletionBlock(self.followingDatasourceOfPageListObject);
        }];
        return YES;

    }else if (currentIndex ==3){
        NSInteger page =0;
        if (isFirstPage) {
            page =1;
        } else{
            page =self.followerDatasourceOfPageListObject.page +1;
        }
        [ApplicationDelegate.apiEngine userFollowersWithPage:page userName:self.userModel.login completionHandler:^(NSArray *modelArray, NSInteger page, NSInteger totalCount) {
            if (page <=1) {
                [self.followerDatasourceOfPageListObject.dataSourceArray removeAllObjects];
            }
            [self.followerDatasourceOfPageListObject.dataSourceArray addObjectsFromArray:modelArray];
            self.followerDatasourceOfPageListObject.page =page;
            thirdCompletionBlock(self.followerDatasourceOfPageListObject);
        } errorHandler:^(NSError *error) {
            thirdCompletionBlock(self.followerDatasourceOfPageListObject);
        }];
        return YES;


    }
    return YES;

}




@end
