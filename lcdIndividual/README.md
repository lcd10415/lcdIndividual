# lcdIndividual
lcd sometimes do some iOS development for improvement
good good study,day day up

AVFoundation:一个可以用来使用和创建基于时间的视听媒体的框架，它提供了一个能使用基于时间的视听数据的详细级别的Objective-C接口。例如：您可以用它来检查，创建，编辑或是重新编码媒体文件。也可以从设备中获取输入流，在视频实时播放时操作和回放
在使用时，尽量使用最高级别的抽象的控件：1.如果只是播放视频，应该用AVKit框架 2.在iOS中，如果只是录制视频，可以使用UIKit框架(UIImagePickerController)
播放声音文件，用AVAudioPlayer。录制音频，用AVAudioRecorder
AVFoundation 框架用来表示媒体的主要类是AVAssest
1.session:一个session用于控制数据从input设备到output设备的流向 AVCaptureSession * session = [AVCaptureSession alloc] init];

