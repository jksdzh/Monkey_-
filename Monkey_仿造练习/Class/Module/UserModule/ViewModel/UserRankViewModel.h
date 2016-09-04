//
//  UserRankViewModel.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/27.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^UserRankDataSourceModelResponseBlock)(DataSourceModel *DataSourceOfPageListObject);
@interface UserRankViewModel : NSObject
/**
 *  load UserRankViewController network data
 *
 *  @param isFirstPage               is the first page data or not
 *  @param currentIndex          current index
 *  @param firstCompletionBlock  return this block to get the city datasource
 *  @param secondCompletionBlock return this block to get the country datasource
 *  @param thirdCompletionBlock  return this block to get the world datasource
 *
 *  @return success or fail
 */
-(BOOL)loadDataFromApiWithIsFirstPage:(BOOL)isFirstPage currentIndex:(int)currentIndex firstTableData:(UserRankDataSourceModelResponseBlock)firstCompletionBlock secondTableData:(UserRankDataSourceModelResponseBlock)secondCompletionBlock thirdTableData:(UserRankDataSourceModelResponseBlock)thirdCompletionBlock;


@end
