//
//  ViewController.m
//  JYDPKVODemo
//
//  Created by JinYong on 15-3-2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "LabColor.h"
//static int const PrivateKVOContext;
#import "KeyValueObserver.h"
#import "ContactPerson.h"
#import "Primes.h"
@interface ViewController ()
@property (nonatomic, strong) LabColor *labColor;
@property (weak, nonatomic) IBOutlet UISlider *sliderL;
@property (weak, nonatomic) IBOutlet UISlider *sliderA;
@property (weak, nonatomic) IBOutlet UISlider *sliderB;
@property (weak, nonatomic) IBOutlet UIView *viewColor;

@property (nonatomic, strong) id colorObserveToken;

@property (nonatomic, strong) ContactPerson *contact;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.labColor = [[LabColor alloc] init];
    //NSKeyValueObservingOptionPrior|NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
    [self.labColor addObserver:self forKeyPath:@"color" options:NSKeyValueObservingOptionPrior context:(__bridge void *)(self)];
    
    NSArray *a = @[@4,@45,@31];
    NSLog(@"max = %@",[a valueForKeyPath:@"@max.self"]);
    
    Primes *primes = [Primes new];
    NSLog(@"last prime is %@",[primes.primes lastObject]);
    
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self updateTextFields];
}

- (void)setContact:(ContactPerson *)contact {
    _contact = contact;
    [self updateTextFields];
}

- (NSArray *)contactStringKeys {
    return @[@"name",@"nickName",@"email",@"city"];
}

- (UITextField *)textFieldForModelKey:(NSString *)key {
    return [self valueForKey:[key stringByAppendingString:@"Field"]];
}

- (void)updateTextFields {
    for (NSString *key in [self contactStringKeys]) {
        [self textFieldForModelKey:key].text = [self.contact valueForKey:key];
    }
}

- (IBAction)fieldEditingDidEnd:(UITextField *)sender {
    for (NSString *key in [self contactStringKeys]) {
        UITextField *field = [self textFieldForModelKey:key];
        if (field == sender) {
            [self.contact setValue:sender.text forKey:key];
        }
        break;
    }
}

- (BOOL)validateName:(NSString **)nameP error:(NSError * __autoreleasing *)error {
    if (*nameP == nil) {
        *nameP = @"";
        return YES;
    } else {
        *nameP = [*nameP stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        return YES;
    }
}

- (IBAction)nameFieldEditingDidEnd:(UITextField *)sender {
    NSString *name = sender.text;
    NSError *error = nil;
    if ([self validateName:&name error:&error]) {
        self.contact.name = name;
    } else {
        
    }
    sender.text = self.contact.name;
}

- (void)setLabColor:(LabColor *)labColor {
    _labColor = labColor;
//    [labColor addObserver:self forKeyPath:@"labColor" options:NSKeyValueObservingOptionInitial context:NULL];
//    self.colorObserveToken = [KeyValueObserver observeObject:labColor keyPath:@"color" target:self selector:@selector(colorDidChange:) options:NSKeyValueObservingOptionInitial];
//    [self addObserver:self forKeyPath:@"labColor" options:NSKeyValueObservingOptionInitial context:&PrivateKVOContext];
//    [labColor addObserver:self forKeyPath:@"color" options:NSKeyValueObservingOptionInitial context:(__bridge void *)(self)];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([change[NSKeyValueChangeNotificationIsPriorKey] boolValue]) {
        NSLog(@"========改变之前 before========");
    } else {
        NSLog(@"========改变之后 end========");
    }
//    id oldValue = change[NSKeyValueChangeOldKey];
//    id newValue = change[NSKeyValueChangeNewKey];
//    NSLog(@"old : %@, new : %@",oldValue,newValue);
    
    if (context == (__bridge void *)(self)) {
        self.viewColor.backgroundColor = self.labColor.color;
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)colorDidChange:(NSDictionary *)change {
    self.viewColor.backgroundColor = self.labColor.color;
}

- (IBAction)updateLComponent:(id)sender {
    UISlider *slider = (UISlider *)sender;
    self.labColor.lComponent = slider.value;
}

- (IBAction)updateAComponent:(id)sender {
    UISlider *slider = (UISlider *)sender;
    self.labColor.aComponent = slider.value;
}

- (IBAction)updateBComponent:(id)sender {
    UISlider *slider = (UISlider *)sender;
    self.labColor.bComponent = slider.value;
}
@end
