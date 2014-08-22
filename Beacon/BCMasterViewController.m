//
//  BCMasterViewController.m
//  Beacon
//
//  Created by Nguyen Anh Tuan on 8/22/14.
//  Copyright (c) 2014 LTT. All rights reserved.
//

#import "BCMasterViewController.h"

#import "BCDetailViewController.h"

@interface BCMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation BCMasterViewController

#pragma mark - Table View

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        NSString *beacon = cell.textLabel.text;
        [[segue destinationViewController] setDetailItem:beacon];
    }
}

@end
