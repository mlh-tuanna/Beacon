//
//  BCMasterViewController.m
//  Beacon
//
//  Created by Nguyen Anh Tuan on 8/22/14.
//  Copyright (c) 2014 LTT. All rights reserved.
//

#import "BCMasterViewController.h"

#import "BCBeaconViewController.h"

@interface BCMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation BCMasterViewController

#pragma mark - Table View

- (void)viewDidLoad
{
    [super viewDidLoad];
    _objects = [[NSMutableArray alloc] initWithObjects:@"Cửa vào",
                @"Quần áo",
                @"Thực phẩm",
                @"Điện gia dụng",
                @"Mỹ phẩm",
                @"Trang sức",
                @"Điểm thanh toán",
                @"Cửa ra",
                nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"beaconPointCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSString *title = [_objects objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *object = [_objects objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BCBeaconViewController *beaconViewController = [storyboard instantiateViewControllerWithIdentifier:@"BCBeaconViewController"];
    [beaconViewController setDetailItem:object];
    [beaconViewController setMinor:indexPath.row];
    [self.navigationController pushViewController:beaconViewController animated:YES];
}


@end
