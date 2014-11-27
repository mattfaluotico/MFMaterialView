//
//  ViewController.h
//  MFMaterialView
//
//  Created by Matthew Faluotico on 11/18/14.
//  Copyright (c) 2014 mf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *seg;
@property (weak, nonatomic) IBOutlet UISwitch *s;
@property (weak, nonatomic) IBOutlet UIButton *b;
@property (weak, nonatomic) IBOutlet UIStepper *step;
@property (weak, nonatomic) IBOutlet UITextField *thing;

@end

