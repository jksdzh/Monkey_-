//
//  UserDetailViewModel.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/30.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^UserDetailDataSourceModelResponseBlock)(DataSourceModel * DataSourceOfPageListObject);
@interface UserDetailViewModel : NSObject
@property (nonatomic,strong) UserModel *userModel;
/**
 *  load UserDetailViewController network data
 *
 *  @param isFirstPage           is the first page data or not
 *  @param currentIndex          current index
 *  @param firstCompletionBlock  return this block to get the repository datasource
 *  @param secondCompletionBlock return this block to get the following datasource
 *  @param thirdCompletionBlock  return this block to get the follower datasource
 *
 *  @return success or fail
 */
-(BOOL)loadDataFromApiWithIsFirstPage:(BOOL)isFirstPage currentIndex:(int)currentIndex firstTableData:(UserDetailDataSourceModelResponseBlock)firstCompletionBlock  secondTableData:(UserDetailDataSourceModelResponseBlock)secondCompletionBlock  thirdTableData:(UserDetailDataSourceModelResponseBlock)thirdCompletionBlock;




@end
