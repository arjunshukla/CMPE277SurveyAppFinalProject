//
//  FirstViewController.m
//  SurveyApp
//
//  Created by Arjun Shukla on 4/28/15.
//  Copyright (c) 2015 CMPE277. All rights reserved.
//

#import "CreatePollVC.h"
#import "URLs.h"
#import "Singleton.h"
@interface CreatePollVC ()

@end

@implementation CreatePollVC
@synthesize txtCategory,txtPollName,pickerCategory,pickerDate,txtExpiryDate,txtFirstOption,txtQuestion,txtSecondOption,txtStartDate,txtThirdOption,txtFourthOption,viewVisual;
NSArray* arrCategory;
CGPoint originalCenter;
BOOL isStartDate = false;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    pickerCategory.hidden = true;
    arrCategory = [[NSArray alloc]initWithObjects:@"General",@"Closed Invitation",@"Open-unique",@"On-Spot", nil];
    
    [pickerDate addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    pickerDate.backgroundColor = [UIColor lightGrayColor];
    pickerCategory.backgroundColor = [UIColor lightGrayColor];
    originalCenter = self.view.center;
    
    txtFirstOption.delegate = self;
    txtSecondOption.delegate = self;
    txtThirdOption.delegate = self;
    txtFourthOption.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ButtonActions

- (IBAction)onCategoryTap:(id)sender {
    pickerCategory.hidden = false;
    pickerDate.hidden = true;
}

- (IBAction)onCreateBtnTap:(id)sender {
    @try
    {
        if([txtPollName.text isEqualToString:@""] || [txtCategory.text isEqualToString:@""] || [txtQuestion.text isEqualToString:@""] || [txtStartDate.text isEqualToString:@""] || [txtExpiryDate.text isEqualToString:@""] || [txtFirstOption.text isEqualToString:@""] || [txtSecondOption.text isEqualToString:@""])
        {
            
            [self alertStatus:@"Please enter all details" :@"Insufficient Data" :0];
        }
        else
        {
            NSArray *tmpArr = [[NSArray alloc]initWithObjects:txtFirstOption.text, txtSecondOption.text,txtThirdOption.text,txtFourthOption.text, nil];
            
            NSString *urlString = [NSString stringWithFormat:[URLIP stringByAppendingString:URLCreatePollPOST],[Singleton getInstance].moderatorId];
            
            NSURL *url=[NSURL URLWithString:urlString];
            
            NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 txtQuestion.text, @"question",
                                 txtStartDate.text, @"started_at",
                                 txtExpiryDate.text, @"expired_at",
                                 txtPollName.text, @"pollName",
                                 txtCategory.text, @"pollCategory",
                                 tmpArr,@"choice",
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
                NSError *error = nil;
                NSDictionary *jsonData = [NSJSONSerialization
                                          JSONObjectWithData:urlData
                                          options:NSJSONReadingMutableContainers
                                          error:&error];
                
                
                [self alertStatus:[NSString stringWithFormat:@"Survey created with id: %@.",[jsonData valueForKey:@"id"]] :@"Survey Created" :0];
                [self.view endEditing:YES];
                pickerCategory.hidden=true;
                pickerDate.hidden=true;
                [self clearFields];
            }
            else
            {
                [self alertStatus:@"Please try again" :@"Error" :0];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Sign in Failed." :@"Error!" :0];
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


-(void)clearFields
{
    txtPollName.text=@"";
    txtCategory.text=@"";
    txtQuestion.text=@"";
    txtStartDate.text=@"";
    txtExpiryDate.text=@"";
    txtFirstOption.text=@"";
    txtSecondOption.text=@"";
    txtThirdOption.text=@"";
    txtFourthOption.text=@"";
}

- (IBAction)onStartDateTap:(id)sender {
    isStartDate = true;
    pickerDate.hidden = false;
    pickerCategory.hidden = true;
}

- (IBAction)onEndDateTap:(id)sender {
    isStartDate = false;
    pickerDate.hidden = false;
    pickerCategory.hidden = true;
}


#pragma mark datePicker
- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
    
    if(isStartDate)
        txtStartDate.text = strDate;
    else
        txtExpiryDate.text = strDate;
}

#pragma mark touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    pickerCategory.hidden=true;
    pickerDate.hidden=true;
}

# pragma mark - pickerView DataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [arrCategory count];
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [arrCategory objectAtIndex:row];
}

#pragma mark - pickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    txtCategory.text = [arrCategory objectAtIndex:row];
}

#pragma mark textfield

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == txtThirdOption || textField == txtFourthOption)
    {
        [UIView animateWithDuration:0.3f animations:^{
            self.view.center = CGPointMake(originalCenter.x, originalCenter.y - 200);
        } completion:nil];
    }
    pickerCategory.hidden=true;
    pickerDate.hidden=true;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3f animations:^{
        [textField resignFirstResponder];
        self.view.center = originalCenter;
    }];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [UIView animateWithDuration:0.3f animations:^{
        [textField resignFirstResponder];
        self.view.center = originalCenter;
    }];
    [textField resignFirstResponder];
    return true;
}
@end
