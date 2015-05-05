//
//  ChartingVC.m
//  SurveyApp
//
//  Created by Arjun Shukla on 4/29/15.
//  Copyright (c) 2015 CMPE277. All rights reserved.
//

#import "ChartingVC.h"
#import <ShinobiCharts/ShinobiCharts.h>
#import "Singleton.h"
@interface ChartingVC ()<SChartDatasource>

@end

@implementation ChartingVC
NSDictionary* result[4];
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Latest Result";
}

-(void)viewWillAppear:(BOOL)animated
{
//    self.view.backgroundColor = [UIColor whiteColor];
//    CGFloat margin = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 10.0 : 50.0;
    ShinobiChart *chart = [[ShinobiChart alloc] initWithFrame:CGRectMake(5, 70, 365, 544)];
    chart.title = @"RESULT";
    
    chart.autoresizingMask = ~UIViewAutoresizingNone;
    chart.licenseKey = @"PVJM17c2WyPYMNjMjAxNTA1Mjhhcmp1bi5zaHVrbGFAc2pzdS5lZHU=Pr1I3K5xNZd11PhbrDpufbHziBqD6N3BqePtLNVeQYDLq+jZiM5jFZEaff9m/fP0UFU97cFwdO7aD7B4zD0+f2AIXr9x37LjERkgikrKtQ9bJt2kD89aEIVt0xkcnaXmvk+Qh9uBkQpGeZIxhAcfdHn+0Upc=BQxSUisl3BaWf/7myRmmlIjRnMU2cA7q+/03ZX9wdj30RzapYANf51ee3Pi8m2rVW6aD7t6Hi4Qy5vv9xpaQYXF5T7XzsafhzS3hbBokp36BoJZg8IrceBj742nQajYyV7trx5GIw9jy/V6r0bvctKYwTim7Kzq+YPWGMtqtQoU=PFJTQUtleVZhbHVlPjxNb2R1bHVzPnh6YlRrc2dYWWJvQUh5VGR6dkNzQXUrUVAxQnM5b2VrZUxxZVdacnRFbUx3OHZlWStBK3pteXg4NGpJbFkzT2hGdlNYbHZDSjlKVGZQTTF4S2ZweWZBVXBGeXgxRnVBMThOcDNETUxXR1JJbTJ6WXA3a1YyMEdYZGU3RnJyTHZjdGhIbW1BZ21PTTdwMFBsNWlSKzNVMDg5M1N4b2hCZlJ5RHdEeE9vdDNlMD08L01vZHVsdXM+PEV4cG9uZW50PkFRQUI8L0V4cG9uZW50PjwvUlNBS2V5VmFsdWU+"; // TODO: add your trial licence key here!
    
    // add a pair of axes
    SChartCategoryAxis *xAxis = [SChartCategoryAxis new];
    xAxis.style.interSeriesPadding = @1.0;
    chart.xAxis = xAxis;
    
    SChartAxis *yAxis = [SChartNumberAxis new];
    yAxis.title = @"No. of Votes";
    yAxis.rangePaddingHigh = @1.0;
    chart.yAxis = yAxis;
    
    
    xAxis.enableGesturePanning = true;
    xAxis.enableGestureZooming = true;
    yAxis.rangePaddingHigh = @(0.1);
    yAxis.enableGesturePanning = true;
    yAxis.enableGestureZooming = true;
    chart.datasource = self;
    [self.view addSubview:chart];
    
    result[0] = @{[[[Singleton getInstance].selectedPollDetails valueForKey:@"choice"] objectAtIndex:0]:[[[Singleton getInstance].selectedPollDetails valueForKey:@"results"] objectAtIndex:0]};
    result[1] = @{[[[Singleton getInstance].selectedPollDetails valueForKey:@"choice"] objectAtIndex:1]:[[[Singleton getInstance].selectedPollDetails valueForKey:@"results"] objectAtIndex:1]};
    result[2] = @{[[[Singleton getInstance].selectedPollDetails valueForKey:@"choice"] objectAtIndex:2]:[[[Singleton getInstance].selectedPollDetails valueForKey:@"results"] objectAtIndex:2]};
    result[3] = @{[[[Singleton getInstance].selectedPollDetails valueForKey:@"choice"] objectAtIndex:3]:[[[Singleton getInstance].selectedPollDetails valueForKey:@"results"] objectAtIndex:3]};
}


#pragma mark - SCChartDataSource Methods
-(NSInteger) numberOfSeriesInSChart:(ShinobiChart *)chart
{
    return 1;
}

#pragma mark - data
-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(NSInteger)index
{
    SChartColumnSeries *barSeries = [SChartColumnSeries new];
    
    if (index == 0) {
        barSeries.title = @"Ideal Velocity";
    } else {
        barSeries.title = @"Actual Velocity";
    }
    //    lineSeries.style.showFill = true;
    return barSeries;
}

- (NSInteger)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex
{
    return 2;
}

//- (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(NSInteger)dataIndex forSeriesAtIndex:(NSInteger)seriesIndex
//{
//
//}


-(id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(NSInteger)dataIndex forSeriesAtIndex:(NSInteger)seriesIndex {
    SChartDataPoint *datapoint = [SChartDataPoint new];
    NSString* key = result[seriesIndex].allKeys[dataIndex];
    datapoint.xValue = key;
    datapoint.yValue = result[seriesIndex][key];
    return datapoint;
}

@end
