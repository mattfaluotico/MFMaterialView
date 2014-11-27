//
//  MFMaterialView.h
//  MFMaterialView
//
//  Created by Matthew Faluotico on 11/18/14.
//  Copyright (c) 2014 mf. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kMFMGRadius;
extern NSString *const kMFMGDuration;
extern NSString *const kMFMGColor;
extern NSString *const kMFMGClipBounds;

@interface MFMaterialView : UIView


@property NSDictionary *options;

// kColor
// kRadius
// kDuration
// kFitToSuperView


- (id) initWithOptions: (NSDictionary *) options;

@end

