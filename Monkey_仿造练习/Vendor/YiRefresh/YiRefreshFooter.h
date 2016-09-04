//
//  YiRefreshFooter.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/27.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^BeginRefreshingBlock)(void);

@interface YiRefreshFooter : NSObject
@property (nonatomic,strong) UIScrollView *scrollView;

/**
 *  正在刷新的回调
 */
@property (nonatomic,copy) BeginRefreshingBlock beginRefreshingBlock;
/**
 *  footer的初始化
 */
-(void)footer;




/**
 *  开始刷新操作,如果正在刷新则不做操作
 */
-(void)beginRefreshing;
/**
 * 关闭刷新操作,请加在uiscrollview数据刷新后,如[tableviewreloaddata]
 */
-(void)endRefreshing;



@end
