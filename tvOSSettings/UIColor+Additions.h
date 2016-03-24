
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SQFContrastingColorMethod) {
    SQFContrastingColorFiftyPercentMethod,
    SQFContrastingColorYIQMethod
};

@interface UIColor (Additions)
+ (UIColor *)lightBlueColor;
- (UIColor*)changeBrightnessByAmount:(CGFloat)amount;
+ (UIColor*)changeBrightness:(UIColor*)color amount:(CGFloat)amount;
- (NSString *)hexValue;
+ (UIColor *)colorFromHex:(NSString *)s;
- (UIColor *)sqf_contrastingColorWithMethod:(SQFContrastingColorMethod)method;
@end

@interface UIView (Additions)

- (void)removeAllSubviews;
- (void)printRecursiveDescription;
@end