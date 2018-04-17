//
//  WPDrowAnimationLayer.m
//  逐字展现文字
//
//  Created by rexsu on 2017/3/6.
//  Copyright © 2017年 Winny. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>
#import "WPDrowAnimationLayer.h"

@interface WPDrowAnimationLayer ()
@property (nonatomic, retain) CAShapeLayer *pathLayer;
@property (nonatomic, retain) CAShapeLayer *heartpPathLayer;
@property (nonatomic, retain) CALayer *penLayer;

@end

@implementation WPDrowAnimationLayer

+(void)createAnimationLayerWithString:(NSString *)string rect:(CGRect)rect view:(UIView *)view font:(UIFont *)font duretion:(NSInteger)duration
{
    WPDrowAnimationLayer * animationLayer = [WPDrowAnimationLayer layer];
    animationLayer.frame = rect;
    [view.layer addSublayer:animationLayer];
    
    if (animationLayer.pathLayer != nil) {
        [animationLayer.penLayer removeFromSuperlayer];
        [animationLayer.pathLayer removeFromSuperlayer];
        [animationLayer.heartpPathLayer removeFromSuperlayer];
        animationLayer.heartpPathLayer = nil;
        animationLayer.pathLayer = nil;
        animationLayer.penLayer = nil;
    }
    CTFontRef ctFont =CTFontCreateWithName((CFStringRef)font.fontName,
                                         font.pointSize,
                                         NULL);
    CGMutablePathRef letters = CGPathCreateMutable();
    
    //这里设置画线的字体和大小
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           (__bridge id)ctFont, kCTFontAttributeName,
                           nil];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string
                                                                     attributes:attrs];
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attrString);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    
    
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++)
    {
        
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        
        
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++)
        {
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            
            {
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                CGPathAddPath(letters, &t, letter);
                CGPathRelease(letter);
            }
        }
    }
    CFRelease(line);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:letters]];
    
    CGPathRelease(letters);
    CFRelease(ctFont);
    
    
    
    //
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height -230);
    pathLayer.bounds = CGPathGetBoundingBox(path.CGPath);
    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [[UIColor colorWithRed:247/255.0 green:165/255.0 blue:195/255.0 alpha:1] CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 1.0f;
    pathLayer.lineJoin = kCALineJoinBevel;
    [animationLayer addSublayer:pathLayer];
    animationLayer.pathLayer = pathLayer;
    
    UIImage *penImage = [UIImage imageNamed:@"noun_project_347_2.png"];
    CALayer *penLayer = [CALayer layer];
    
    penLayer.contents = (id)penImage.CGImage;
    penLayer.anchorPoint = CGPointZero;
    penLayer.frame = CGRectMake(0.0f, 0.0f, penImage.size.width, penImage.size.height);
    [pathLayer addSublayer:penLayer];
    animationLayer.penLayer = penLayer;
    
    [animationLayer.pathLayer removeAllAnimations];
    [animationLayer.penLayer removeAllAnimations];
    
    animationLayer.penLayer.hidden = NO;
    
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = duration;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [animationLayer.pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
}

- (void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.penLayer.hidden = YES;
}

@end
