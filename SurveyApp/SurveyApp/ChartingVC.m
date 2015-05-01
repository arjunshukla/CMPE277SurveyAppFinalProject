//
//  ChartingVC.m
//  SurveyApp
//
//  Created by Arjun Shukla on 4/29/15.
//  Copyright (c) 2015 CMPE277. All rights reserved.
//

#import "ChartingVC.h"
#import <ShinobiCharts/ShinobiCharts.h>

@interface ChartingVC ()

@end

@implementation ChartingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // charting code...
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat margin = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 10.0 : 50.0;
    ShinobiChart *chart = [[ShinobiChart alloc] initWithFrame:CGRectInset(self.view.bounds, margin, margin)];
    chart.title = @"Trigonometric Functions";
    
    chart.autoresizingMask = ~UIViewAutoresizingNone;
    chart.licenseKey = @"PVJM17c2WyPYMNjMjAxNTA1Mjhhcmp1bi5zaHVrbGFAc2pzdS5lZHU=Pr1I3K5xNZd11PhbrDpufbHziBqD6N3BqePtLNVeQYDLq+jZiM5jFZEaff9m/fP0UFU97cFwdO7aD7B4zD0+f2AIXr9x37LjERkgikrKtQ9bJt2kD89aEIVt0xkcnaXmvk+Qh9uBkQpGeZIxhAcfdHn+0Upc=BQxSUisl3BaWf/7myRmmlIjRnMU2cA7q+/03ZX9wdj30RzapYANf51ee3Pi8m2rVW6aD7t6Hi4Qy5vv9xpaQYXF5T7XzsafhzS3hbBokp36BoJZg8IrceBj742nQajYyV7trx5GIw9jy/V6r0bvctKYwTim7Kzq+YPWGMtqtQoU=PFJTQUtleVZhbHVlPjxNb2R1bHVzPnh6YlRrc2dYWWJvQUh5VGR6dkNzQXUrUVAxQnM5b2VrZUxxZVdacnRFbUx3OHZlWStBK3pteXg4NGpJbFkzT2hGdlNYbHZDSjlKVGZQTTF4S2ZweWZBVXBGeXgxRnVBMThOcDNETUxXR1JJbTJ6WXA3a1YyMEdYZGU3RnJyTHZjdGhIbW1BZ21PTTdwMFBsNWlSKzNVMDg5M1N4b2hCZlJ5RHdEeE9vdDNlMD08L01vZHVsdXM+PEV4cG9uZW50PkFRQUI8L0V4cG9uZW50PjwvUlNBS2V5VmFsdWU+"; // TODO: add your trial licence key here!
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
