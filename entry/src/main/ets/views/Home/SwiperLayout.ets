import type { BannerListDataSource, IBannerItem } from '../../models/HomeData';

@Component
export default struct SwiperLayout {
  @StorageProp('windowTopHeight') windowTopHeight: number = 0;
  @Prop bannerList: BannerListDataSource

  build() {
    if (this.bannerList.totalCount()) {
      Swiper() {
        LazyForEach(this.bannerList, (banner: IBannerItem) => {
          Image(banner.imageURL).width('100%').height(175 + px2vp(this.windowTopHeight))
        }, (item: IBannerItem) => item.id + '')
      }
      .loop(true)
      .indicator(
        Indicator.dot()// 设置圆形导航点样式
          .color('#CCCBCB')
          .selectedColor($r('app.color.primary'))
      )
    }
  }
}