//
//  TrendingViewModel.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/9/2.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^DataSourceModelResponseBlock)(DataSourceModel *dataSourceModel);

@interface TrendingViewModel : NSObject
/**
 *  load TrendingViewController network data
 *
 *  @param isFirstPage                    isFirstPage description
 *  @param currentIndex                   currenTableViewIndex
 *  @param firstTableDataCompletionBlock  firstTableDataCompletionBlock  return this block to get the daily datasource
 *  @param secondTableDataCompletionBlock return this block to get the weekly trending datasource
 *  @param thirdTableDataCompletionBlock  return this block to get the monthly trending datasource
 *
 *  @return success or fail
 */
-(BOOL)loadDataFromApiWithIsFirstPage:(BOOL)isFirstPage currentTableViewIndex:(int)currentIndex firstTableData:(DataSourceModelResponseBlock)firstTableDataCompletionBlock secondTableDatA:(DataSourceModelResponseBlock)secondTableDataCompletionBlock thirdTableData:(DataSourceModelResponseBlock)thirdTableDataCompletionBlock ;
@end
