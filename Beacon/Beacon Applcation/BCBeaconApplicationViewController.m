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
    self.items = [[NSMutableArray alloc] init];
    //Type Product
    //Electric Product
    electricProducts = [[NSMutableArray alloc] init];
    NSString *pathElectric = [[NSBundle mainBundle] pathForResource:@"Electric" ofType:@"txt"];
    NSString *contentFileElectric = [NSString stringWithContentsOfFile:pathElectric encoding:NSUTF8StringEncoding error:nil];
    NSArray *arrayElectricProduct = [contentFileElectric componentsSeparatedByString:@"\n"];
    for (NSString *item in arrayElectricProduct) {
        NSMutableDictionary *product = [[NSMutableDictionary alloc] init];
        NSArray *arrayString = [item componentsSeparatedByString:@";"];
        [product setValue:[arrayString objectAtIndex:0] forKey:@"image"];
        [product setValue:[arrayString objectAtIndex:1] forKey:@"info"];
        [product setValue:[arrayString objectAtIndex:2] forKey:@"price"];
        [electricProducts addObject:product];
    }

    //Cosmetics Product
    cosmeticsProducts = [[NSMutableArray alloc] init];
    NSString *pathCosmetics = [[NSBundle mainBundle] pathForResource:@"Cosmetics" ofType:@"txt"];
    NSString *contentFileCosmetics = [NSString stringWithContentsOfFile:pathCosmetics encoding:NSUTF8StringEncoding error:nil];
    NSArray *arrayCosmeticsProduct = [contentFileCosmetics componentsSeparatedByString:@"\n"];
    for (NSString *item in arrayCosmeticsProduct) {
        NSMutableDictionary *product = [[NSMutableDictionary alloc] init];
        NSArray *arrayString = [item componentsSeparatedByString:@";"];
        [product setValue:[arrayString objectAtIndex:0] forKey:@"image"];
        [product setValue:[arrayString objectAtIndex:1] forKey:@"info"];
        [product setValue:[arrayString objectAtIndex:2] forKey:@"price"];
        [cosmeticsProducts addObject:product];
    }
    
    clothesProducts = [[NSMutableArray alloc] init];
    NSString *pathClothes = [[NSBundle mainBundle] pathForResource:@"Clothes" ofType:@"txt"];
    NSString *contentFileClothes = [NSString stringWithContentsOfFile:pathClothes encoding:NSUTF8StringEncoding error:nil];
    NSArray *arrayClothesProduct = [contentFileClothes componentsSeparatedByString:@"\n"];
    for (NSString *item in arrayClothesProduct) {
        NSMutableDictionary *product = [[NSMutableDictionary alloc] init];
        NSArray *arrayString = [item componentsSeparatedByString:@";"];
        [product setValue:[arrayString objectAtIndex:0] forKey:@"image"];
        [product setValue:[arrayString objectAtIndex:1] forKey:@"info"];
        [product setValue:[arrayString objectAtIndex:2] forKey:@"price"];
        [clothesProducts addObject:product];
    }
    
    foodProducts = [[NSMutableArray alloc] init];
    NSString *pathFood = [[NSBundle mainBundle] pathForResource:@"Food" ofType:@"txt"];
    NSString *contentFileFood = [NSString stringWithContentsOfFile:pathFood encoding:NSUTF8StringEncoding error:nil];
    NSArray *arrayFoodProduct = [contentFileFood componentsSeparatedByString:@"\n"];
    for (NSString *item in arrayFoodProduct) {
        NSMutableDictionary *product = [[NSMutableDictionary alloc] init];
        NSArray *arrayString = [item componentsSeparatedByString:@";"];
        [product setValue:[arrayString objectAtIndex:0] forKey:@"image"];
        [product setValue:[arrayString objectAtIndex:1] forKey:@"info"];
        [product setValue:[arrayString objectAtIndex:2] forKey:@"price"];
        [foodProducts addObject:product];
    }
    
    jewelryProducts = [[NSMutableArray alloc] init];
    NSString *pathJewelry = [[NSBundle mainBundle] pathForResource:@"Jewelry" ofType:@"txt"];
    NSString *contentFileJewelry = [NSString stringWithContentsOfFile:pathJewelry encoding:NSUTF8StringEncoding error:nil];
    NSArray *arrayJewelryProduct = [contentFileJewelry componentsSeparatedByString:@"\n"];
    for (NSString *item in arrayJewelryProduct) {
        NSMutableDictionary *product = [[NSMutableDictionary alloc] init];
        NSArray *arrayString = [item componentsSeparatedByString:@";"];
        [product setValue:[arrayString objectAtIndex:0] forKey:@"image"];
        [product setValue:[arrayString objectAtIndex:1] forKey:@"info"];
        [product setValue:[arrayString objectAtIndex:2] forKey:@"price"];
        [jewelryProducts addObject:product];
    }
    // Do any additional setup after loading the view.
    if (!self.peripheralManager)
        self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
    self.locationManager = [[CLLocationManager alloc] init];
    [self.tableView setHidden:YES];
    [self.imgStatus setHidden:YES];
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
        [self.tableView setHidden:YES];
        [self.imgStatus setHidden:YES];
        [self peripheralManagerDidUpdateState:self.peripheralManager];
    }
}

#pragma mark - Method Handle Beacon
- (void)turnOnAdvertising
{
    if (self.peripheralManager.state != CBPeripheralManagerStatePoweredOn) {
        NSLog(@"Peripheral manager is off.");
        self.lblDetailBeacon.text = @"Bluetooth is OFF.";
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
    [self peripheralManagerDidUpdateState:self.peripheralManager];
}


- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region{
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region{
    if ([beacons count] > 0) {
        CLBeacon *beacon = [beacons objectAtIndex:0];
        self.lblDetailBeacon.text = [NSString stringWithFormat:@"You are located in areas Beacon %d", [beacon.minor intValue]];
        switch ([beacon.minor intValue]) {
            case 1:
                self.imgStatus.image = [UIImage imageNamed:@"welcom.png"];
                self.imgStatus.hidden = NO;
                self.tableView.hidden = YES;
                break;
            case 2:
                self.imgStatus.hidden = YES;
                self.tableView.hidden = NO;
                self.items = electricProducts;
                titleProduct = @"Electric";
                [self.tableView reloadData];
                break;
            case 3:
                self.imgStatus.hidden = YES;
                self.tableView.hidden = NO;
                self.items = cosmeticsProducts;
                titleProduct = @"Cosmetics";
                [self.tableView reloadData];
                break;
            case 4:
                self.imgStatus.hidden = YES;
                self.tableView.hidden = NO;
                self.items = clothesProducts;
                titleProduct = @"Clothes";
                [self.tableView reloadData];
                break;
            case 5:
                self.imgStatus.hidden = YES;
                self.tableView.hidden = NO;
                self.items = foodProducts;
                titleProduct = @"Food";
                [self.tableView reloadData];
                break;
            case 6:
                self.imgStatus.hidden = YES;
                self.tableView.hidden = NO;
                self.items = jewelryProducts;
                titleProduct = @"Jewelry";
                [self.tableView reloadData];
                break;
            case 7:
                self.imgStatus.image = [UIImage imageNamed:@"thankyou.jpg"];
                self.imgStatus.hidden = NO;
                self.tableView.hidden = YES;
        }
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
        self.lblDetailBeacon.text = @"Bluetooth is ON ...";
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
    self.lblDetailBeacon.text = @"Bluetooth is ON ...";
}

#pragma mark - Method in UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString static *cellID = @"ProductCell";
    BCProductTableViewCell *cellProduct = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cellProduct.imgProduct.image = [UIImage imageNamed:[[self.items objectAtIndex:indexPath.row] objectForKey:@"image"]];
    cellProduct.lblInfoProduct.text = [[self.items objectAtIndex:indexPath.row] objectForKey:@"info"];
    cellProduct.lblPriceProduct.text = [[self.items objectAtIndex:indexPath.row] objectForKey:@"price"];
    return cellProduct;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"%@ Product List", titleProduct];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
@end
