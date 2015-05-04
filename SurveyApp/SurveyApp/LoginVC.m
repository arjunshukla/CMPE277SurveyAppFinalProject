//
//  LoginVC.m
//  SurveyApp
//
//  Created by Arjun Shukla on 4/30/15.
//  Copyright (c) 2015 CMPE277. All rights reserved.
//

#import "LoginVC.h"
#import "URLs.h"
#import "Singleton.h"
@implementation LoginVC
@synthesize txtEmail,txtPassword,btnLoginSignup,txtRePassword,lblRePassword,segmentOutlet,txtName,lblName;

-(void) viewDidLoad
{
    txtName.hidden = true;
    lblName.hidden = true;
    txtRePassword.hidden = true;
    lblRePassword.hidden = true;
    [btnLoginSignup setTitle:@"Login" forState:UIControlStateNormal];
}
- (IBAction)onLoginBtnTap:(id)sender {
    if(segmentOutlet.selectedSegmentIndex == 0) // for login
    {
        NSInteger success = 0;
        BOOL isValidUser = false;
        @try
        {
            if([[self.txtEmail text] isEqualToString:@""] || [[self.txtPassword text] isEqualToString:@""] )
            {
                
                [self alertStatus:@"Please enter Email and Password" :@"Sign in Failed!" :0];
            }
            else
            {
                NSURL *url=[NSURL URLWithString:[URLIP stringByAppendingString:URLLoginPOST]];
                NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     txtEmail.text, @"email",
                                     txtPassword.text, @"password",
                                     nil];
                NSError *error = [[NSError alloc] init];
                NSData *postData = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                [request setURL:url];
                [request setHTTPMethod:@"POST"];
                [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
                [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                [request setHTTPBody:postData];
                NSHTTPURLResponse *response = nil;
                NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
                NSLog(@"Response code: %ld", (long)[response statusCode]);
                if ([response statusCode] >= 200 && [response statusCode] < 300)
                {
                    NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                    NSLog(@"Response ==> %@", responseData);
                    
                    
                    NSError *error = nil;
                    NSDictionary *jsonData = [NSJSONSerialization
                                              JSONObjectWithData:urlData
                                              options:NSJSONReadingMutableContainers
                                              error:&error];
                    if([[jsonData valueForKey:@"success"] isEqualToString:@"true"])
                    {
                        isValidUser = true;
                        success = 1;
                        NSLog(@"Success: %ld",(long)success);
                        
                        [Singleton getInstance].moderatorId = [[NSString alloc]initWithString:[jsonData valueForKey:@"moderatorID"]];
                        if(success == 1)
                        {
                            NSLog(@"Login SUCCESS");
                        } else
                        {
                            
                            NSString *error_msg = (NSString *) jsonData[@"error_message"];
                            [self alertStatus:error_msg :@"Sign in Failed!" :0];
                        }
                    }
                    else
                    {
                        [self alertStatus:@"Login Failed" :@"User Does not exist!\nPlease signup" :0];
                    }
                }
                    else
                    {
                        [self alertStatus:@"Connection Failed" :@"Sign in Failed!" :0];
                    }
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
    }
    else // for signup
    {
        NSInteger success = 0;
        BOOL isValidUser = false;
        @try
        {
            if([txtName.text isEqualToString:@""] || [txtEmail.text isEqualToString:@""] || [txtPassword.text isEqualToString:@""] || [txtRePassword.text isEqualToString:@""])
            {
                
                [self alertStatus:@"Please enter Name, Email and Password" :@"Incomplete Details" :0];
            }
            else if([txtPassword.text isEqualToString:txtRePassword.text])
                [self alertStatus:@"" :@"Passwords don't Match" :0];
            else
            {
                NSURL *url=[NSURL URLWithString:[URLIP stringByAppendingString:URLCreateModeratorPOST]];
                NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     txtName.text, @"name",
                                     txtEmail.text, @"email",
                                     txtPassword.text, @"password",
                                     nil];
                NSError *error = [[NSError alloc] init];
                NSData *postData = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                [request setURL:url];
                [request setHTTPMethod:@"POST"];
                [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
                [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                [request setHTTPBody:postData];
                NSHTTPURLResponse *response = nil;
                NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
                NSLog(@"Response code: %ld", (long)[response statusCode]);
                if ([response statusCode] >= 200 && [response statusCode] < 300)
                {
                    NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                    NSLog(@"Response ==> %@", responseData);
                    if([response statusCode] == 201)
                    {
                        isValidUser = true;
                        NSError *error = nil;
                        NSDictionary *jsonData = [NSJSONSerialization
                                                  JSONObjectWithData:urlData
                                                  options:NSJSONReadingMutableContainers
                                                  error:&error];
                        [Singleton getInstance].moderatorId = [jsonData valueForKey:@"moderatorID"];
                        //                     success = [jsonData[@"success"] integerValue];
                        success = 1;
                        NSLog(@"Success: %ld",(long)success);
                        
                        if(success == 1)
                        {
                            NSLog(@"Login SUCCESS");
                        }
                        else
                        {
                            NSString *error_msg = (NSString *) jsonData[@"error_message"];
                            [self alertStatus:error_msg :@"Sign in Failed!" :0];
                        }
                    }
                    else
                    {
                        [self alertStatus:@"Connection Failed" :@"Sign in Failed!" :0];
                    }
                }
                else if([response statusCode] == 409)
                {
                    [self alertStatus:@"Please login." :@"User already exists!" :0];
                }
            }
        }
        @catch (NSException * e) {
            NSLog(@"Exception: %@", e);
            [self alertStatus:@"Sign in Failed." :@"Error!" :0];
        }
        if (isValidUser) {
            [self performSegueWithIdentifier:@"LoginSuccess" sender:self];
        }
    }
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


- (BOOL)textFieldShouldReturn:(UITextField *)emailTextField {
    [emailTextField resignFirstResponder];
    return YES;
    
}
- (IBAction)SegmentSwitch:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        //toggle the correct view to be visible
        txtName.hidden = true;
        lblName.hidden = true;
        txtRePassword.hidden = true;
        lblRePassword.hidden = true;
        [btnLoginSignup setTitle:@"Login" forState:UIControlStateNormal];
        
    }
    else{
        //toggle the correct view to be visible
        txtName.hidden = false;
        lblName.hidden = false;
        txtRePassword.hidden = false;
        lblRePassword.hidden = false;
        [btnLoginSignup setTitle:@"SignUp & Login" forState:UIControlStateNormal];
    }
}

#pragma mark touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark textield
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
