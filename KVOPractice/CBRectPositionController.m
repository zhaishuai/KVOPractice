//
//  CBRectPositionController.m
//  KVOPractice
//
//  Created by jimzhai on 6/14/14.
//  Copyright (c) 2014 zhaishuai. All rights reserved.
//

#import "CBRectPositionController.h"

@interface CBRectPositionController()

@property (nonatomic)double xPosition;
@property (nonatomic)double yPosition;
@property (nonatomic)double width;
@property (nonatomic)double height;
@property (nonatomic)CGRect rect;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;

@end

@implementation CBRectPositionController
- (IBAction)xPositionChanged:(UISlider *)sender {
    self.xPosition = sender.value;
}
- (IBAction)yPositionChanged:(UISlider *)sender {
    self.yPosition = sender.value;
}
- (IBAction)widthChanged:(UISlider *)sender {
    self.width = sender.value;
}
- (IBAction)heightChanged:(UISlider *)sender {
    self.height = sender.value;
}

- (CGRect)rect{
    return CGRectMake(self.xPosition*100,
                      self.yPosition*100,
                      self.width*200,
                      self.height*200);
}

- (void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"addObserver");
    [self addObserver:self forKeyPath:@"rect" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:nil];
    [self.colorLabel setBackgroundColor:self.colorLabelBackgroundColor];
    self.xPosition = 0.5;
    self.yPosition = 0.5;
    self.width = 0.5;
    self.height = 0.5;
    [self.colorLabel setFrame:CGRectMake(self.xPosition*100, self.yPosition*100, self.width*200, self.height*200)];
}

+ (NSSet *)keyPathsForValuesAffectingRect{
    return [NSSet setWithObjects:@"xPosition",@"yPosition",@"width",@"height", nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if([keyPath isEqualToString:@"rect"]){
        NSLog(@"changed");
        [self.colorLabel setFrame:self.rect];
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
