//
//  DogsViewController.m
//  DevObjC-Lesson-3
//
//  Created by Евгений Иванов on 16/05/2019.
//  Copyright © 2019 Евгений Иванов. All rights reserved.
//

#import "DogsViewController.h"
#import "MyTableViewCell.h"

@interface DogsViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation DogsViewController

- (instancetype)initWithRateModel:(NSArray*)pictureList {
    self = [super init];
    if (self) {
        self.pictureList = pictureList;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    [self.view addSubview:tableView];
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 280.0;

}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.pictureList count];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"Cell"];
    }
    NSLog(@"%@", [self.pictureList objectAtIndex:indexPath.row]);
    [cell configWithImages:[self.pictureList objectAtIndex:indexPath.row]];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 280.0;
}

@end
