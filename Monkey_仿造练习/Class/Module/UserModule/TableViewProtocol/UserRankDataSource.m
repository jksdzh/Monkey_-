//
//  UserRankDataSource.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/27.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "UserRankDataSource.h"
#import "RankTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation UserRankDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag ==11) {

        return self.DataSourceOfPageListObjectOne.dataSourceArray.count;


    }else if (tableView.tag ==12){

        return self.DatasourceOfPageListObjectTwo.dataSourceArray.count;
    }else if (tableView.tag ==13){
        return self.DatasourceOfPageListObjectThree.dataSourceArray.count;
    }
    return self.DataSourceOfPageListObjectOne.dataSourceArray.count;
}




-(UITableViewCell *)tableView:(UITableView *)tableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        RankTableViewCell * cell;
    if (tableView.tag ==11) {
      NSString *reuseableIdentifier=@"cellIdentifier1";
          cell=[tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
        if (!cell) {
            cell=[[RankTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];
        }

        UserModel *model =[(self.DataSourceOfPageListObjectOne.dataSourceArray) objectAtIndex:indexPath.row];
        cell.rankLabel.text = [NSString stringWithFormat:@"%ld",(long)(indexPath.row +1)
                               ];

        cell.mainLabel.text =[NSString stringWithFormat:@"%@",model.login
                              ];

        cell.detailLabel.text =[NSString stringWithFormat:@"id:%ld",(long)model.userId
                                ];
          [cell.titleImageView  sd_setImageWithURL:[NSURL  URLWithString:model.avatar_url]];


        return cell;

    }else if (tableView.tag==12){
       NSString *reuseableIdentifier=@"cellIdentifier2";
        cell=[tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
        if(cell==nil){
            cell=[[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];
        }
        UserModel *model =[(self.DatasourceOfPageListObjectTwo.dataSourceArray) objectAtIndex:indexPath.row];
        cell.rankLabel.text = [NSString stringWithFormat:@"%ld",(long)(indexPath.row +1)
                               ];
        cell.mainLabel.text =[NSString stringWithFormat:@"%@",model.login
                              ];
        cell.detailLabel.text =[NSString stringWithFormat:@"id:%ld",(long)model.userId
                                ];
        [cell.titleImageView  sd_setImageWithURL:[NSURL  URLWithString:model.avatar_url]];


        return cell;
    }else if (tableView.tag ==13){
       NSString *reuseableIdentifier=@"cellIdentifier3";
        cell=[tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
        if(cell==nil){
            cell=[[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];
        }
        UserModel *model =[(self.DatasourceOfPageListObjectThree.dataSourceArray) objectAtIndex:indexPath.row];
        cell.rankLabel.text = [NSString stringWithFormat:@"%ld",(long)(indexPath.row +1)
                               ];
        cell.mainLabel.text =[NSString stringWithFormat:@"%@",model.login
                              ];
        cell.detailLabel.text =[NSString stringWithFormat:@"id:%ld",(long)model.userId
                                ];
        [cell.titleImageView  sd_setImageWithURL:[NSURL  URLWithString:model.avatar_url]];
        return cell;
    }

    return cell;

}





@end
