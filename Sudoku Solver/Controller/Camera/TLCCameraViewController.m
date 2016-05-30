//
//  TLCCameraViewController.m
//  Sudoku Solver
//
//  Created by andy on 2016-04-11.
//  Copyright © 2016 Te Lun Chen. All rights reserved.
//

#import "TLCCameraViewController.h"
#import "TLCSolverViewController.h"

@interface TLCCameraViewController ()

//Imaging
@property (weak, nonatomic) IBOutlet UIImageView *imageToRecognize;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) UIImage *chosenImage;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation TLCCameraViewController

bool shown = false;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.operationQueue = [[NSOperationQueue alloc] init];
}

- (void)viewDidAppear:(BOOL)animated{
    if (!shown){
        [self openCamera];
        shown = true;
    }
}

-(void)recognizeImageWithTesseract:(UIImage *)image
{
    
    // Create a new `G8RecognitionOperation` to perform the OCR asynchronously
    // It is assumed that there is a .traineddata file for the language pack
    // you want Tesseract to use in the "tessdata" folder in the root of the
    // project AND that the "tessdata" folder is a referenced folder and NOT
    // a symbolic group in your project
    G8RecognitionOperation *operation = [[G8RecognitionOperation alloc] initWithLanguage:@"eng"];
    
    operation.tesseract.charWhitelist = @"0123456789";
    
    // Use the original Tesseract engine mode in performing the recognition
    // (see G8Constants.h) for other engine mode options
    operation.tesseract.engineMode = G8OCREngineModeTesseractOnly;
    
    // Let Tesseract automatically segment the page into blocks of text
    // based on its analysis (see G8Constants.h) for other page segmentation
    // mode options
    operation.tesseract.pageSegmentationMode = G8PageSegmentationModeSingleChar;

    // Optionally limit the time Tesseract should spend performing the
    // recognition
    //operation.tesseract.maximumRecognitionTime = 1.0;
    
    // Set the delegate for the recognition to be this class
    // (see `progressImageRecognitionForTesseract` and
    // `shouldCancelImageRecognitionForTesseract` methods below)
    operation.delegate = self;
    
    // Optionally limit Tesseract's recognition to the following whitelist
    // and blacklist of characters
    //operation.tesseract.charWhitelist = @"01234";
    //operation.tesseract.charBlacklist = @"56789";
    
    // Set the image on which Tesseract should perform recognition
    operation.tesseract.image = image;
    
    // Optionally limit the region in the image on which Tesseract should
    // perform recognition to a rectangle
    //operation.tesseract.rect = CGRectMake(20, 20, 100, 100);
    
    // Specify the function block that should be executed when Tesseract
    // finishes performing recognition on the image
    operation.recognitionCompleteBlock = ^(G8Tesseract *tesseract) {
        // Fetch the recognized text
        NSString *recognizedText = tesseract.recognizedText;
        
        NSLog(@"text is %@", recognizedText);
        
//        TLCSolverViewController *viewController = [TLCSolverViewController alloc];
//        //viewController.content =  recognizedText;
//        viewController = [viewController init];
//        UINavigationController *chatVC = [[UINavigationController alloc]initWithRootViewController:viewController];
//        [self presentViewController: chatVC animated: YES completion:nil];

        /*
         // Spawn an alert with the recognized text
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OCR Result"
         message:recognizedText
         delegate:nil
         cancelButtonTitle:@"OK"
         otherButtonTitles:nil];
         [alert show];*/
    };
    
    // Display the image to be recognized in the view
    self.imageToRecognize.image = operation.tesseract.thresholdedImage;
    
    // Finally, add the recognition operation to the queue
    [self.operationQueue addOperation:operation];
}

/**
 *  This function is part of Tesseract's delegate. It will be called
 *  periodically as the recognition happens so you can observe the progress.
 *
 *  @param tesseract The `G8Tesseract` object performing the recognition.
 */
- (void)progressImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    NSLog(@"progress: %lu", (unsigned long)tesseract.progress);
}

/**
 *  This function is part of Tesseract's delegate. It will be called
 *  periodically as the recognition happens so you can cancel the recogntion
 *  prematurely if necessary.
 *
 *  @param tesseract The `G8Tesseract` object performing the recognition.
 *
 *  @return Whether or not to cancel the recognition.
 */
- (BOOL)shouldCancelImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    return NO;  // return YES, if you need to cancel recognition prematurely
}

- (IBAction)openCamera
{
    UIImagePickerController *imgPicker = [UIImagePickerController new];
    imgPicker.delegate = self;
    imgPicker.allowsEditing = YES;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imgPicker animated:NO completion:nil];
    }
}
/*
 - (IBAction)recognizeSampleImage:(id)sender {
 self.imagePicker = [[UIImagePickerController alloc] init];
 self.imagePicker.delegate = self;
 [self.imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
 [self presentViewController: self.imagePicker animated:YES completion: nil];
 
 
 [self recognizeImageWithTesseract:[UIImage imageNamed:@"image_sample.jpg"]];
 }*/

- (IBAction)clearCache:(id)sender
{
    [G8Tesseract clearCache];
}

#pragma mark - UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    CGFloat imgWidth = image.size.width/9;
    CGFloat imgHeight = image.size.height/9;
    
    for (int i=0; i<9;i++){
        for (int j=0; j<1;j++){
            CGRect imgFrame = CGRectMake(imgWidth*i, imgHeight*j, imgWidth, imgHeight);
            CGImageRef split = CGImageCreateWithImageInRect(image.CGImage, imgFrame);
            UIImage *currentImage = [UIImage imageWithCGImage:split];
            [self recognizeImageWithTesseract:currentImage];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
