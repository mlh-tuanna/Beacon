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
@property (weak, nonatomic) IBOutlet UISwitch *switchStatusBeacon;
@property (weak, nonatomic) IBOutlet UILabel *lblDetailBeacon;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//Beacon
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion;
@property (nonatomic, strong) CBPeripheralManager *peripheralManager;

- (IBAction)switchStatusBeaconChangeValue:(id)sender;
@end
