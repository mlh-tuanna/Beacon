//
//  BCDetailViewController.h
//  Beacon
//
//  Created by Nguyen Anh Tuan on 8/22/14.
//  Copyright (c) 2014 LTT. All rights reserved.
//

#import <UIKit/UIKit.h>

@import CoreLocation;
@import CoreBluetooth;

@interface BCBeaconViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (nonatomic) NSInteger minor;

@end
