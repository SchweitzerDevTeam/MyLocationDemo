//
//  LeaderboardViewController.m
//  MyLocationDemo
//
//  Created by Evan Shioyama on 12/2/13.
//  Copyright (c) 2013 martha quiring. All rights reserved.
//

#import "LeaderboardViewController.h"
#import "Leaderboard.h"
#import "Statistic.h"

@interface LeaderboardViewController ()

@end

@implementation LeaderboardViewController
{
    NSArray * leaderboardData;
    Leaderboard *leaders;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    leaders = [[Leaderboard alloc] init];
    leaderboardData = [leaders getLeaders];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [leaderboardData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat: @"%d", [[leaderboardData objectAtIndex:indexPath.row] getVerticalFeetSkied]];
    return cell;
}

@end
