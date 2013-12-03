//
//  LeaderboardViewController.h
//  MyLocationDemo
//
//  Created by Evan Shioyama on 12/2/13.
//  Copyright (c) 2013 martha quiring. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderboardViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *leadersTable;

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
