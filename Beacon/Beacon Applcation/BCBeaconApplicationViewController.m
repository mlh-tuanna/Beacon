//
//  BCBeaconApplicationViewController.m
//  Beacon
//
//  Created by Nguyen Thanh Son on 8/22/14.
//  Copyright (c) 2014 LTT. All rights reserved.
//

#import "BCBeaconApplicationViewController.h"

@interface BCBeaconApplicationViewController ()<CBPeripheralDelegate, CBPeripheralManagerDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>

@end

@implementation BCBeaconApplicationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!self.peripheralManager)
        self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
    self.locationManager = [[CLLocationManager alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Method Switch Status Beacon
- (IBAction)switchStatusBeaconChangeValue:(id)sender {
    if (self.switchStatusBeacon.on) {
        [self turnOnAdvertising];
    }else{
        self.locationManager.delegate = nil;
        [self peripheralManagerDidUpdateState:self.peripheralManager];
    }
}

#pragma mark - Method Handle Beacon
- (void)turnOnAdvertising
{
    if (self.peripheralManager.state != CBPeripheralManagerStatePoweredOn) {
        NSLog(@"Peripheral manager is off.");
        self.lblDetailBeacon.text = @"Bluetooth đang tắt.";
        self.switchStatusBeacon.on = NO;
        return;
    }
    self.locationManager.delegate = self;
    [self initRegion];
}


#pragma mark - Method initial Beacon
- (void)initRegion{
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"AD6D82ED-4D25-4933-AB3C-792763481E88"];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"SomeIdentifier"];
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
    
}

#pragma mark - MEthod Delegate CLLocationManager
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region{
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region{
    if ([beacons count] > 0) {
        CLBeacon *beacon = [beacons objectAtIndex:0];
        self.lblDetailBeacon.text = [NSString stringWithFormat:@"Ban dang o beacon %d", [beacon.major intValue]];
    }
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheralManager error:(NSError *)error
{
    if (error) {
        NSLog(@"Couldn't turn on advertising: %@", error);
        self.switchStatusBeacon.on = NO;
        return;
    }
    
    if (peripheralManager.isAdvertising) {
        NSLog(@"Turned on advertising.");
        self.switchStatusBeacon.on = YES;
    }else{
        self.lblDetailBeacon.text = @"Bluetooth đang bật ...";
    }
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheralManager
{
    if (peripheralManager.state != CBPeripheralManagerStatePoweredOn) {
        NSLog(@"Peripheral manager is off.");
        self.switchStatusBeacon.on = NO;
        return;
    }
    
    NSLog(@"Peripheral manager is on.");
    self.lblDetailBeacon.text = @"Bluetooth đang bật ...";
}

#pragma mark - Method in UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString static *cellID = @"ProductCell";
    BCProductTableViewCell *cellProduct = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    return cellProduct;
}
@end
