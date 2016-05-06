
//
//  DownView.m
//  DownloadFile
//
//  Created by v on 16/4/19.
//  Copyright © 2016年 v. All rights reserved.
//

#import "DownView.h"

@interface DownView ()


@property (nonatomic, strong) UIBezierPath *bPath;
@property (nonatomic, strong) CAShapeLayer *shaperLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) UIButton *button;
@end

@implementation DownView
{
    CGPoint center;
    CGFloat radius;
    CGFloat startAngle;
    CGFloat endAngle;
    CGFloat lineWidth;
    
}
- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setBackgroundImage:[UIImage imageNamed:@"continue.png"] forState:UIControlStateNormal];
        [_button setBackgroundImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateSelected];
        
        [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        lineWidth = 2;
        center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
        radius = self.bounds.size.height * 0.5 - lineWidth;
        startAngle = 0;
        [self addSubview:self.button];
        
    }
    return self;
}

- (void)buttonClick:(UIButton *)button{

    button.selected = !button.selected;
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat buttonX = lineWidth;
    CGFloat buttonY = lineWidth;
    CGFloat buttonW = self.bounds.size.width - 2 * buttonX;
    CGFloat buttonH = self.bounds.size.height - 2 * buttonY;
    self.button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    self.button.contentEdgeInsets = UIEdgeInsetsMake(65, 0, 65,0);
}

- (UIBezierPath *)bPath{
    
    if (!_bPath) {
        _bPath = [UIBezierPath bezierPath];
       [_bPath addArcWithCenter:center radius:radius startAngle:0 endAngle:2*M_PI
                       clockwise:YES];
    }
    return _bPath;
    
    
}

- (CAShapeLayer *)progressLayer{
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.frame = self.bounds;
        _progressLayer.fillColor =  [[UIColor clearColor] CGColor];
        _progressLayer.strokeColor  = [UIColor redColor].CGColor;
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.lineWidth = 2.0;
        _progressLayer.strokeEnd = 0;
        _progressLayer.path = [self.bPath CGPath];
       
    }
    return _progressLayer;
}
- (CAShapeLayer *)shaperLayer{
    if (!_shaperLayer) {
        CAShapeLayer *sha = [CAShapeLayer layer];
        sha.frame = self.bounds;
        sha.fillColor = [UIColor clearColor].CGColor;
        sha.path = self.bPath.CGPath;
        sha.strokeColor = [UIColor grayColor].CGColor;
        sha.lineCap = kCALineCapRound;
        sha.lineWidth = 4;
        _shaperLayer = sha;
    }
    return _shaperLayer;
   
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
   
    [self.layer addSublayer:self.shaperLayer];
    
    

    
    CAGradientLayer *gradientLayer1 =  [CAGradientLayer layer];
    gradientLayer1.frame = self.bounds;
    [gradientLayer1 setColors:[NSArray arrayWithObjects:(id)[[UIColor blueColor] CGColor],(id)[[UIColor blueColor] CGColor], nil]];
//    [gradientLayer1 setLocations:@[@0.5,@0.9,@1 ]];
    [gradientLayer1 setStartPoint:CGPointMake(0, 0.2)];
    [gradientLayer1 setEndPoint:CGPointMake(0, 0.5)];
    gradientLayer1.mask = self.progressLayer;
    [self.layer addSublayer:gradientLayer1];
    
    
}
//

-(void)setProgress:(float)progress{
    

    
    _progressLayer.strokeEnd = progress;

}

@end
