//
//  ViewController.m
//  tvOSSettings
//
//  Created by Kevin Bradley on 3/18/16.
//  Copyright © 2016 nito. All rights reserved.
//

#import "SettingsViewController.h"
#import "PureLayout.h"

/**
 
 An PureLayout based settings view for tvOS, this view is an attempt to mimick the setup of a settings view
 in tvOS as closely as possible.
 
 All of the classes used are contained in one file here to make things as easy as possible to use in 
 your own applications.
 
 the unfocusedBackgroundColor code is based on code taken from this gist
 
 https://gist.github.com/mhpavl/f7819743027684b9e890
 
 
 */
 

@implementation SettingsTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    unfocusedBackgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    self.contentView.backgroundColor = unfocusedBackgroundColor;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = true;
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.accessoryView.backgroundColor = unfocusedBackgroundColor;
    
    // NSString *recursiveDesc = [self performSelector:@selector(recursiveDescription)];
    // NSLog(@"%@", recursiveDesc);
}

- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator
{
    [super didUpdateFocusInContext:context withAnimationCoordinator:coordinator];
    
    [coordinator addCoordinatedAnimations:^{
    
         self.contentView.backgroundColor = self.focused ? [UIColor clearColor] : unfocusedBackgroundColor;
         self.accessoryView.backgroundColor = self.focused ? [UIColor clearColor] : unfocusedBackgroundColor;
         self.layer.masksToBounds = !self.focused;
        
    } completion:^{
        
    }];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

/**
 
 The detail view that contains the centered UIImageView on the left hand side
 
 */

@implementation DetailView

- (id)initForAutoLayout
{
    self = [super initForAutoLayout];
    
    [self addSubview:self.imageView];
    return self;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [UIImageView newAutoLayoutView];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.image = [UIImage imageNamed:@"package"];
    }
    return _imageView;
}


@end


@interface SettingsViewController ()

@property (nonatomic, strong) DetailView *detailView;
@property (nonatomic, strong) UIView *tableWrapper;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, strong) UILabel *titleView;


@end

@implementation SettingsViewController

- (void)loadView
{
    self.view = [UIView new];
    
    [self.view addSubview:self.detailView];
    [self.view addSubview:self.tableWrapper];
    [self.view addSubview:self.titleView];
    
    //self.title = @"Settings";
    
    
    [self.view setNeedsUpdateConstraints]; // bootstrap Auto Layout
}

- (void)updateViewConstraints
{
    CGRect viewBounds = self.view.bounds;
    
    //use this variable to keep track of whether or not initial constraints were already set up
    //dont want to do it more than once
    if (!self.didSetupConstraints) {
        
        //half the size of our total view / pinned to the left
        [self.detailView autoSetDimensionsToSize:CGSizeMake(viewBounds.size.width/2, viewBounds.size.height)];
        [self.detailView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view];
        
        //half the size of our total view / pinned to the right
        
        [self.tableWrapper autoSetDimensionsToSize:CGSizeMake(viewBounds.size.width/2, viewBounds.size.height)];
        [self.tableWrapper autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view];
        
        //position the tableview inside its wrapper view
        
        [self.tableView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.tableWrapper withOffset:50];
        [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:80];
        [self.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.tableWrapper withOffset:180];
        [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:50];
        
        //set the size of the imageView and center it
        
        [self.detailView.imageView autoSetDimensionsToSize:CGSizeMake(512, 512)];
        [self.detailView.imageView autoCenterInSuperview];
        
        //set up our title view
        
        [self.titleView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:56];
        [self.titleView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateViewConstraints];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.titleView.text = _backingTitle;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

//its necessary to create a title view in case you are the first view inside a navigation controller
//which doesnt show a title view for the root controller iirc
- (UILabel *)titleView
{
    if (!_titleView) {
        _titleView = [UILabel newAutoLayoutView];
        _titleView.font = [UIFont fontWithName:@".SFUIDisplay-Medium" size:57.00];
        _titleView.textColor = [UIColor grayColor];
    }
    return _titleView;
}

- (UIView *)tableWrapper;
{
    if (!_tableWrapper) {
        _tableWrapper = [UIView newAutoLayoutView];
        _tableWrapper.autoresizesSubviews = true;
        _tableView = [[UITableView alloc] initForAutoLayout];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.tableView registerClass:[SettingsTableViewCell class] forCellReuseIdentifier:@"SettingsCell"];
        _tableView.backgroundColor = self.view.backgroundColor;
        [_tableWrapper addSubview:_tableView];
        _tableWrapper.backgroundColor = self.view.backgroundColor;
    }
    return _tableWrapper;
}

- (UIView *)detailView
{
    if (!_detailView) {
        _detailView = [[DetailView alloc] initForAutoLayout];
        _detailView.backgroundColor = self.view.backgroundColor;
    }
    return _detailView;
}

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
    id newValue = change[@"new"];
    
    //a bit of a hack to hide the navigationItem title view when title is set
    //and to use our own titleView that can have different colors
    
    if ([keyPath isEqualToString:@"title"])
    {
        if (newValue != [NSNull null])
        {
            if ([newValue length] > 0)
            {
                //keep a backup copy of the title
                _backingTitle = newValue;
                self.titleView.text = newValue;
                self.title = @"";
            }
        }
    }
    
    //change subviews to have the same background color
    if ([keyPath isEqualToString:@"backgroundColor"])
    {
        self.detailView.backgroundColor = newValue;
        self.tableWrapper.backgroundColor = newValue;
        self.tableView.backgroundColor = newValue;
    }
    
    //change titleView to a different text color
    
    if ([keyPath isEqualToString:@"titleColor"])
    {
        self.titleView.textColor = newValue;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //use KVO to update subview backgroundColor to mimic the superview backgroundColor
    
    [self.view addObserver:self
                forKeyPath:@"backgroundColor"
                   options:NSKeyValueObservingOptionNew
                   context:NULL];
    
    //use KVO to allow different colors for the title
    
    [self addObserver:self
           forKeyPath:@"titleColor"
              options:NSKeyValueObservingOptionNew
              context:NULL];
    
    //use KVO to monitor changes to title, this is necessary to keep backing of title,
    //set to nil and then set the title of our titleView
    
    [self addObserver:self
           forKeyPath:@"title"
              options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionOld
              context:NULL];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

//keep track of cells being focused so we can change the contents of the DetailView

- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator
{
    [self focusedCell:(SettingsTableViewCell*)context.nextFocusedView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.itemNames.count;
}

- (void)focusedCell:(SettingsTableViewCell *)focusedCell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:focusedCell];
    NSString *imageName = self.imageNames[indexPath.row];
    self.detailView.imageView.image = [UIImage imageNamed:imageName];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingsCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.itemNames[indexPath.row];
    cell.detailTextLabel.text = self.detailNames[indexPath.row];
    
    /*
     
     This is a terrible hack, but without doing this I couldn't figure out a way to make the built in accessory
     types to play nicely with the unfocused background colors to mimic the settings table view style
     
     it also creates an issue where the size of the cell when focused is all out of whack. not really
     sure how to accomodate that...
     
     */
    
    UIView *accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 66)];
    UIButton *accessoryButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 16.5, 20, 33)];
    [accessoryButton setImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
    [accessoryView addSubview:accessoryButton];
    cell.accessoryView = accessoryView;
    // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

@end
