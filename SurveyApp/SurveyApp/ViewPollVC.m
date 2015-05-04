//
//  SecondViewController.m
//  SurveyApp
//
//  Created by Arjun Shukla on 4/28/15.
//  Copyright (c) 2015 CMPE277. All rights reserved.
//

#import "ViewPollVC.h"
#import "URLs.h"
#include "Singleton.h"
#import "ViewPollDetailsVC.h"
@interface ViewPollVC ()

@end

@implementation ViewPollVC
NSArray* arrPollList, *arrPolls;
NSDictionary *jsonData;


-(void) viewDidLoad{
    self.navigationItem.title = @"View Polls";
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSInteger success = 0;
    BOOL isValidUser = false;
    @try
    {
        NSString *urlString = [NSString stringWithFormat:[URLIP stringByAppendingString:URLGetAllPollsGET],[Singleton getInstance].moderatorId];
        
        NSURL *url=[NSURL URLWithString:urlString];
        
        //                    NSURL *url=[NSURL URLWithString:URLGetAllPollsGET];
        
        NSError *error = [[NSError alloc] init];
        //            NSData *postData = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"GET"];
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
            
                
                NSError *error = nil;
                jsonData = [NSJSONSerialization
                                          JSONObjectWithData:urlData
                                          options:NSJSONReadingMutableContainers
                                          error:&error];
            
            arrPollList = [[NSArray alloc] initWithArray:[jsonData valueForKey:@"pollName"]];
            arrPolls = (NSArray*)jsonData;
            [self.tableViewPollList reloadData];
//            for(int i=0;i<[jsonData count]; i++)
//            {
//                [arrPolls addObject:jsonData];
//            }
            
            
            success = 1;
                NSLog(@"Success: %ld",(long)success);
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
        [self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }
    if (isValidUser)
    {
        [self performSegueWithIdentifier:@"LoginSuccess" sender:self];
    }
    
    //    arrPollList = [[NSArray alloc] initWithArray:arrPollList, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}

#pragma mark tableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrPollList count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    
    cell.textLabel.text = [arrPollList objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"More text";
//    cell.imageView.image = [UIImage imageNamed:@"flower.png"];
    
    // set the accessory view:
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"viewPollDetailsSegue"])
    {
//        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
//        ViewPollDetailsVC *objPoll = [segue destinationViewController];
        
        NSIndexPath *myIndexPath = [self.tableViewPollList
                                    indexPathForSelectedRow];
        
        long index = [myIndexPath row];
        
        [Singleton getInstance].selectedPollDetails = [arrPolls objectAtIndex:index];
//        ViewPollDetailsVC *objPoll = [[ViewPollDetailsVC alloc] init];
//        objPoll.lblName.text = [[arrPolls objectAtIndex:index] valueForKey:@"pollName"];
//        objPoll.lblCategory.text = [[arrPolls objectAtIndex:index] valueForKey:@"pollCategory"];
//        objPoll.lblQuestion.text = [[arrPolls objectAtIndex:index] valueForKey:@"question"];
//        objPoll.lblStartDate.text = [[arrPolls objectAtIndex:index] valueForKey:@"started_at"];
//        objPoll.lblExpiryData.text = [[arrPolls objectAtIndex:index] valueForKey:@"expired_at"];
//        objPoll.lblChoice1 = [[arrPolls objectAtIndex:index] valueForKey:@"choice"];
//        objPoll.lblChoice2 = [[arrPolls objectAtIndex:index] valueForKey:@""];
//        objPoll.lblChoice3 = [[arrPolls objectAtIndex:index] valueForKey:@""];
//        objPoll.lblChoice4 = [[arrPolls objectAtIndex:index] valueForKey:@""];
        
        
//        detailViewController.carDetailModel = @[_carMakes[row],
//                                                _carModels[row], _carImages[row]];
    }
}

//-(void) tableView
@end
