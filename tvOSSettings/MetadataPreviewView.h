//
//  MetadataView.h
//  nitoTV4
//
//  Created by Kevin Bradley on 3/16/16.
//  Copyright © 2016 nito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MetadataLinesView: UIView
{
    float _lineHeight;	// 92 = 0x5c
    float _frameWidth;
}

@property (nonatomic, strong) NSArray *lineArray;
@property (nonatomic, strong) NSArray *values;
@property (nonatomic, strong) NSArray *labels;

- (void)_layoutLines;
- (void)setMetadata:(id)metadata withLabels:(id)theLabels frameWidth:(float)width maxHeight:(float)height;

@end

@interface MetadataLineView: UIView
{
    UILabel *_labelLayer;	// 84 = 0x54
    UILabel *_valueLayer;	// 88 = 0x58
    float _maxLabelWidth;	// 92 = 0x5c
}

- (id)initWithLabel:(id)label value:(id)value;

@end

@interface MetadataPreviewView : UIView

@property (nonatomic, strong) UIImage *coverArt;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *topDividerView;
@property (nonatomic, strong) UIView *middleDividerView;
@property (nonatomic, strong) UIView *bottomDividerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *firstDetailLabel;
@property (nonatomic, strong) UILabel *secondDetailLabel;
@property (nonatomic, strong) UILabel *thirdDetailLabel;

@property (nonatomic, strong) UILabel *firstValueLabel;
@property (nonatomic, strong) UILabel *secondValueLabel;
@property (nonatomic, strong) UILabel *thirdValueLabel;

@property (nonatomic, strong) NSDictionary *metadataDict;

- (id)initWithCoverArtNamed:(NSString *)coverArt;
- (id)initWithMetadata:(NSDictionary *)meta;
- (BOOL)hasMeta;
- (void)updateMeta:(NSDictionary *)meta;
- (void)_coverArtChanged:(id)changed;	// 0x33a87d
- (CGRect)_frameForArt:(id)art inBounds:(CGSize)bounds;	// 0x33a93d
- (CGRect)_frameForArt:(id)art withMetadataFrame:(CGRect)metadataFrame inBounds:(CGSize)bounds;	// 0x33aa61
- (CGRect)_metadataFrameForBounds:(CGSize)bounds;
@end
