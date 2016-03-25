//
//  ViewController.h
//  tvOSSettings
//
//  Created by Kevin Bradley on 3/18/16.
//  Copyright © 2016 nito. All rights reserved.
//

/**

 This is a rough attempt at creating a highly customizable list / settings view on tvOS, an attempt to recreate BRMediaMenuControllers and BRMetadataControls from the older generation AppleTV's. Full disclosure my AutoLayout skills are still very fresh so I'm certain I'm doing some things wrong. And there is DEFINITELY a lot of ambiguous layout so this view hierarchy is incredible fragile and if the meta information isn't set EXACTLY how its done currently, everything falls apart.
 
 That being said whenever the meta is set here its good to keep a consistent number of keys, for the extended meta dictionary and the description / name values.
 
 Check MetadataPreviewView.h for more information on the formatting of the metadata dictionary / asset.
 
 NOTE: for now its not a good idea to change the backgroundColor because the metadata view doesnt take that into 
 account for the text colors for labels, name and description.
 
 the unfocusedBackgroundColor code is based on code taken from this gist
 
 https://gist.github.com/mhpavl/f7819743027684b9e890
 

 
 */

#import "TVSettings+Additions.h"
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

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, strong) UIColor *titleColor;

@end

