//
//  ViewController.h
//  tvOSSettings
//
//  Created by Kevin Bradley on 3/18/16.
//  Copyright © 2016 nito. All rights reserved.
//

#import "UIColor+Additions.h"
#import "MetadataPreviewView.h"

#import <UIKit/UIKit.h>

@interface SettingsTableViewCell : UITableViewCell
{
    UIColor *unfocusedBackgroundColor;

}


@end

@interface DetailView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) MetadataPreviewView *previewView;

@end

@interface SettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
        NSString *_backingTitle;
}
@property (nonatomic, strong) NSArray *itemNames;
@property (nonatomic, strong) NSArray *detailNames;
@property (nonatomic, strong) NSArray *imageNames;
@property (nonatomic, strong) UIColor *titleColor;

@end

