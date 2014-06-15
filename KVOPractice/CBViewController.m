//
//  CBViewController.m
//  KVOPractice
//
//  Created by jimzhai on 6/14/14.
//  Copyright (c) 2014 zhaishuai. All rights reserved.
//

#import "CBViewController.h"
#import "CBRectPositionController.h"

@interface CBViewController ()

@property (weak, nonatomic) IBOutlet UISlider *Rslider;
@property (weak, nonatomic) IBOutlet UISlider *Gslider;
@property (weak, nonatomic) IBOutlet UISlider *Bslider;
@property (nonatomic) NSSet *observableKeys;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (nonatomic) UIColor *backgroundColorOfLabel;
@property (weak, nonatomic) IBOutlet UILabel *RLabel;
@property (weak, nonatomic) IBOutlet UILabel *GLabel;
@property (weak, nonatomic) IBOutlet UILabel *BLabel;

@end

@implementation CBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.Rslider addTarget:self action:@selector(RsliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.Gslider addTarget:self action:@selector(GsliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.Bslider addTarget:self action:@selector(BsliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addObserver:self forKeyPath:@"backgroundColorOfLabel" options:NSKeyValueObservingOptionInitial context:nil];
    self.backgroundColorOfLabel = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
}

- (void)RsliderValueChanged:(id)sender{
    UISlider *slider = sender;
    self.backgroundColorOfLabel = [UIColor colorWithRed:slider.value green:self.Gslider.value blue:self.Bslider.value alpha:1];
    self.RLabel.text = [NSString stringWithFormat:@"%f",slider.value];
    
}

- (void)GsliderValueChanged:(id)sender{
    UISlider *slider = sender;
    self.backgroundColorOfLabel = [UIColor colorWithRed:self.Rslider.value green:slider.value blue:self.Bslider.value alpha:1];
        self.GLabel.text = [NSString stringWithFormat:@"%f",slider.value];
}

- (void)BsliderValueChanged:(id)sender{
    UISlider *slider = sender;
    self.backgroundColorOfLabel = [UIColor colorWithRed:self.Rslider.value green:self.Gslider.value blue:slider.value alpha:1];
    self.BLabel.text = [NSString stringWithFormat:@"%f",slider.value];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([keyPath isEqualToString:@"backgroundColorOfLabel"]){
        self.colorLabel.backgroundColor = self.backgroundColorOfLabel;
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc{
    [self.backgroundColorOfLabel removeObserver:self forKeyPath:@"backgroundColorOfLabel"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"changeFrame"]){
        [[segue destinationViewController] setColorLabelBackgroundColor:self.backgroundColorOfLabel];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

@end
