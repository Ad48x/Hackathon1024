//
//  InterfaceController.m
//  WatchApp Extension
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "InterfaceController.h"

@interface NameCell : NSObject

@property (nonatomic, weak) IBOutlet WKInterfaceLabel *label;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceGroup *image;

@end

@implementation NameCell

@end

@interface InterfaceController()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceMap *mapView;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *table;
@property (nonatomic, strong) NSArray *data;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    self.data = @[
        @{ @"name": @"StoneJin", @"id": @"562a011e60b280457801ca11", @"avatar": @"http://ac-qp5mlkuc.clouddn.com/33aed9fde6ed43ce.JPG" },
        @{ @"name": @"TY", @"id": @"5629e6cf60b25974b27f81be", @"avatar": @"http://ac-qp5mlkuc.clouddn.com/4f0707ac69a6cb70.JPG" },
        @{ @"name": @"Cyan", @"id": @"562a578760b20fc98136d5c0", @"avatar": @"http://ac-qp5mlkuc.clouddn.com/2e98a01867218239.jpeg" },
        @{ @"name": @"Joker", @"id": @"562a578760b20fc98136d5c0", @"avatar": @"http://ac-qp5mlkuc.clouddn.com/decf8d842404b8a7.jpeg" },
        @{ @"name": @"Osiris", @"id": @"562a578760b20fc98136d5c0", @"avatar": @"http://ac-qp5mlkuc.clouddn.com/5788da117162c01a.jpg" },
    ];
    
    [self didReceiveMessage:^(NSDictionary *message) {
        
    }];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(+30.29506560, +120.00022254);
    [self.mapView setRegion:MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.01, 0.01))];
    [self.mapView addAnnotation:coordinate withPinColor:WKInterfaceMapPinColorRed];
    
    [self.table setNumberOfRows:self.data.count withRowType:@"NameCell"];
    for (int i=0; i<self.data.count; ++i) {
        NameCell *cell = [self.table rowControllerAtIndex:i];
        [cell.label setText:self.data[i][@"name"]];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"avatar_%d.jpg", i + 1]];
        [cell.image setBackgroundImage:image];
    }
}

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex {
    WKAlertAction *cancelAction = [WKAlertAction actionWithTitle:@"取消" style:WKAlertActionStyleCancel handler:^{
    }];
    WKAlertAction *sendAction = [WKAlertAction actionWithTitle:@"打招呼" style:WKAlertActionStyleCancel handler:^{
        [self sendMessageToPhone:@{ @"cmd": @"push", @"id": (self.data[rowIndex][@"id"])?:@"" }];
    }];
    [self presentAlertControllerWithTitle:self.data[rowIndex][@"name"] message:@"" preferredStyle:WKAlertControllerStyleAlert actions:@[cancelAction, sendAction]];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



