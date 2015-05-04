//
//  VoteForSelectedPollVC.m
//  SurveyApp
//
//  Created by Arjun Shukla on 5/3/15.
//  Copyright (c) 2015 CMPE277. All rights reserved.
//

#import "VoteForSelectedPollVC.h"
#import "Singleton.h"
#import "URLs.h"
@interface VoteForSelectedPollVC ()

@end

@implementation VoteForSelectedPollVC
@synthesize lblCategory,lblChoice1,lblChoice2,lblChoice3,lblChoice4,lblExpiryDate,lblName,lblQuestion,lblStartDate,btnChoice3,btnChoice4;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Cast Vote";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) viewWillAppear:(BOOL)animated
{
    [self setPollDetails:[Singleton getInstance].selectedPollDetails];
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
        btnChoice4.userInteractionEnabled=false;
    }
    else if([arrChoice count]==2)
    {
        lblChoice1.text = [arrChoice objectAtIndex:0];
        lblChoice2.text = [arrChoice objectAtIndex:1];
        lblChoice3.text = @"-";
        btnChoice3.userInteractionEnabled=false;
        lblChoice4.text = @"-";
        btnChoice4.userInteractionEnabled=false;
    }
}

- (IBAction)onChoosingOption:(id)sender
{
    [self castVote:[sender tag]-1];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Voting Done" message:@"Thanks for casting your vote.\nWe appreciate your participation" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

-(void) castVote:(NSInteger)choice
{
    @try
    {
        NSString *urlString = [NSString stringWithFormat:[URLIP stringByAppendingString:URLCastVotePUT],[[Singleton getInstance].selectedPollDetails valueForKey:@"id"],choice];
        
        
        NSURL *url=[NSURL URLWithString:urlString];
        
        //                    NSURL *url=[NSURL URLWithString:URLGetAllPollsGET];
        
        NSError *error = [[NSError alloc] init];
        //            NSData *postData = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"PUT"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        //            [request setHTTPBody:postData];
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSLog(@"Response code: %ld", (long)[response statusCode]);
        if ([response statusCode] >= 200 && [response statusCode] < 300)
        {
            NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
            NSLog(@"Response ==> %@", responseData);
            
            
//            NSError *error = nil;
//            NSDictionary *json = [NSJSONSerialization
//                    JSONObjectWithData:urlData
//                    options:NSJSONReadingMutableContainers
//                    error:&error];
//            
//            NSLog(@"Success: %ld",(long)success);
            //            if([responseData isEqualToString:@"true"])
            //            {
            //                [Singleton getInstance].moderatorId = [jsonData valueForKey:@"moderatorID"];
            //                if(success == 1)
            //                {
            //                    NSLog(@"Login SUCCESS");
            //                } else {
            //
            //                    NSString *error_msg = (NSString *) jsonData[@"error_message"];
            //                    [self alertStatus:error_msg :@"Sign in Failed!" :0];
            //                }
            //            } else {
            //                [self alertStatus:@"Connection Failed" :@"Sign in Failed!" :0];
            //            }
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
//        [self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }
}

#pragma mark alrtViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
       [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
