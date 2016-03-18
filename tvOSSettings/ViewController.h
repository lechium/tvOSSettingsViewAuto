//
//  ViewController.h
//  tvOSSettings
//
//  Created by Kevin Bradley on 3/18/16.
//  Copyright © 2016 nito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsTableViewCell : UITableViewCell

@property (nonatomic, strong) UIColor *selectionColor;
@property (nonatomic, strong) UIColor *viewBackgroundColor;

@end

@interface DetailView : UIView

@property (nonatomic, strong) UIImageView *imageView;

@end

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *itemNames;
@property (nonatomic, strong) NSArray *imageNames;


@end

