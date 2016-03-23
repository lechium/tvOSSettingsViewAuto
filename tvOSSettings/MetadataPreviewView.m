//
//  MetadataView.m
//  nitoTV4
//
//  Created by Kevin Bradley on 3/16/16.
//  Copyright © 2016 nito. All rights reserved.
//

#import "MetadataPreviewView.h"
#import "PureLayout.h"

@implementation MetadataLineView

- (id)initWithLabel:(id)label value:(id)value
{
    self = [super init];
    _labelLayer = [[UILabel alloc]initWithFrame:CGRectMake(4, 8, 798, 21)];
    [_labelLayer setFont:[UIFont boldSystemFontOfSize:17]];
    _labelLayer.textAlignment = NSTextAlignmentRight;
    _labelLayer.textColor = [UIColor grayColor];
    _valueLayer = [[UILabel alloc]initWithFrame:CGRectMake(93, 154, 705, 21)];
    
    return self;
}

@end

@implementation MetadataLinesView

@synthesize lineArray, values, labels;

- (void)_layoutLines
{
    
}

- (void)setMetadata:(id)metadata withLabels:(id)theLabels frameWidth:(float)width maxHeight:(float)height
{
    self.values = metadata;
    self.labels = theLabels;
    _frameWidth = width;
    _lineHeight = height / values.count;
    
}



@end

//self.metadataView = [[MetadataView alloc] initWithFrame:CGRectMake(100, 809, 806, 265)];

@interface MetadataPreviewView ()

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation MetadataPreviewView


- (void)_coverArtChanged:(id)changed {
    
}

- (BOOL)hasMeta
{
    if ([[self.metadataDict allKeys] count] > 1)
    {
        return true;
    }
    return false;
}

- (CGRect)_frameForArt:(id)art inBounds:(CGSize)bounds
{
    CGRect viewBounds = self.bounds;
    CGRect artRect = CGRectZero;
    if (self.hasMeta)
    {
        
    } else {
        
    }
    
    return artRect;
}
- (CGRect)_frameForArt:(id)art withMetadataFrame:(CGRect)metadataFrame inBounds:(CGSize)bounds
{
    return CGRectZero;
}
- (CGRect)_metadataFrameForBounds:(CGSize)bounds
{
    return CGRectZero;
}

- (id)initWithCoverArtNamed:(NSString *)coverArt
{
     LOG_SELF;
    self = [self initForAutoLayout];
    self.coverArt = [UIImage imageNamed:coverArt];
    self.imageView.image = self.coverArt;
    return self;
}


- (id)initWithMetadata:(NSDictionary *)meta
{
     LOG_SELF;
    self = [self initForAutoLayout];
    self.metadataDict = meta;
    return self;
}

- (id)initForAutoLayout
{
    LOG_SELF;
    self = [super initForAutoLayout];
    [self addSubview:self.imageView];
   // [self addSubview:self.topDividerView];
    //[self addSubview:self.middleDividerView];
    //[self addSubview:self.titleLabel];
    //[self addSubview:self.descriptionLabel];
    //[self updateConstraintsIfNeeded];
    return self;
}

- (UIView *)topDividerView
{
    if (!_topDividerView) {
        _topDividerView = [UIView newAutoLayoutView];
        _topDividerView.backgroundColor = [UIColor darkGrayColor];
    }
    return _topDividerView;
}


- (UIView *)middleDividerView
{
    if (!_middleDividerView) {
        _middleDividerView = [UIView newAutoLayoutView];
        _middleDividerView.backgroundColor = [UIColor darkGrayColor];
    }
    return _middleDividerView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel newAutoLayoutView];
        _titleLabel.font = [UIFont fontWithName:@".SFUIDisplay-Medium" size:57.00];
        _titleLabel.textColor = [UIColor grayColor];
    }
    return _titleLabel;
}

- (UILabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        _descriptionLabel = [UILabel newAutoLayoutView];
        _descriptionLabel.font = [UIFont fontWithName:@".SFUIDisplay-Medium" size:57.00];
        _descriptionLabel.textColor = [UIColor grayColor];
        _descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _titleLabel;
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


 /*
 Metadata view = 224, 809, 512, 265
 Title view = (UIlabel) 4, 8, 504, 21 (System Bold 17)
 LineView = (uiview black bg) 0, 37, 512, 1
 Desc view = (UILabel) 4, 52, 504, 50
 LineView = 0, 117, 512, 1
 Label1 = 8, 133, 68, 21 (textAlignment right)
 Value1 = 93, 133, 411, 21
 Label2 = 8, 154, 68, 21
 Value2 = 93, 154, 411, 21
 Label3 = 8, 175, 68, 21
 Value3 = 93, 175, 411, 21
 Last Line = 0, 207, 512, 1
 
 */

/*

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(4, 8, 798, 21)];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    self.topDividerView = [[UIView alloc] initWithFrame:CGRectMake(0, 37, 806, 1)];
    self.topDividerView.backgroundColor = [UIColor darkGrayColor];
    self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, 52, 798, 50)];
    self.descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.middleDividerView = [[UIView alloc] initWithFrame:CGRectMake(0, 117, 806, 1)];
    self.middleDividerView.backgroundColor = [UIColor darkGrayColor];
    self.firstDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 133, 68, 21)];
    self.firstDetailLabel.textAlignment = NSTextAlignmentRight;
    self.firstDetailLabel.textColor = [UIColor grayColor];
    self.firstValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(93, 133, 705, 21)];
    
    self.secondDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 154, 68, 21)];
    self.secondDetailLabel.textAlignment = NSTextAlignmentRight;
    self.secondDetailLabel.textColor = [UIColor grayColor];
    self.secondValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(93, 154, 705, 21)];
    
    self.thirdDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 175, 68, 21)];
    self.thirdDetailLabel.textAlignment = NSTextAlignmentRight;
    self.thirdDetailLabel.textColor = [UIColor grayColor];
    self.thirdValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(93, 175, 705, 21)];
    
    self.bottomDividerView = [[UIView alloc] initWithFrame:CGRectMake(0, 207, 806, 1)];
    self.bottomDividerView.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:self.titleLabel];
    [self addSubview:self.topDividerView];
    [self addSubview:self.descriptionLabel];
    [self addSubview:self.middleDividerView];
    [self addSubview:self.firstDetailLabel];
    [self addSubview:self.secondDetailLabel];
    [self addSubview:self.thirdDetailLabel];
    [self addSubview:self.firstValueLabel];
    [self addSubview:self.secondValueLabel];
    [self addSubview:self.thirdValueLabel];
    [self addSubview:self.bottomDividerView];

    return self;
}
*/
- (void)updateConstraints
{
    LOG_SELF;
//    NSString *recursiveDesc = [self performSelector:@selector(recursiveDescription)];
  //  NSLog(@"%@", recursiveDesc);
    if (!self.didSetupConstraints)
    {
        [self.imageView autoSetDimensionsToSize:CGSizeMake(512, 512)];
        if (!self.hasMeta)
        {
            [self.imageView autoCenterInSuperview];
        }
        self.didSetupConstraints = true;
        
    }
 //   [NSLayoutConstraint deactivateConstraints:self.constraints];
    [super updateConstraints];
}

- (void)updateMeta:(NSDictionary *)meta
{
   // NSLog(@"meta: %@", meta);
   
    self.metadataDict = meta;
    NSString *title = meta[@"Name"];
    if (title.length == 0) title = meta[@"Package"];
    if (title.length == 0) title = meta[@"Origin"];
    if (title.length == 0) title = meta[@"SourceDomain"];
    NSString *author = meta[@"Author"];
    if (author.length == 0) author = meta[@"Maintainer"];
    
    self.titleLabel.text = title;
    self.descriptionLabel.text = meta[@"Description"];
    self.firstDetailLabel.text = @"Version:";
    self.firstValueLabel.text = meta[@"Version"];
    
    if ([[meta allKeys] containsObject:@"SourceDomain"])
    {
        self.secondDetailLabel.text = @"Suite:";
        self.secondValueLabel.text = meta[@"Suite"];
        self.thirdDetailLabel.text = @"Domain:";
        self.thirdValueLabel.text = meta[@"SourceDomain"];
        
    } else {
        self.secondDetailLabel.text = @"Author:";
        self.secondValueLabel.text = author;
        self.thirdDetailLabel.text = @"Section:";
        self.thirdValueLabel.text = meta[@"Section"];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
