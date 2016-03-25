//
//  MetadataView.h
//  nitoTV4
//
//  Created by Kevin Bradley on 3/16/16.
//  Copyright © 2016 nito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MetaDataAsset: NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *assetDescription;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) NSString *detailString;
@property (nonatomic, strong) NSArray *detailOptions;
@property (nonatomic, strong) NSDictionary *metaDictionary;


- (id)initWithDictionary:(NSDictionary *)dict;

@end

@interface MetadataLinesView: UIView
{
    float _lineHeight;	// 92 = 0x5c
    float _frameWidth;
}

@property (nonatomic, strong) NSArray *lineArray;
@property (nonatomic, strong) NSArray *values;
@property (nonatomic, strong) NSArray *labels;

- (id)initWithMetadata:(id)theMeta withLabels:(id)theLabels;
- (void)_layoutLines;
- (void)setMetadata:(id)metadata withLabels:(id)theLabels frameWidth:(float)width maxHeight:(float)height;
- (void)setMetadata:(MetaDataAsset *)metadata;
@end

@interface MetadataLineView: UIView
{
    float _maxLabelWidth;	// 92 = 0x5c
}

@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) UILabel *labelLayer;
@property (nonatomic, strong) UILabel *valueLayer;

- (id)initWithLabel:(id)label value:(id)value;

@end

@interface MetadataPreviewView : UIView

@property (nonatomic, strong) UIImage *coverArt;

@property (nonatomic, strong) NSString *defaultImageName;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *metaContainerView;

@property (nonatomic, strong) UIView *topDividerView;
@property (nonatomic, strong) UIView *middleDividerView;
@property (nonatomic, strong) UIView *bottomDividerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) MetadataLinesView *linesView;


@property (nonatomic, strong) UILabel *firstDetailLabel;
@property (nonatomic, strong) UILabel *secondDetailLabel;
@property (nonatomic, strong) UILabel *thirdDetailLabel;

@property (nonatomic, strong) UILabel *firstValueLabel;
@property (nonatomic, strong) UILabel *secondValueLabel;
@property (nonatomic, strong) UILabel *thirdValueLabel;

@property (nonatomic, strong) MetaDataAsset *metadataAsset;

- (id)initWithCoverArtNamed:(NSString *)coverArt;
- (id)initWithMetadata:(NSDictionary *)meta;
- (BOOL)hasMeta;
- (void)updateAsset:(MetaDataAsset *)asset;

@end
