//
//  SortResultTableViewController.m
//  MLLocalizedIndexedCollationHelp
//
//  Created by zml on 15/11/11.
//  Copyright © 2015年 zml@lanmaq.com. All rights reserved.
//

#import "SortResultTableViewController.h"
#import "MLLocalizedIndexedCollationHelper.h"

@interface SortResultTableViewController ()
@property (nonatomic,strong) NSArray *testDataArray;
@property (nonatomic,strong) NSArray *tableViewDataSouceArray;
@property (nonatomic,strong) NSArray *tableViewSectionIndexTitleArray;
@end

@implementation SortResultTableViewController

#pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //if RowCount < 5 if will not show sectionIndex
    //self.tableView.sectionIndexMinimumDisplayRowCount = 5;
    //Only test  I don't achieve these functions
    self.searchDisplayController.searchBar.userInteractionEnabled = NO;
    self.tableView.sectionIndexColor = [UIColor blackColor];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
 
    NSString *path = [[NSBundle mainBundle]pathForResource:@"TestDateArray" ofType:@"plist"];
    _testDataArray = [NSArray arrayWithContentsOfFile:path];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //UISearchController
    //UISearchDisplayController
     __weak typeof(self) weakSelf = self;
#if  0
    [[MLLocalizedIndexedCollationHelper shareInstance] sortObjects:_testDataArray selector:@selector(description) result:^(NSDictionary *dictionary,NSError *error) {
        if (!dictionary){
            NSLog(@"%@",error);
        }
        __strong typedef(weakSelf) strongSelf = weakSelf;
       
        strongSelf.tableViewDataSouceArray = [dictionary objectForKey:@"SortResultArray"];//key/value ? see MLLocalizedIndexedCollationHelper.h
        NSMutableArray *indexTitleArray = [NSMutableArray arrayWithArray:(NSArray *)[dictionary objectForKey:@"SortResultArraySectionIndexTitle"]];
        [indexTitleArray insertObject:UITableViewIndexSearch atIndex:0];
        strongSelf.tableViewSectionIndexTitleArray = indexTitleArray;
      
        [strongSelf.tableView reloadData];
    }];
#else
    dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, NULL);
    [[MLLocalizedIndexedCollationHelper shareInstance] sortObjects:_testDataArray selector:@selector(description) onQueue:queue result:^(NSDictionary * _Nonnull dictionary, NSError * _Nonnull error) {
        if (!dictionary){
            NSLog(@"%@",error);
        }
        __strong typeof(weakSelf) strongSelf = weakSelf;
     
        strongSelf.tableViewDataSouceArray = [dictionary objectForKey:@"SortResultArray"];//key/value ? see MLLocalizedIndexedCollationHelper.h
        NSMutableArray *indexTitleArray = [NSMutableArray arrayWithArray:(NSArray *)[dictionary objectForKey:@"SortResultArraySectionIndexTitle"]];
        [indexTitleArray insertObject:UITableViewIndexSearch atIndex:0];
        strongSelf.tableViewSectionIndexTitleArray = indexTitleArray;
       
        dispatch_async(dispatch_get_main_queue(), ^{
            [strongSelf.tableView reloadData];
        });
    }];
#endif
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_tableViewDataSouceArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_tableViewDataSouceArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DisPalyNameCell" forIndexPath:indexPath];
    cell.textLabel.text = [_tableViewDataSouceArray objectAtIndex:indexPath.section][indexPath.row];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_tableViewSectionIndexTitleArray objectAtIndex:section + 1];
    //[[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
}
- (nullable NSArray<NSString *> *) sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _tableViewSectionIndexTitleArray;
    //You can also return as  [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles] ,it will display all the section Index titles (e.g. A-Z,# in US/English)
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index // tell table which section corresponds to section title/index (e.g. "B",1))
{
     if ([title isEqualToString:UITableViewIndexSearch]) {
        [self.tableView scrollRectToVisible:self.searchDisplayController.searchBar.frame animated:NO];
    }
    return index - 1;
    //[[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
