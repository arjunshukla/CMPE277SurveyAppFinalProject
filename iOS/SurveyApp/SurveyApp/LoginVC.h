//
//  LoginVC.h
//  SurveyApp
//
//  Created by Arjun Shukla on 4/30/15.
//  Copyright (c) 2015 CMPE277. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController<NSURLConnectionDelegate,UITextFieldDelegate>
{
    NSURLConnection *currentConnection;
}
- (IBAction)SegmentSwitch:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLoginSignup;
@property (weak, nonatomic) IBOutlet UITextField *txtRePassword;
@property (retain, nonatomic) NSMutableData *apiReturn;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentOutlet;
@property (weak, nonatomic) IBOutlet UILabel *lblRePassword;
- (IBAction)onLoginBtnTap:(id)sender;
@end
