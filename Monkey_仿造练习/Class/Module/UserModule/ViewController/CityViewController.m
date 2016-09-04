//
//  CityViewController.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/26.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CityViewController.h"

@interface CityViewController()<UITableViewDelegate,UITableViewDataSource>{
    UITableView * tableViewOne;
    NSArray *citys;
}

@end


@implementation CityViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =YES;

}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden =NO;
}

-(void)viewDidLoad{
    [super viewDidLoad ];
    self.title =NSLocalizedString(@"Select City"
                                  , nil);
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;

    }
    self.automaticallyAdjustsScrollViewInsets =NO;

    self.view.backgroundColor = [UIColor whiteColor];
    tableViewOne =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -64) style:UITableViewStylePlain];

    [self.view addSubview:tableViewOne];

    tableViewOne.dataSource =self;
    tableViewOne.delegate =self;

    if (self.pinyinCitys.count>0) {
        if (![self.pinyinCitys[0] isEqualToString:@"beijing"]) {
            citys =self.pinyinCitys;
        }else{
            citys =@[NSLocalizedString(@"beijing", @""),NSLocalizedString(@"shanghai", @""),NSLocalizedString(@"shenzhen", @""),NSLocalizedString(@"hangzhou", @""),NSLocalizedString(@"guangzhou", @""),NSLocalizedString(@"chengdu", @""),NSLocalizedString(@"nanjing", @""),NSLocalizedString(@"wuhan", @""),NSLocalizedString(@"suzhou", @""),NSLocalizedString(@"xiamen", @""),NSLocalizedString(@"tianjin", @""),NSLocalizedString(@"chongqing", @""),NSLocalizedString(@"changsha", @""),];
        }
    }

}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDatasource && Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return citys.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
     NSString *reuseableIdentifier=@"cellReuseIdentifier";
      cell=[tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];
    }
    cell.textLabel.text =(citys)[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[NSUserDefaults standardUserDefaults] setObject:@"2"forKey:@"cityAppear"];
    [[NSUserDefaults standardUserDefaults]setObject:@"2"forKey:@"countryAppear"];
    [[NSUserDefaults standardUserDefaults]setObject:_pinyinCitys[indexPath.row] forKey:@"pinyinCity"];
    [[NSUserDefaults standardUserDefaults]setObject:citys[indexPath.row] forKey:@"city"];
    [self.navigationController popToRootViewControllerAnimated:YES];

}






@end
