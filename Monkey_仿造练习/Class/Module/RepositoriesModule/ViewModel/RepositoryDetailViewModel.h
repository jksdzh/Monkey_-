//
//  RepositoryDetaiViewModel.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/31.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^RepositoryDetailDataSourceModelResponseBlock)(DataSourceModel *DataSourceOfPageListObject);

@interface RepositoryDetailViewModel : NSObject
@property (nonatomic,strong) RepositoryModel *repositoryModel;
/**
 *  load RepositoryDetailViewController network data
 *
 *  @param isFirstPage           is the first page data or not
 *  @param currentIndex          current index
 *  @param firstCompletionBlock  return this block
 to get the contributors datasource
 *  @param secondCompletionBlock return this block to get the folks datasource
 *  @param thirdCompletionBlock  return this block to get the stargazes datasource
 */
-(BOOL)loadDataFromApiWithIsFirstPage:(BOOL)isFirstPage currentIndex:(int)currentIndex firstTableData:(RepositoryDetailDataSourceModelResponseBlock)firstCompletionBlock secondTableData:(RepositoryDetailDataSourceModelResponseBlock)secondCompletionBlock thirdTableData:(RepositoryDetailDataSourceModelResponseBlock)thirdCompletionBlock;

@end
