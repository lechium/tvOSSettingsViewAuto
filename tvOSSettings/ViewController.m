//
//  ViewController.m
//  tvOSSettings
//
//  Created by Kevin Bradley on 3/18/16.
//  Copyright © 2016 nito. All rights reserved.
//

#import "ViewController.h"
#import "PureLayout.h"

@implementation SettingsTableViewCell

@synthesize viewBackgroundColor, selectionColor;

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.selectionColor == nil)
        self.selectionColor = [UIColor whiteColor];
    
    if (self.viewBackgroundColor == nil)
        self.viewBackgroundColor = self.contentView.backgroundColor;
}

- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator
{
    [super didUpdateFocusInContext:context withAnimationCoordinator:coordinator];
    if (context.nextFocusedView == self)
    {
        [coordinator addCoordinatedAnimations:^{
            // self.backgroundColor = [UIColor darkGrayColor];
            self.contentView.backgroundColor = self.selectionColor;
            
            //NSLog(@"superview: %@",  self.superview.superview.superview.superview.superview.superview);
        } completion:^{
            //
        }];
        
    } else {
        [coordinator addCoordinatedAnimations:^{
            //self.backgroundColor = [UIColor blackColor];
            self.contentView.backgroundColor = self.viewBackgroundColor;
        } completion:^{
            //
        }];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

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


@interface ViewController ()

@property (nonatomic, strong) DetailView *detailView;
@property (nonatomic, strong) UIView *tableWrapper;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, strong) UILabel *titleView;


@end

@implementation ViewController

- (void)loadView
{
    self.view = [UIView new];
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.detailView];
    [self.view addSubview:self.tableWrapper];
    [self.view addSubview:self.titleView];
    
    //self.title = @"Settings";
    
    
    [self.view setNeedsUpdateConstraints]; // bootstrap Auto Layout
}

- (void)updateViewConstraints
{
    CGRect viewBounds = self.view.bounds;
    if (!self.didSetupConstraints) {
        
        [self.detailView autoSetDimensionsToSize:CGSizeMake(viewBounds.size.width/2, viewBounds.size.height)];
        [self.detailView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view];
        
        [self.tableWrapper autoSetDimensionsToSize:CGSizeMake(viewBounds.size.width/2, viewBounds.size.height)];
        [self.tableWrapper autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view];
        
        [self.tableView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.tableWrapper withOffset:50];
        [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:50];
        [self.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.tableWrapper withOffset:180];
        [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:50];
        
        [self.detailView.imageView autoSetDimensionsToSize:CGSizeMake(512, 512)];
        [self.detailView.imageView autoCenterInSuperview];
        
        [self.titleView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:56];
        [self.titleView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
        self.didSetupConstraints = YES;
    }
    
    [super updateViewConstraints];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.titleView.text = self.title;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

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
         [self.tableView registerClass:[SettingsTableViewCell class] forCellReuseIdentifier:@"Science"];
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableWrapper addSubview:_tableView];
        _tableWrapper.backgroundColor = [UIColor clearColor];
    }
    return _tableWrapper;
}

- (UIView *)detailView
{
    if (!_detailView) {
        _detailView = [[DetailView alloc] initForAutoLayout];
        _detailView.backgroundColor = [UIColor clearColor];
    }
    return _detailView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


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
    SettingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Science"forIndexPath:indexPath];
    
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.itemNames[indexPath.row];
    cell.viewBackgroundColor = self.view.backgroundColor;
    if (self.view.backgroundColor == [UIColor blackColor])
    {
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.selectionColor = [UIColor darkGrayColor];
    }
    
    return cell;
}

@end
