# CYPhotoLibrary
自定义相册,支持单选 多选 查看相片 视频等


如果要打开设置隐私界面 修改plist文件，在里面添加 URL types 并设置一项URL Schemes为prefs

详细过程可以查看简书

http://www.jianshu.com/p/dc2c07449d90


CYPhotosAsset : 代表单个照片或者视频资源

@property (nonatomic,strong,nullable) PHAsset *asset;

/** thumbnail  */
@property (nonatomic,strong,nullable) UIImage *thumbnail;

/** originalImg  */
@property (nonatomic,strong,nullable) UIImage *originalImg;

/** imageUrl  */
@property (nonatomic,copy,nullable  ) NSURL   *imageUrl;

/** imageData  */
@property (nonatomic,strong,nullable) NSData *imageData;