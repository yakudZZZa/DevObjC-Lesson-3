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
    self.searchController.dimsBackgroundDuringPresentation = false;
    self.searchController.searchResultsUpdater = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)updateSearchResultsForSearchController:(nonnull UISearchController *)searchController {
    if (searchController.searchBar.text) {
        NSLog(@"%@",searchController.searchBar.text);
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.breed CONTAINS[cd] %@", searchController.searchBar.text];
        self.searchResults = [[self.dogs filteredArrayUsingPredicate:predicate] mutableCopy];
        [self.tableView reloadData];
    }
}

@end
