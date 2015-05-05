//
//  ViewPollDetails.m
//  SurveyApp
//
//  Created by Arjun Shukla on 5/3/15.
//  Copyright (c) 2015 CMPE277. All rights reserved.
//

#import "ViewPollDetailsVC.h"
#import "Singleton.h"
@interface ViewPollDetailsVC ()

@end

@implementation ViewPollDetailsVC
@synthesize lblCategory,lblChoice1,lblChoice2,lblChoice3,lblChoice4,lblExpiryDate,lblName,lblQuestion,lblStartDate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated
{
    [self setPollDetails:[Singleton getInstance].selectedPollDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setPollDetails:(NSDictionary*)pollDetails
{
//    NSDictionary* pollDetails= [Singleton getInstance].selectedPollDetails;
    
    lblName.text = [pollDetails valueForKey:@"pollName"];
    lblCategory.text = [pollDetails valueForKey:@"pollCategory"];
    lblQuestion.text = [pollDetails valueForKey:@"question"];
    lblStartDate.text = [pollDetails valueForKey:@"started_at"];
    lblExpiryDate.text = [pollDetails valueForKey:@"expired_at"];
    
    NSArray* arrChoice = [[NSArray alloc]initWithArray:[pollDetails valueForKey:@"choice"]];
    if([arrChoice count]==4)
        
    {
        for (int i=0; i<[arrChoice count]; i++)
        {
            
            switch (i) {
                case 0:{
                    lblChoice1.text = [arrChoice objectAtIndex:i];
                    break;
                }
                case 1:{
                    lblChoice2.text = [arrChoice objectAtIndex:i];
                    break;
                }
                case 2:{
                    lblChoice3.text = [arrChoice objectAtIndex:i];
                    break;
                }
                case 3:{
                    lblChoice4.text = [arrChoice objectAtIndex:i];
                }
                default:{
                    break;
                }
            }
        }
    }
    else if([arrChoice count]==3)
    {
        for (int i=0; i<[arrChoice count]; i++)
        {
            
            switch (i) {
                case 0:{
                    lblChoice1.text = [arrChoice objectAtIndex:i];
                    break;
                }
                case 1:{
                    lblChoice2.text = [arrChoice objectAtIndex:i];
                    break;
                }
                case 2:{
                    lblChoice3.text = [arrChoice objectAtIndex:i];
                    break;
                }
                default:{
                    break;
                }
            }
        }
        lblChoice4.text = @"-";
    }
    else if([arrChoice count]==2)
    {
        lblChoice1.text = [arrChoice objectAtIndex:0];
        lblChoice2.text = [arrChoice objectAtIndex:1];
        lblChoice3.text = @"-";
        lblChoice4.text = @"-";
    }
    
    self.navigationItem.title = @"Poll Details";
    
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