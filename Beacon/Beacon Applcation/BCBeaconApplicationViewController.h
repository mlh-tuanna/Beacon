//
//  BCBeaconApplicationViewController.h
//  Beacon
//
//  Created by Nguyen Thanh Son on 8/22/14.
//  Copyright (c) 2014 LTT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import "BCProductTableViewCell.h"

@interface BCBeaconApplicationViewController : UIViewController
{
    NSMutableArray *electricProducts;
    NSMutableArray *cosmeticsProducts;
    NSMutableArray *clothesProducts;
    NSMutableArray *foodProducts;
    NSMutableArray *jewelryProducts;
    NSString *titleProduct;
}
@property (weak, nonatomic) IBOutlet UISwitch *switchStatusBeacon;
@property (weak, nonatomic) IBOutlet UILabel *lblDetailBeacon;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imgStatus;



@property (nonatomic, strong) NSMutableArray *items;

//Beacon
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion;
@property (nonatomic, strong) CBPeripheralManager *peripheralManager;

- (IBAction)switchStatusBeaconChangeValue:(id)sender;
@end
