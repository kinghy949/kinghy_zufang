import { getHomeDataApi } from '../api/home';
import { PADDING } from '../constants/size';
import { BannerListDataSource, INavList, IPlanList, ITileList } from '../models/HomeData';
import Ad from '../views/Home/Ad';
import NavList from '../views/Home/NavList';
import PlanList from '../views/Home/PlanList';
import SearchBar from '../views/Home/SearchBar';

import SwiperLayout from '../views/Home/SwiperLayout';
import TileList from '../views/Home/TileList';

@Component
export default struct Home {
  @State bannerList: BannerListDataSource = new BannerListDataSource()
  @State navList: INavList = [];
  @State tileList: ITileList = []
  @State planList: IPlanList = [];
  @State adPicture: string = '';
  // 获取首页数据函数
  getHomeData = async () => {
    const result = await getHomeDataApi()
    this.bannerList.setList(result.bannerList);
    this.navList = result.navList;
    this.tileList = result.tileList;
    this.planList = result.planList;
    this.adPicture = result.adPicture;
  }

  // 生命周期函数：初始化渲染时触发
  aboutToAppear(): void {
    this.getHomeData()
  }
  build() {
    Stack() {
      Scroll() {
        Column() {
          SwiperLayout({ bannerList: this.bannerList })
          Column() {
            NavList({ navList: $navList })
            TileList({ tileList: $tileList })
            PlanList({ planList: $planList })
            Ad({ adPicture: $adPicture })
          }.padding({ left: PADDING, right: PADDING }).backgroundColor($r('app.color.white'))
        }
        .justifyContent(FlexAlign.Start)
      }
      .width('100%')
      .height('100%')
      .align(Alignment.TopStart)

      SearchBar()
    }
    .width('100%')
    .height('100%')
    .alignContent(Alignment.TopStart)
  }
}