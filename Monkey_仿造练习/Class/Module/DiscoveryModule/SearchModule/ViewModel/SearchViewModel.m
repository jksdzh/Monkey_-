//
//  SearchViewModel.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/9/7.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "SearchViewModel.h"
@interface SearchViewModel()
@property (nonatomic,strong) DataSourceModel *userDataSourceModel;
@property (nonatomic,strong) DataSourceModel *repositoryDataSourceModel;
@end
@implementation SearchViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userDataSourceModel =[[DataSourceModel     alloc]init];
        self.repositoryDataSourceModel =[[DataSourceModel alloc]init];
    }
    return self;
}

- (BOOL)loadDataFromApiWithIsFirstPage:(BOOL)isFirstPage currentIndex:(int)currentIndex searchBarText:(NSString *)text firstTableData:(SearchDataSourceModelResponseBlock)firstCompletionBlock secondTableData:(SearchDataSourceModelResponseBlock)secondCompletionBlock{
    if (text != nil) {
        switch (currentIndex) {
            case 1:{
                if (currentIndex ==1) {
                    NSInteger page =0;
                    if (isFirstPage) {
                        page = 1;

                    } else{
                        page =self.userDataSourceModel.page +1;
                    }
                    [ApplicationDelegate.apiEngine searchUsersWithPage:page q:text sort:@"followers" completionHandler:^(NSArray *modelArray, NSInteger page, NSInteger totalCount) {
                        self.userDataSourceModel.totalCount =totalCount;
                        if (page <=1) {
                            [self.userDataSourceModel.dataSourceArray removeAllObjects];

                        }
                        self.userDataSourceModel.page =page;
                        self.userDataSourceModel.totalCount =totalCount;
                        [self.userDataSourceModel.dataSourceArray addObjectsFromArray:modelArray];
                        firstCompletionBlock(self.userDataSourceModel);
                    } errorHandler:^(NSError *error) {
                           firstCompletionBlock(self.userDataSourceModel);
                    }];
                    return YES;
                }


            }
                break;
            case 2:{
                NSInteger page = 0;
                if (isFirstPage) {
                    page =1;

                }else{
                   page = self.repositoryDataSourceModel.page +1;
                }
                [ApplicationDelegate.apiEngine searchRepositoriesWithPage:page q:text sort:@"stars" completionHandler:^(NSArray *modelArray, NSInteger page, NSInteger totalCount) {
                    if (page <=1) {
                        [self.repositoryDataSourceModel.dataSourceArray removeAllObjects];
                    }
                    [self.repositoryDataSourceModel.dataSourceArray addObjectsFromArray:modelArray];
                    self.repositoryDataSourceModel.page = page;
                    secondCompletionBlock(self.repositoryDataSourceModel);

                } errorHandler:^(NSError *error) {
                    secondCompletionBlock(self.repositoryDataSourceModel);
                }];



            }

                break;
            default:
                break;
        }
    }
    return  YES;
}


@end
