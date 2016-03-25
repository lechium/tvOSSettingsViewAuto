//
//  MetadataView.m
//  nitoTV4
//
//  Created by Kevin Bradley on 3/16/16.
//  Copyright © 2016 nito. All rights reserved.
//

#import "MetadataPreviewView.h"
#import "PureLayout.h"
#import "UIColor+Additions.h"
#import "UIImageView+WebCache.h"

@interface UIWindow (AutoLayoutDebug)
+ (UIWindow *)keyWindow;
- (NSString *)_autolayoutTrace;
@end


@implementation MetadataLineView

@synthesize value, label;

- (id)initForAutoLayout
{
    self = [super initForAutoLayout];
    [self addSubview:[self labelLayer]];
    [self addSubview:[self valueLayer]];
    return self;
}

- (id)initWithLabel:(id)theLabel value:(id)theValue
{
    self = [self initForAutoLayout];
   
    self.label = theLabel;
    self.value = theValue;

 
    [self.labelLayer setText:theLabel];
    [self.valueLayer setText:theValue];
    return self;
}

- (void)updateConstraints
{
    //CGRectMake(4, 8, 798, 21) label
    //CGRectMake(93, 154, 705, 21)
    [NSLayoutConstraint deactivateConstraints:self.constraints];
    
 //   [self autoCenterInSuperview];
    [self.labelLayer autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:95];
    [self.labelLayer autoSetDimensionsToSize:CGSizeMake(68, 21)];
    [self.valueLayer autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.labelLayer withOffset:21];
    //[self autoPinEdgesToSuperviewEdges];
    [self.valueLayer autoSetDimensionsToSize:CGSizeMake(705, 21)];
    [super updateConstraints];
}

- (UILabel *)labelLayer
{
    if (!_labelLayer)
    {
        _labelLayer = [[UILabel alloc] initForAutoLayout];
        [_labelLayer setFont:[UIFont boldSystemFontOfSize:17]];
        _labelLayer.textAlignment = NSTextAlignmentRight;
        _labelLayer.textColor = [UIColor grayColor];
    }
    return _labelLayer;
}


- (UILabel *)valueLayer
{
    if (!_valueLayer)
    {
        _valueLayer = [[UILabel alloc] initForAutoLayout];
    }
    return _valueLayer;
}


@end

@implementation MetadataLinesView

@synthesize lineArray, values, labels;

- (void)layoutSubviews
{
    [super layoutSubviews];
    //CGFloat startingY = self.superview.frame.origin.y + self.superview.subviews.lastObject.frame.origin.y + 25;
    CGFloat startingY = 10;
    NSInteger currentIndex = 0;
    for (MetadataLineView *lineView in self.subviews)
    {
        CGRect currentFrame = [lineView frame];
        //currentFrame.origin.x = 4;
        currentFrame.origin.y = startingY;
        [lineView setFrame:currentFrame];
        startingY+=21;
        currentIndex++;
        if (currentIndex == self.subviews.count-1)
        {
            startingY+=15;
        }
    }
    //[self printRecursiveDescription];
}

- (id)initWithMetadata:(id)theMeta withLabels:(id)theLabels
{
    
    self = [super initForAutoLayout];
    self.values = theMeta;
    self.labels = theLabels;
    [self _layoutLines];
    return self;
}

- (void)_layoutLines
{
    [self removeAllSubviews];
    
    int i = 0;
    for (NSString *label in labels)
    {
        MetadataLineView *line = [[MetadataLineView alloc] initWithLabel:label value:values[i]];
        [self addSubview:line];
        i++;
    }
    UIView *theView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 1)];
    [theView setBackgroundColor:[UIColor darkGrayColor]];
    [self addSubview:theView];
    
}

- (void)setMetadata:(id)metadata withLabels:(id)theLabels frameWidth:(float)width maxHeight:(float)height
{
    self.values = metadata;
    self.labels = theLabels;
    _frameWidth = width;
    _lineHeight = height / values.count;
    [self _layoutLines];
   // [self updateConstraintsIfNeeded];
}
//
//- (void)updateConstraints
//{
//    
//    //[NSLayoutConstraint deactivateConstraints:self.constraints];
//    [super updateConstraints];
//    
//   /*
//    for (MetadataLineView *lineView in lineArray)
//    {
//        //CGRectMake(4, 8, 798, 21) label
//        //CGRectMake(93, 154, 705, 21)
//    }
//    */
//    
//}


@end

//self.metadataView = [[MetadataView alloc] initWithFrame:CGRectMake(100, 809, 806, 265)];

@interface MetadataPreviewView ()

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation MetadataPreviewView

@synthesize metadataDict;


- (BOOL)hasMeta
{
    if ([[self.metadataDict allKeys] count] > 0)
    {
        return true;
    }
    return false;
}

- (id)initWithCoverArtNamed:(NSString *)coverArt
{
    self = [self initForAutoLayout];
    self.coverArt = [UIImage imageNamed:coverArt];
    self.imageView.image = self.coverArt;
    return self;
}


- (id)initWithMetadata:(NSDictionary *)meta
{
    self = [self initForAutoLayout];
    metadataDict = meta;
    NSString *coverArt = meta[@"coverart"];
    self.coverArt = [UIImage imageNamed:coverArt];
    return self;
}

- (id)initForAutoLayout
{
     
    self = [super initForAutoLayout];
    [self addSubview:self.imageView];
    [self addSubview:self.metaContainerView];
    //[self updateConstraintsIfNeeded];
    return self;
}


- (MetadataLinesView *)linesView
{
    
    if (!_linesView)
    {
        if (self.metadataDict != nil)
        {
        _linesView = [[MetadataLinesView alloc] initWithMetadata:self.metadataDict[@"Values"] withLabels:self.metadataDict[@"Labels"]];
            
        } else {
            
            _linesView = [[MetadataLinesView alloc] initForAutoLayout];
            
        }
       // _linesView.backgroundColor = [UIColor redColor];
        _linesView.autoresizesSubviews = true;
    }
    return _linesView;
}

- (UIView *)metaContainerView
{
    if (!_metaContainerView)
    {
        _metaContainerView = [UIView newAutoLayoutView];
        [_metaContainerView addSubview:self.topDividerView];
        [_metaContainerView addSubview:self.middleDividerView];
        [_metaContainerView addSubview:self.titleLabel];
        [_metaContainerView addSubview:self.descriptionLabel];
        [_metaContainerView addSubview:self.linesView];
        //[_metaContainerView addSubview:self.bottomDividerView];
        
    }
    return _metaContainerView;
}

- (UIView *)topDividerView
{
    if (!_topDividerView) {
        _topDividerView = [UIView newAutoLayoutView];
        _topDividerView.backgroundColor = [UIColor darkGrayColor];
    }
    return _topDividerView;
}

- (UIView *)bottomDividerView
{
    if (!_bottomDividerView) {
        _bottomDividerView = [UIView newAutoLayoutView];
        _bottomDividerView.backgroundColor = [UIColor redColor];
    }
    return _bottomDividerView;
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
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
    }
    return _titleLabel;
}

- (UILabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        _descriptionLabel = [UILabel newAutoLayoutView];
        _descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _descriptionLabel.numberOfLines = 0;
    }
    return _descriptionLabel;
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

- (void)layoutSubviews
{
    [super layoutSubviews];
   // NSString *recursiveDesc = [self performSelector:@selector(recursiveDescription)];
    //NSLog(@"%@", recursiveDesc);
    
    //NSString *autolayoutTrace = [[UIWindow keyWindow] _autolayoutTrace];
    //NSLog(@"alt: %@", autolayoutTrace);
}



- (void)updateConstraints
{
    [NSLayoutConstraint deactivateConstraints:self.constraints];
    
   // if (!self.didSetupConstraints)
    //{
        [self.imageView autoSetDimensionsToSize:CGSizeMake(512, 512)];
        if (!self.hasMeta)
        {
            [self.imageView autoCenterInSuperview];
        } else {
            [self.imageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
            [self.imageView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.superview withOffset:264];
            [self.metaContainerView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.imageView withOffset:10];
            [self.metaContainerView autoSetDimensionsToSize:CGSizeMake(806, 265)];
            [self.metaContainerView autoAlignAxisToSuperviewAxis:ALAxisVertical];
     
            UIView *lineViewGuide = nil;
            
            [self.titleLabel autoSetDimensionsToSize:CGSizeMake(504, 21)];
            [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:4];
            [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:8];
            
            self.titleLabel.text = self.metadataDict[@"Name"];
            
            [self.topDividerView autoSetDimensionsToSize:CGSizeMake(806, 1)];
            [self.topDividerView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
            [self.topDividerView autoPinEdgeToSuperviewEdge:ALEdgeRight];
            [self.topDividerView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLabel withOffset:8];
         if ([self.metadataDict[@"Description"] length] > 0)
         {
            [self.descriptionLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:4];
            [self.descriptionLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.topDividerView withOffset:15];
            [self.descriptionLabel autoSetDimension:ALDimensionWidth toSize:798];
            self.descriptionLabel.text = self.metadataDict[@"Description"];
            
            [self.middleDividerView autoSetDimensionsToSize:CGSizeMake(806, 1)];
            [self.middleDividerView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
            [self.middleDividerView autoPinEdgeToSuperviewEdge:ALEdgeRight];
            [self.middleDividerView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.descriptionLabel withOffset:15];
            
            lineViewGuide = self.middleDividerView;
         } else {
             lineViewGuide = self.topDividerView;
         }
            
            //[self.linesView setClipsToBounds:true];
            //[self.linesView autoSetDimension:ALDimensionHeight toSize:150];
            [self.linesView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:lineViewGuide withOffset:5];
            [self.linesView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:4];
            [self.linesView autoAlignAxisToSuperviewAxis:ALAxisVertical];
            
            [self.linesView setMetadata:self.metadataDict[@"Values"] withLabels:self.metadataDict[@"Labels"] frameWidth:0 maxHeight:0];
            
           // [self.bottomDividerView autoSetDimensionsToSize:CGSizeMake(806, 1)];
            //[self.bottomDividerView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
            //[self.bottomDividerView autoPinEdgeToSuperviewEdge:ALEdgeRight];
            //[self.bottomDividerView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.linesView withOffset:0];
            
            
            
            
            
            
            
           // NSArray *subviews = self.linesView.subviews;
            /*
            int i = 0;
            MetadataLineView *previousView = nil;
            for (MetadataLineView *lineView in self.linesView.subviews)
            {
                if (i == 0)
                {
                    //[lineView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.middleDividerView withOffset:5];
                    [lineView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
                } else {
                    previousView = self.linesView.subviews[i-1];
                    NSLog(@"previousView: %@", previousView);
                    [lineView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:previousView withOffset:21];
                }
                i++;
            }
            */
            [self.linesView.subviews autoDistributeViewsAlongAxis:ALAxisVertical alignedTo:ALAttributeVertical withFixedSpacing:21 insetSpacing:NO matchedSizes:NO];
             [self.linesView autoAlignAxisToSuperviewAxis:ALAxisVertical];
           // [self.linesView.subviews autoDistributeViewsAlongAxis:ALAxisVertical alignedTo:ALAttributeVertical withFixedSpacing:10 insetSpacing:false];
            ;
            
           
            
        }
     //   self.didSetupConstraints = true;
        
   // }
 //   [NSLayoutConstraint deactivateConstraints:self.constraints];
    [super updateConstraints];
}

- (void)updateMeta:(NSDictionary *)meta
{
    self.metadataDict = meta;
    NSString *imagePath = meta[@"coverArt"];
    NSLog(@"imagePath: %@", imagePath);
    if (![imagePath containsString:@"http"] )
    {
    //    self.imageView.image = [UIImage imageNamed:self.defaultImageName];
    } else {
      //  [self.imageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:[UIImage imageNamed:self.defaultImageName] options:SDWebImageAllowInvalidSSLCertificates];
    }
    NSString *title = meta[@"Name"];
    if (title.length == 0) title = meta[@"Package"];
    if (title.length == 0) title = meta[@"Origin"];
    if (title.length == 0) title = meta[@"SourceDomain"];
    NSString *author = meta[@"Author"];
    if (author.length == 0) author = meta[@"Maintainer"];
    
    self.titleLabel.text = title;
    self.descriptionLabel.text = meta[@"Description"];
    [self.linesView setMetadata:self.metadataDict[@"Values"] withLabels:self.metadataDict[@"Labels"] frameWidth:0 maxHeight:0];
    [self updateConstraintsIfNeeded];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
