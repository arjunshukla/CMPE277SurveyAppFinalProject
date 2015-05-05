//
//  FirstViewController.h
//  SurveyApp
//
//  Created by Arjun Shukla on 4/28/15.
//  Copyright (c) 2015 CMPE277. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatePollVC : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtPollName;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerCategory;
@property (weak, nonatomic) IBOutlet UITextField *txtCategory;
@property (weak, nonatomic) IBOutlet UITextView *txtQuestion;
@property (weak, nonatomic) IBOutlet UITextField *txtStartDate;
@property (weak, nonatomic) IBOutlet UITextField *txtExpiryDate;
@property (weak, nonatomic) IBOutlet UITextField *txtFirstOption;
@property (weak, nonatomic) IBOutlet UITextField *txtSecondOption;
@property (weak, nonatomic) IBOutlet UIDatePicker *pickerDate;
@property (weak, nonatomic) IBOutlet UITextField *txtThirdOption;
@property (weak, nonatomic) IBOutlet UITextField *txtFourthOption;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *viewVisual;

- (IBAction)onCategoryTap:(id)sender;
- (IBAction)onCreateBtnTap:(id)sender;
- (IBAction)onStartDateTap:(id)sender;
- (IBAction)onEndDateTap:(id)sender;

@end