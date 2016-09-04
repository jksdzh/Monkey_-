//
//  CountryViewController.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/26.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "CountryViewController.h"
#import "CityViewController.h"
@interface CountryViewController()<UITableViewDataSource,UITableViewDelegate>{
    UITableView * tableViewOne;
    NSArray *countrys;

}

@end
@implementation CountryViewController
#pragma mark - lifeCycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated ];
    self.tabBarController.tabBar.hidden =YES;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated ];
    self.tabBarController.tabBar.hidden =NO;
}



-(void)viewDidLoad{
    [super viewDidLoad ];
    self.title =NSLocalizedString(@"Select Country"
                                  , nil);
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom|UIRectEdgeLeft|UIRectEdgeRight;
    }
    self.automaticallyAdjustsScrollViewInsets =NO;

    self.view.backgroundColor = [UIColor whiteColor];
    tableViewOne = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -64) style:UITableViewStylePlain];
    [self.view addSubview:tableViewOne];


    tableViewOne.dataSource =self;
    tableViewOne.delegate =self;

    countrys = @[@"USA",@"UK",@"Germany",@"China",@"Canada",@"India",@"France",@"Australia",@"Other"];


}


#pragma mark - UITableViewDatasource && Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return countrys.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
     NSString *reuseableIdentifier=@"cellReuseIdentifier";
     cell=[tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];
    }
    cell.textLabel.text = (countrys)[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row!=countrys.count -1) {
        [[NSUserDefaults standardUserDefaults]setObject:countrys[indexPath.row] forKey:@"country"];

    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"China"forKey:@"country"
           ];
    }
    NSArray * cityArray;
    switch (indexPath.row) {
        case 0:
                //American
                cityArray= @[@"San Francisco",@"New York",@"Seattle",@"Chicago",@"Los Angeles",@"Boston",@"Washington",@"San Diego",@"San Jose",@"Philadelphia"];
            break;
        case 1:
            //        uk
            cityArray= @[@"London",@"Cambridge",@"Manchester",@"Edinburgh",@"Bristol",@"Birmingham",@"Glasgow",@"Oxford",@"Newcastle",@"Leeds"];
            break;
        case 2:
            //germany
            cityArray= @[@"Berlin",@"Munich",@"Hamburg",@"Cologne",@"Stuttgart",@"Dresden",@"Leipzig"];
            break;

        case 3:
        cityArray= @[@"beijing",@"shanghai",@"shenzhen",@"hangzhou",@"guangzhou",@"chengdu",@"nanjing",@"wuhan",@"suzhou",@"xiamen",@"tianjin",@"chongqing",@"changsha"];
            break;
        case 4:
            //        canada
            cityArray= @[@"Toronto",@"Vancouver",@"Montreal",@"ottawa",@"Calgary",@"Quebec"];
            break;
        case 5:
            //        india
            cityArray= @[@"Chennai",@"Pune",@"Hyderabad",@"Mumbai",@"New Delhi",@"Noida",@"Ahmedabad",@"Gurgaon",@"Kolkata"];
            break;
        case 6:
            //        france
            cityArray= @[@"paris",@"Lyon",@"Toulouse",@"Nantes"];
            break;
        case 7:
            //        澳大利亚
            cityArray= @[@"sydney",@"Melbourne",@"Brisbane",@"Perth"];
            break;
        case 8:
            //        other
            cityArray= @[@"Tokyo",@"Moscow",@"Singapore",@"Seoul"];
            break;
        default:
            break;
    }

    CityViewController * cityViewController =
    [[CityViewController alloc]init];
    cityViewController.pinyinCitys =cityArray;
    [self.navigationController pushViewController:cityViewController animated:YES];

}










@end
