//
//  YiRefreshFooter.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/27.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "YiRefreshFooter.h"
@interface YiRefreshFooter(){
    float contentHeight;
    float scrollFrameHeight;
    float footerHeight;
    float scrollWidth;
    BOOL isAdd; //是否添加了footer,默认是NO
    BOOL isRefresh;//是否正在刷新,默认是NO

    UIView * footerView;
    UIActivityIndicatorView *activityView;

}

@end
@implementation YiRefreshFooter

-(void)footer{
    scrollWidth =self.scrollView.frame.size.width;
    footerHeight =35;
    scrollFrameHeight =self.scrollView.frame.size.height;
    isAdd =NO;
    isRefresh =NO;

    footerView = [[UIView alloc]init];
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];


    [self.scrollView addObserver:self forKeyPath:@"contentOffset"
                         options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context

{
    if (![@"contentOffset" isEqualToString:keyPath
          ]) return;
    contentHeight =self.scrollView.contentSize.height;
    if (!isAdd) {
        isAdd  =YES;
        footerView.frame =CGRectMake(0, contentHeight, scrollWidth, footerHeight);
        [self.scrollView addSubview:footerView];
        activityView.frame =CGRectMake((scrollWidth - footerHeight)/2 , 0, footerHeight, footerHeight);
        [footerView addSubview:activityView];

    }
    footerView.frame = CGRectMake(0, contentHeight, scrollWidth, footerHeight);
 activityView.frame =CGRectMake((scrollWidth - footerHeight/2) , 0, footerHeight, footerHeight);

        int currentPosition =self.scrollView.contentOffset.y;

        //进入刷新状态
        if ((currentPosition > (contentHeight-scrollFrameHeight))&&(contentHeight >scrollFrameHeight)) {
            [self beginRefreshing];

        }


}

/**
 *  开始刷新操作,如果正在刷新则不做操作
 */
-(void)beginRefreshing{
    if (!isRefresh) {
        isRefresh =YES;
        [activityView startAnimating];
        //设置刷新状态scrollView的位置
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollView.contentInset =UIEdgeInsetsMake(0, 0, footerHeight, 0);
        }];
        //block回调
        self.beginRefreshingBlock();

    }

}
/**
 *  关闭刷新操作 请加在UIscrollview数据刷新后,如[tableView reloadData]
 */
-(void)endRefreshing{
    isRefresh =NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView  animateWithDuration:0.3 animations:^{
            [activityView stopAnimating];
            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            footerView.frame =CGRectMake(0, contentHeight, [UIScreen mainScreen].bounds.size.width, footerHeight);
        }];
    });



}

-(void)dealloc{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"
     ];
}
@end
