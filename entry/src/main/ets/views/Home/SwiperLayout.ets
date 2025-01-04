import { BannerListDataSource, IBannerItem } from '../../models/HomeData';

@Component
export default struct SwiperLayout {
  @ObjectLink bannerList: BannerListDataSource;

  build() {
    Swiper() {
      LazyForEach(this.bannerList, (banner: IBannerItem) => {
        Image(banner.imageURL).width('100%').height('100%').objectFit(ImageFit.Fill)
      }, (banner: IBannerItem) => banner.id + '')
    }
    .width('100%')
    .height(211 - 36) // 暂时减去状态栏高度
    .autoPlay(true) // 自动轮播
    .indicator( // 设置圆点导航点样式
      new DotIndicator()
        .color($r('app.color.indicator_color')) //#CCCBCB
        .selectedColor($r('app.color.indicator_active_color'))
    )
  }
}