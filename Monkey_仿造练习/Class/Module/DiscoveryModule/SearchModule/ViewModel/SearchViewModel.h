//
//  SearchViewModel.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/9/7.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SearchDataSourceModelResponseBlock)(DataSourceModel * DataSourceModel);
@interface SearchViewModel : NSObject



/**
 *  load searchViewCoontroller networkData
 *
 *  @param isFirstPage           is the first page data or not
 *  @param currentIndex          currentIndex
 *  @param text                  searchBarText
  *  @param firstCompletionBlock  return this block to get user dataSource
 *  @param secondCompletionBlock return this block to get repository datasource
 *
 *  @return success or fail
 */

-(BOOL)loadDataFromApiWithIsFirstPage:(BOOL)isFirstPage currentIndex:(int)currentIndex searchBarText:(NSString *)text   firstTableData:(SearchDataSourceModelResponseBlock)firstCompletionBlock secondTableData:(SearchDataSourceModelResponseBlock)secondCompletionBlock;
@end
