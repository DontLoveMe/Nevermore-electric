//
//  MInePhoto.m
//  赛飞奇电力
//
//  Created by 刘毅 on 16/6/7.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "MinePhotoView.h"

@implementation MinePhotoView

- (IBAction)takePhotoAction:(UIButton *)sender {
     NSLogSFQ(@"拍照");
    //判断是否有可用的摄像头
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    
    if (!isCamera) {
        
        //弹出提示框
        
        NSLogSFQ(@"没有可用的摄像头");
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    [[self viewController] presentViewController:imagePicker animated:YES completion:nil];

}
- (IBAction)photographAlbumAction:(UIButton *)sender {
    NSLogSFQ(@"相册");
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    
    //设置资源来源
    imgPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    imgPicker.delegate = self;
    //模态效果弹出
    [[self viewController] presentViewController:imgPicker animated:YES completion:nil];

}

//取到视图控制器
- (UIViewController *)viewController {
    
    UIResponder *next = self.nextResponder;
    
    do {
        
        if ([next isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
        
    } while (next != nil);
    
    return nil;
}

#pragma  mark -- 完成选取资源调用此协议方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //    NSLog(@"选取完成...%@",info);
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:@"public.image"]) {//图片
        
        //获取图片
        UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
        _iconView.image = originalImage;
        
        //判断图片来源是否是来自摄像头
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            
            //保存图片到相册
            UIImageWriteToSavedPhotosAlbum(originalImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
        
    }else if ([mediaType isEqualToString:@"public.movie"]){//视频
        
        //对视频进行操作
        
        NSLog(@"%@",info);
    }
    //取消模态
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//保存图片的监听方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error == nil) {
        
        NSLogSFQ(@"保存成功");
    }else{
        
        NSLogSFQ(@"保存失败");
    }
}

//取消选取图片调用此协议方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    NSLogSFQ(@"取消");
    
    //取消模态
    [picker dismissViewControllerAnimated:YES completion:nil];
}




- (IBAction)cancelAction:(UIButton *)sender {
    
    self.hidden = YES;
}

@end
