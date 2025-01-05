import { SHADOW_RADIUS } from '../../constants/size';

@Component
export default struct Ad  {
  @Link adPicture: string;

  build() {
    Image(this.adPicture)
      .width('100%')
      .height(61)
      .objectFit(ImageFit.Fill)
      .margin({ top: 9 })
      .shadow({
        radius: SHADOW_RADIUS,
        color: $r('app.color.shadow'),
        offsetX: 0,
        offsetY: 0
      })
  }
}