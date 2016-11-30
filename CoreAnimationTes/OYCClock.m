//
//  OYCClock.m
//  CoreAnimationTes
//
//  Created by cao on 16/11/30.
//  Copyright © 2016年 daniel. All rights reserved.
//

#import "OYCClock.h"

#define OYCViewWH (self.bounds.size.width)
#define OYCAngle2Radiu(angle) (angle / 180.0 * M_PI)

@interface OYCClock ()
@property (nonatomic,strong) CALayer *hourLayer;
@property (nonatomic,strong) CALayer *minuteLayer;
@property (nonatomic,strong) CALayer *secondLayer;
@end

@implementation OYCClock

+ (instancetype)clock{
    OYCClock *clock = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    [clock setup];
    return clock;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
        [self setup];
    }
    return self;
}

//初始化
- (void)setup{
    //布局分针图层
    [self setupMinuteLayer];
    
    //布局时针图层
    [self setupHourLayer];
    
    //布局秒针图层
    [self setupSecondLayer];
}

- (void)layoutSubviews{
    
    //开启定时器,1秒定时一次
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}

//定时器
- (void)timeChange{
    //获取当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //获取时分秒
    NSDateComponents *cmp = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    NSInteger hour = cmp.hour;
    NSInteger minute = cmp.minute;
    NSInteger second = cmp.second;
    
    //计算当前时间时分秒针的旋转角度
    CGFloat secondAngle = OYCAngle2Radiu(second * 6);
    CGFloat minuteAngle = OYCAngle2Radiu((minute + second / 60.0) * 6);
    CGFloat hourAngle = OYCAngle2Radiu((hour + minute / 60.0) * 30);
    
    //设置各时分秒图层的旋转
    self.secondLayer.transform = CATransform3DMakeRotation(secondAngle, 0, 0, 1);
    self.minuteLayer.transform = CATransform3DMakeRotation(minuteAngle, 0, 0, 1);
    self.hourLayer.transform = CATransform3DMakeRotation(hourAngle, 0, 0, 1);
    
}

//布局秒针图层
- (void)setupSecondLayer{

    //创建一个秒针图层
    CALayer *secondLayer = [CALayer layer];
    self.secondLayer = secondLayer;
    
    //设置秒针图层,因为图片与透明部分也占据一部分控件，所以为了让秒针显示在表盘内部，需要减去透明部分
    secondLayer.bounds = CGRectMake(0, 0, 1.5, OYCViewWH * 0.5 - 20);
    secondLayer.backgroundColor = [UIColor redColor].CGColor;
    secondLayer.cornerRadius = 1;
    
    //设置锚点在底部中间，默认锚点是在(0.5,0.5)的位置，最大是(1,1)
    secondLayer.anchorPoint = CGPointMake(0.5, 1);
    
    //设置position
    secondLayer.position = CGPointMake(OYCViewWH * 0.5, OYCViewWH * 0.5);
    
    //添加秒针图层到根图层
    [self.layer addSublayer:secondLayer];
}

//布局时针图层
- (void)setupHourLayer{
    
    //创建一个时针图层
    CALayer *hourLayer = [CALayer layer];
    self.hourLayer = hourLayer;
    
    //设置时针图层,因为图片与透明部分也占据一部分控件，所以为了让时针显示在表盘内部，需要减去透明部分
    hourLayer.bounds = CGRectMake(0, 0, 3.5, OYCViewWH * 0.5 - 60);
    hourLayer.backgroundColor = [UIColor blackColor].CGColor;
    hourLayer.cornerRadius = 2.5;
    
    //设置锚点在底部中间，默认锚点是在(0.5,0.5)的位置，最大是(1,1)
    hourLayer.anchorPoint = CGPointMake(0.5, 1);
    
    //设置position
    hourLayer.position = CGPointMake(OYCViewWH * 0.5, OYCViewWH * 0.5);
    
    //添加时针图层到根图层
    [self.layer addSublayer:hourLayer];
}

//布局分针图层
- (void)setupMinuteLayer{
    
    //创建一个分针图层
    CALayer *minuteLayer = [CALayer layer];
    self.minuteLayer = minuteLayer;
    
    //设置分针图层,因为图片与透明部分也占据一部分控件，所以为了让分针显示在表盘内部，需要减去透明部分
    minuteLayer.bounds = CGRectMake(0, 0, 2.5, OYCViewWH * 0.5 - 40);
    minuteLayer.backgroundColor = [UIColor blackColor].CGColor;
    minuteLayer.cornerRadius = 1.5;
    
    //设置锚点在底部中间，默认锚点是在(0.5,0.5)的位置，最大是(1,1)
    minuteLayer.anchorPoint = CGPointMake(0.5, 1);
    
    //设置position
    minuteLayer.position = CGPointMake(OYCViewWH * 0.5, OYCViewWH * 0.5);
    
    //添加分针图层到根图层
    [self.layer addSublayer:minuteLayer];
}

@end
