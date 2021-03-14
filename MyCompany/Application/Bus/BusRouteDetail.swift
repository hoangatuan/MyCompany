//
//  BusRouteDetail.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/21/20.
//

import SwiftUI
import MapKit

struct BusRouteDetail: View {
    var busInfo: BusInfo
    
    var body: some View {
        VStack(spacing: 0.0) {
            CustomNavigationBar(isShowBackButton: true, backButtonTitle: "Bus", isShowSearchButton: false, stateShowView: .constant(RightActionStateModel()))
            ScrollView {
                VStack(alignment: .leading, spacing: 0.0) {
                    
                    HStack {
                        Text("Hotline: \(busInfo.hotline)")
                            .font(.system(size: 22.0))
                            .padding(EdgeInsets(top: 8.0, leading: 0, bottom: 4.0, trailing: 0.0))
                        Spacer()
                    }
                    
                    Text(busInfo.name).bold()
                        .font(.system(size: 22.0))
                        .padding(EdgeInsets(top: 0.0, leading: 0, bottom: 50.0, trailing: 0.0))
                    Spacer()
                }.padding([.leading, .trailing])
                
                DividerView()
                
                HStack {
                    Image("icon_bus_clock")
                        .resizable().frame(width: 20, height: 20)
                    Text("Route to company")
                        .bold()
                    Spacer()
                }.padding([.leading, .trailing, .top])
                
                VStack(spacing: 0.0) {
                    ForEach(getRouteToWork()) { route in
                        BusRouteCell(busRoute: route)
                            .frame(width: UIScreen.main.bounds.width)
                    }
                }
                
                DividerView()
                
                Group {
                    HStack() {
                        Image("icon_bus_clock")
                            .resizable().frame(width: 20, height: 20)
                        Text("Departure time in the afternoon")
                            .bold()
                        Spacer()
                    }.padding([.leading, .trailing, .top])
                    
                    BusRouteCell(busRoute: getRouteToHome())
                        .frame(width: UIScreen.main.bounds.width)
                }
                
                DividerView()
                
                Group {
                    HStack {
                        Image("icon_bus_secretary")
                            .resizable().frame(width: 20, height: 20)
                        Text("Bus Secretary")
                            .bold()
                        Spacer()
                    }.padding([.leading, .trailing, .top])
                    
                    BusSecretaryView(account: busInfo.account, telephone: busInfo.telephone)
                    
                    DividerView()
                }
                
                HStack {
                    Image("icon_bus_map")
                        .resizable().frame(width: 20, height: 24)
                    Text("Map")
                        .bold()
                    Spacer()
                }.padding([.leading, .trailing, .top])
                
                MapView(sourceLat: busInfo.lat, sourceLong: busInfo.long)
                    .frame(width: UIScreen.main.bounds.width, height: 300, alignment: .center)
                
                /*
                Button(action: {
                    openMaps()
                }, label: {
                    HStack {
                        Image(systemName: "mappin")
                            .resizable().frame(width: 20, height: 20)
                        Text("Map")
                            .bold()
                        Spacer()
                        Image(systemName: "chevron.right")
                    }.padding([.leading, .trailing, .top])
                })
                 */
            }.navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
    
    private func getRouteToWork() -> [BusRoute] {
        var allRoutes: [BusRoute] = busInfo.route
        allRoutes.removeLast()
        return allRoutes
    }
    
    private func getRouteToHome() -> BusRoute {
        let route = busInfo.route.last
        return route ?? BusRoute(time: "17h30",
                                 description: "Giờ rời bến buổi chiều",
                                 imageURL: "",
                                 isStartPoint: false, isEndPoint: false, isGoHomePoint: true)
    }
    
    /*
    private func openMaps() {
        let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 21.009746, longitude: 105.5329757)))
        source.name = "Source"

        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: busInfo.lat, longitude: busInfo.long)))
        destination.name = "Destination"

        MKMapItem.openMaps(with: [source, destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
     */
}

struct BusRouteDetail_Previews: PreviewProvider {
    static let businfo = BusInfo(numbOrder: "1.1", name: "Lac Long Quan",
                                 pickTime: "7h35", dropTime: "17h30",
                                 route: [], hotline: "123",
                                 account: "TuanHA24", telephone: "123456")
    
    static var previews: some View {
        BusRouteDetail(busInfo: businfo)
    }
}
