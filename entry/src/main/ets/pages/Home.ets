import { getHomeDataApi } from '../api/home';
import { PADDING } from '../constants/size';
import { BannerListDataSource, INavList, IPlanList, ITileList } from '../models/HomeData';
import Ad from '../views/Home/Ad';
import NavList from '../views/Home/NavList';
import PlanList from '../views/Home/PlanList';
import RoomRecommend from '../views/Home/RoomRecommend';
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
  scrollY: number = 0;
  @State bgColor: string = 'rgba(255, 255, 255, 0)'
  @State fontColor: string = 'rgb(255, 255, 255)'

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

  // 处理滚动
  handleScroll = (xOffset: number, yOffset: number) => {
    this.scrollY += yOffset;
    if (this.scrollY < 0) {
      this.scrollY = 0;
    }
    this.calcColor()
  }
  // 计算颜色
  calcColor = () => {
    // 滚动计算的 scrollY 的值到达顶部可能不是 0，给点误差
    if (this.scrollY > 10) {
      this.bgColor = 'rgba(255, 255, 255, 1)'
      this.fontColor = 'rgb(0, 0, 0)'
    } else {
      this.bgColor = 'rgba(255, 255, 255, 0)'
      this.fontColor = 'rgb(255, 255, 255)'
    }
  }

  build() {
    Stack() {
      Scroll() {
        Column() {
          SwiperLayout({ bannerList: this.bannerList })

          Column() {
            NavList({ navList: this.navList })
            TileList({ tileList: this.tileList })
            PlanList({ planList: this.planList })
            Ad({ adPicture: this.adPicture })
          }.padding({ left: PADDING, right: PADDING })

          RoomRecommend()
        }
        .justifyContent(FlexAlign.Start)
      }
      .height('100%')
      .align(Alignment.TopStart)
      .scrollBar(BarState.Off)
      .onDidScroll(this.handleScroll)

      SearchBar({ bgColor: this.bgColor, fontColor: this.fontColor })
    }
    .height('100%')
    .alignContent(Alignment.TopStart)
  }
}