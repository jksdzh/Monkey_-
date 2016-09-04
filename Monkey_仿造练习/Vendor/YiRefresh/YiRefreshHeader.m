//
//  YiRefreshHeader.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/27.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "YiRefreshHeader.h"
@interface YiRefreshHeader(){
    float lastPosition;

    float contentHeight;
    float headerHeight;
    BOOL isRefresh;//是否正在刷新,默认是NO

    UILabel *headerLabel;
    UIView * headerView;
    UIImageView *headerImageView;
    UIActivityIndicatorView * activityIndicatorView;
//    UIScrollView * scroll;
}

@end
@implementation YiRefreshHeader
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//
//        isRefresh =NO;
//        lastPosition = 0;
//        headerHeight =35;
//        float scrollWidth =self.scrollView.frame.size.width;
//        float imageWidth =13;
//        float imageHeight = headerHeight;
//        //    float labelWidth =130;
//        float labelHeight =headerHeight;
//        float margin = scrollWidth/7;
//
//
//        headerView = [[UIView alloc]initWithFrame:CGRectMake(0, -headerHeight -10, self.scrollView.frame.size.width, headerHeight)];
//        [self.scrollView addSubview:headerView];
//
//        headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, labelHeight)];
//        headerLabel.text =NSLocalizedString(@"pull down"
//                                            , nil);
//        headerLabel.textColor=[UIColor blackColor];
//        headerLabel.textAlignment=NSTextAlignmentCenter;
//        headerLabel.font =[UIFont systemFontOfSize:14];
//        headerLabel.numberOfLines =1;
//        [headerView addSubview:headerLabel];
//
//        headerImageView=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2-margin, 0, imageWidth, imageHeight)];
//        [headerImageView setImage:[UIImage imageNamed:@"down@2x"]];
//        headerImageView.contentMode =UIViewContentModeScaleToFill;
//        [headerView addSubview:headerImageView];
//
//        activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        activityIndicatorView.frame =CGRectMake(ScreenWidth/2+margin , 0, imageWidth, imageHeight);
//        [headerView  addSubview:activityIndicatorView];
//
//        activityIndicatorView.hidden =YES;
//        //    headerView.hidden =YES;
//        //    headerLabel.hidden =YES;
//        //    headerImageView.hidden =YES;
//
//        //为scrollview设置KVO的观察者对象,keyPath为contentOffset属性
//        [_scrollView addObserver:self forKeyPath:@"contentOffset"
//                         options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
//                         context:nil];
//    }
//    return self;
//}
//+(YiRefreshHeader *)refreshHeader{
//    YiRefreshHeader * refreshHeader =[[YiRefreshHeader alloc]init];
//    return refreshHeader;
//}

-(void)header{
    
    isRefresh =NO;
    lastPosition = 0;
    headerHeight =35;
    float scrollWidth =self.scrollView.frame.size.width;
    float imageWidth =13;
    float imageHeight = headerHeight;
//    float labelWidth =130;
    float labelHeight =headerHeight;
    float margin = scrollWidth/7;


    headerView = [[UIView alloc]initWithFrame:CGRectMake(0, -headerHeight -10, self.scrollView.frame.size.width, headerHeight)];
    [self.scrollView addSubview:headerView];

    headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, labelHeight)];
    headerLabel.text =NSLocalizedString(@"pull down"
                                        , nil);
    headerLabel.textColor=[UIColor blackColor];
  headerLabel.textAlignment=NSTextAlignmentCenter;
   headerLabel.font =[UIFont systemFontOfSize:14];
    headerLabel.numberOfLines =1;
    [headerView addSubview:headerLabel];

    headerImageView=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2-margin, 0, imageWidth, imageHeight)];
    [headerImageView setImage:[UIImage imageNamed:@"down@2x"]];
    headerImageView.contentMode =UIViewContentModeScaleToFill;
    [headerView addSubview:headerImageView];

    activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicatorView.frame =CGRectMake(ScreenWidth/2+margin , 0, imageWidth, imageHeight);
    [headerView  addSubview:activityIndicatorView];

    activityIndicatorView.hidden =YES;
//    headerView.hidden =YES;
//    headerLabel.hidden =YES;
//    headerImageView.hidden =YES;

    //为scrollview设置KVO的观察者对象,keyPath为contentOffset属性
    [_scrollView addObserver:self forKeyPath:@"contentOffset"
                     options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                     context:nil];

}
/**
 *  当属性的值发生变化时,自动调用此方法
 */


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{

    if (![@"contentOffset"
          isEqualToString:keyPath]) return;
    //获取 scrollView的contentsize
    contentHeight =self.scrollView.contentSize.height;

    //判断是否在拖动scrollview
    if (self.scrollView.dragging) {
        int currentPosition = self.scrollView.contentOffset.y;

        //判断是否正在刷新,否则不做任何操作
        if (!isRefresh) {
            [UIView  animateWithDuration:0.3 animations:^{
                //当currentposition小于某个值时,变换状态
                if (currentPosition<-headerHeight *1.5) {
                    headerLabel.text =NSLocalizedString(@"release"
                                                        , nil);
                    headerImageView.transform =CGAffineTransformMakeRotation(M_PI);
                }else{
                    int currentPosition =self.scrollView.contentOffset.y;
                    //判断滑动反向,以让"松开以刷新"变回"下拉可刷新"状态
                    if (currentPosition -lastPosition >5) {
                        lastPosition = currentPosition;
                        headerImageView.transform =CGAffineTransformMakeRotation(M_PI *2);
                        headerLabel.text =NSLocalizedString(@"pull down"
                                                            , nil);
                    }else if (lastPosition - currentPosition >5){
                        lastPosition =currentPosition;
                    }
                }
            }];
        }
    }else{
        //进入刷新状态
        if ([headerLabel.text isEqualToString:NSLocalizedString(@"release"
, nil)]) {
            [self beginRefreshing];
        }
    }


}
/**
 *  开始刷新操作,如果正在刷新则不做操作
 */
-(void)beginRefreshing{
    if (!isRefresh) {
        isRefresh =YES;
        headerLabel.text =NSLocalizedString(@"loading"
                                            , nil);
//        headerImageView.hidden =NO;
//        activityIndicatorView.hidden =NO;
//        headerLabel.hidden =NO;
        [activityIndicatorView startAnimating];

        //设置刷新状态,scrollView的位置
        [UIView animateWithDuration:0.3 animations:^{
            //修改有时候refresh contentOffset还在0,0的情况
            CGPoint point =self.scrollView.contentOffset;
            if (point.y>-headerHeight *1.5) {
                self.scrollView.contentOffset =CGPointMake(0, point.y -headerHeight *1.5);
            }
            //
            self.scrollView.contentInset =UIEdgeInsetsMake(headerHeight *1.5, 0, 0, 0);
        }];
        //block回调
        _beginRefreshingBlock();
    }

}
/**
 *  关闭刷新操作 .请加在uiscrollView数据刷新后,如 [tableview reloadData]
 */
-(void)endRefreshing{
    isRefresh =NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{


        CGPoint point =self.scrollView.contentOffset;
        if (point.y!=0) {
            self.scrollView.contentOffset =CGPointMake(0, point.y + headerHeight *1.5);
        }
        headerLabel.text =NSLocalizedString(@"pull down"
                                            , nil);
        self.scrollView.contentInset =UIEdgeInsetsMake(0, 0, 0, 0);
        headerImageView.hidden =NO;
        headerImageView.transform =CGAffineTransformMakeRotation(M_PI *2);


        [activityIndicatorView stopAnimating];
//        activityIndicatorView.hidden =YES;
//            headerImageView.hidden =YES;
//            headerLabel.hidden =YES;


        }];

    });
}

-(void)dealloc{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset" ];

}









@end
