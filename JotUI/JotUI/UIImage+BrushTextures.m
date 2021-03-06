//
//  UIImage+BrushTextures.m
//  JotUI
//
//  Created by Adam Wulf on 2/29/16.
//  Copyright © 2016 Milestone Made. All rights reserved.
//

#import "UIImage+BrushTextures.h"


@implementation UIImage (BrushTextures)

static UIImage* circleBrush;

+ (UIImage*)circleBrushTexture {
    if (!circleBrush) {
        UIGraphicsBeginImageContext(CGSizeMake(64, 64));
        CGContextRef defBrushTextureContext = UIGraphicsGetCurrentContext();
        UIGraphicsPushContext(defBrushTextureContext);

        size_t num_locations = 3;
        CGFloat locations[3] = {0.0, 0.2, 1.0};
        CGFloat components[12] = {1.0, 1.0, 1.0, 1.0,
                                  1.0, 1.0, 1.0, 1.0,
                                  1.0, 1.0, 1.0, 0.0};
        CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef myGradient = CGGradientCreateWithColorComponents(myColorspace, components, locations, num_locations);

        CGPoint myCentrePoint = CGPointMake(32, 32);
        float myRadius = 30;

        CGContextDrawRadialGradient(UIGraphicsGetCurrentContext(), myGradient, myCentrePoint,
                                    0, myCentrePoint, myRadius,
                                    kCGGradientDrawsAfterEndLocation);

        CGGradientRelease(myGradient);
        CGColorSpaceRelease(myColorspace);

        UIGraphicsPopContext();

        circleBrush = UIGraphicsGetImageFromCurrentImageContext();

        UIGraphicsEndImageContext();
    }

    return circleBrush;
}


static UIImage* squareBrush;

+ (UIImage*)squareBrushTexture {
    if (!squareBrush) {
        UIGraphicsBeginImageContext(CGSizeMake(64, 64));
        CGContextRef defBrushTextureContext = UIGraphicsGetCurrentContext();
        UIGraphicsPushContext(defBrushTextureContext);
        
        size_t num_locations = 2;
        CGFloat locations[3] = {0.0, 0.8, 1.0};
        CGFloat components[12] = {1.0, 1.0, 1.0, 1.0,
            1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0};
       // CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
       // CGGradientRef myGradient = CGGradientCreateWithColorComponents(myColorspace, components, locations, num_locations);
        
        CGPoint myCentrePoint = CGPointMake(32, 32);
        float myRadius = 20;
        
       // CGContextDrawRadialGradient(UIGraphicsGetCurrentContext(), myGradient, myCentrePoint,0, myCentrePoint, myRadius,kCGGradientDrawsAfterEndLocation);
        
        //CGGradientRelease(myGradient);
       // CGColorSpaceRelease(myColorspace);
        CGRect borderRect = CGRectMake(0, 0, 64, 64);

        CGContextSetRGBFillColor(defBrushTextureContext, 1.0, 1.0, 1.0, 1.0);
        CGContextSetLineWidth(defBrushTextureContext, 2.0);
        CGContextFillEllipseInRect (defBrushTextureContext, borderRect);
        CGContextFillPath(defBrushTextureContext);
         UIGraphicsPopContext();
        
        squareBrush = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    }
    
    return squareBrush;
}


@end
