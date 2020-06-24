//
//  TableViewController.m
//  DevObjC-Lesson-3
//
//  Created by Евгений Иванов on 29/05/2019.
//  Copyright © 2019 Евгений Иванов. All rights reserved.
//

#import "TableViewController.h"
#import "CoreData/CoreDataService.h"

@interface TableViewController () <UISearchResultsUpdating>

@property (nonatomic, strong) NSMutableArray *dogs;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.obscuresBackgroundDuringPresentation = false;
    self.searchController.searchResultsUpdater = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.dogs = [[[CoreDataService sharedInstance] dogs] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (![self.searchController.searchBar.text isEqualToString:@""]) {
        return [self.searchResults count];
    } else {
        return [self.dogs count];
    }
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TableViewCell"];
    }
    Dog *dog;
    
    if (![self.searchController.searchBar.text isEqualToString:@""]) {
        dog = self.searchResults[indexPath.row];
    } else {
        dog = self.dogs[indexPath.row];
    }
    
    cell.textLabel.text = dog.breed;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", dog.subBreed];
//    NSArray *images = dog.images;
//    cell.imageView.image = [UIImage imageWithData:[images firstObject]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [[CoreDataService sharedInstance] removeDog:[self.dogs objectAtIndex:indexPath.row]];
    [self.dogs removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)updateSearchResultsForSearchController:(nonnull UISearchController *)searchController {
    if (searchController.searchBar.text) {
        NSLog(@"%@",searchController.searchBar.text);
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.breed CONTAINS[cd] %@", searchController.searchBar.text];
        self.searchResults = [[self.dogs filteredArrayUsingPredicate:predicate] mutableCopy];
        [self.tableView reloadData];
    }
}

@end
