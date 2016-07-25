//
//  ImageDetailViewController.m
//  ImageSearch
//
//  Created by Amit Gulati on 21/07/16.
//  Copyright © 2016 amit gulati. All rights reserved.
//

#import "ImageDetailViewController.h"
const CGFloat kRetinaToEyeScaleFactor = 0.5f;
const CGFloat kFaceBoundsToEyeScaleFactor = 4.0f;


@interface ImageDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ImageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL* url = [NSURL URLWithString:self.imageURL];
    
    // get access to the global dispatch queue
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concurrentQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:url];
        UIImage* image =[UIImage imageWithData:data];
        
        // get access to the main dispatch queue
        dispatch_queue_t mainDispatchQueue = dispatch_get_main_queue();
        dispatch_async(mainDispatchQueue, ^{
            self.imageView.image = image;
            __block UIImage * overlayImage;
            overlayImage = [self faceOverlayImageFromImage:image];
            [self fadeInNewImage:overlayImage];
        });
    });

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)faceOverlayImageFromImage:(UIImage *)image
{
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil
                                              options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    // Get features from the image
    CIImage* newImage = [CIImage imageWithCGImage:image.CGImage];
    
    NSArray *features = [detector featuresInImage:newImage];
    
    UIGraphicsBeginImageContext(image.size);
    CGRect imageRect = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
    
    //Draws this in the upper left coordinate system
    [image drawInRect:imageRect blendMode:kCGBlendModeNormal alpha:1.0f];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (CIFaceFeature *faceFeature in features) {
        CGRect faceRect = [faceFeature bounds];
        CGContextSaveGState(context);
        
        // CI and CG work in different coordinate systems, we should translate to
        // the correct one so we don't get mixed up when calculating the face position.
        CGContextTranslateCTM(context, 0.0, imageRect.size.height);
        CGContextScaleCTM(context, 1.0f, -1.0f);
        
        if ([faceFeature hasLeftEyePosition]) {
            CGPoint leftEyePosition = [faceFeature leftEyePosition];
            CGFloat eyeWidth = faceRect.size.width / kFaceBoundsToEyeScaleFactor;
            CGFloat eyeHeight = faceRect.size.height / kFaceBoundsToEyeScaleFactor;
            CGRect eyeRect = CGRectMake(leftEyePosition.x - eyeWidth/2.0f,
                                        leftEyePosition.y - eyeHeight/2.0f,
                                        eyeWidth,
                                        eyeHeight);
            [self drawEyeBallForFrame:eyeRect];
        }
        
        if ([faceFeature hasRightEyePosition]) {
            CGPoint leftEyePosition = [faceFeature rightEyePosition];
            CGFloat eyeWidth = faceRect.size.width / kFaceBoundsToEyeScaleFactor;
            CGFloat eyeHeight = faceRect.size.height / kFaceBoundsToEyeScaleFactor;
            CGRect eyeRect = CGRectMake(leftEyePosition.x - eyeWidth / 2.0f,
                                        leftEyePosition.y - eyeHeight / 2.0f,
                                        eyeWidth,
                                        eyeHeight);
            [self drawEyeBallForFrame:eyeRect];
        }
        
        CGContextRestoreGState(context);
    }
    
    UIImage *overlayImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return overlayImage;
}

- (CGFloat)faceRotationInRadiansWithLeftEyePoint:(CGPoint)startPoint rightEyePoint:(CGPoint)endPoint;
{
    CGFloat deltaX = endPoint.x - startPoint.x;
    CGFloat deltaY = endPoint.y - startPoint.y;
    CGFloat angleInRadians = atan2f(deltaY, deltaX);
    
    return angleInRadians;
}

- (void)drawEyeBallForFrame:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, rect);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillPath(context);
    
    CGFloat x, y, eyeSizeWidth, eyeSizeHeight;
    eyeSizeWidth = rect.size.width * kRetinaToEyeScaleFactor;
    eyeSizeHeight = rect.size.height * kRetinaToEyeScaleFactor;
    
    x = arc4random_uniform((rect.size.width - eyeSizeWidth));
    y = arc4random_uniform((rect.size.height - eyeSizeHeight));
    x += rect.origin.x;
    y += rect.origin.y;
    
    CGFloat eyeSize = MIN(eyeSizeWidth, eyeSizeHeight);
    CGRect eyeBallRect = CGRectMake(x, y, eyeSize, eyeSize);
    CGContextAddEllipseInRect(context, eyeBallRect);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillPath(context);
}
- (void)fadeInNewImage:(UIImage *)newImage
{
    UIImageView *tmpImageView = [[UIImageView alloc] initWithImage:newImage];
    tmpImageView.contentMode = self.imageView.contentMode;
    tmpImageView.frame = self.imageView.bounds;
    tmpImageView.alpha = 0.0f;
    [self.imageView addSubview:tmpImageView];
    
    [UIView animateWithDuration:0.75f animations:^{
        tmpImageView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        self.imageView.image = newImage;
        [tmpImageView removeFromSuperview];
    }];
}

@end
