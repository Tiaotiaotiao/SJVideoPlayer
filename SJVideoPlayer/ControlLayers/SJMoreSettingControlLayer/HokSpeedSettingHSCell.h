//
//  HokSpeedSettingHSCell.h
//  SJVideoPlayer
//
//  Created by chenjinhua on 2022/12/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HokSpeedSettingHSCell : UITableViewCell

@property (nonatomic, copy) NSString *name;

@property (nonatomic, getter=isSel, assign) BOOL sel;

@property (nonatomic, nullable, copy) void(^selBlock)(NSString *speed);

@end

NS_ASSUME_NONNULL_END
