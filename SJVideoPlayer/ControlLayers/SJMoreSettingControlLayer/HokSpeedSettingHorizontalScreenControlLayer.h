//
//  HokSpeedSettingHorizontalScreenControlLayer.h
//  SJVideoPlayer
//
//  Created by chenjinhua on 2022/12/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HokSpeedSettingHorizontalScreenControlLayer : UIView

@property (nonatomic, copy) NSString *selSpeed;

@property (nonatomic, nullable, copy) void(^selBlock)(NSString *speed);
@property (nonatomic, nullable, copy) void(^hideBlock)(void);

- (void)show:(UIView * _Nullable)superV;

- (void)hide;

@end

NS_ASSUME_NONNULL_END
