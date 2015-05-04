//
//  VoteForSelectedPollVC.h
//  SurveyApp
//
//  Created by Arjun Shukla on 5/3/15.
//  Copyright (c) 2015 CMPE277. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VoteForSelectedPollVC : UIViewController<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;
@property (weak, nonatomic) IBOutlet UILabel *lblQuestion;
@property (weak, nonatomic) IBOutlet UILabel *lblStartDate;
@property (weak, nonatomic) IBOutlet UILabel *lblExpiryDate;
@property (weak, nonatomic) IBOutlet UILabel *lblChoice1;
@property (weak, nonatomic) IBOutlet UILabel *lblChoice2;
@property (weak, nonatomic) IBOutlet UILabel *lblChoice3;
@property (weak, nonatomic) IBOutlet UILabel *lblChoice4;
- (IBAction)onChoosingOption:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnChoice1;
@property (weak, nonatomic) IBOutlet UIButton *btnChoice2;
@property (weak, nonatomic) IBOutlet UIButton *btnChoice3;
@property (weak, nonatomic) IBOutlet UIButton *btnChoice4;
@end