//
//  MInePhoto.h
//  赛飞奇电力
//
//  Created by 刘毅 on 16/6/7.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MinePhotoView : UIView<UINavigationControllerDelegate,UIImagePickerControllerDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end
