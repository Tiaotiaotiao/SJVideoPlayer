//
//  HokSpeedSettingCell.h
//  SJVideoPlayer
//
//  Created by chenjinhua on 2022/9/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HokSpeedSettingCell : UITableViewCell

@property (nonatomic, copy) NSString *name;

@property (nonatomic, getter=isSel, assign) BOOL sel;

@end

NS_ASSUME_NONNULL_END
