//
//  BusRouteCell.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/21/20.
//

import SwiftUI

struct BusRouteCell: View {
    var busRoute: BusRoute
    @ObservedObject private var viewModel: BusRouteCellViewModel
    
    init(busRoute: BusRoute) {
        self.busRoute = busRoute
        viewModel = BusRouteCellViewModel()
        viewModel.loadNewsImage(urlString: busRoute.imageURL, routeID: busRoute.routeID)
    }
    
    var body: some View {
        HStack {
            RoadMarkersView(busRoute: busRoute)
            
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 6.0, content: {
                        HStack {
                            Text(busRoute.time)
                                .font(.system(size: 14.0))
                                .bold()
                            Spacer()
                        }.padding(EdgeInsets(top: busRoute.isStartPoint ? 0 : 8,
                                             leading: 0, bottom: 0, trailing: 0))
                        
                        Text(busRoute.description)
                            .fixedSize(horizontal: false, vertical: true) // For multi line text, set line limit doesnt work
                            .font(.system(size: 14.0))
                            .padding(.bottom)
                    })
                    
                    Spacer()
                    Image(uiImage: viewModel.routeImage)
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                }
                
                if !busRoute.isGoHomePoint && !busRoute.isEndPoint {
                    Divider()
                }
            }
           
        }.padding([.leading, .trailing])
    }
}

struct BusRouteCell_Previews: PreviewProvider {
    static let route = BusRoute(time: "07:35",
                                description: "Truoc cong cong ty khai thac ca Ho tay - ngo 612 Lac Long Quan (doi dien pho Trinh Cong Son",
                                imageURL: "",
                                isStartPoint: false,
                                isEndPoint: false,
                                isGoHomePoint: false)
    static var previews: some View {
        BusRouteCell(busRoute: route).frame(width: UIScreen.main.bounds.width,
                                            height: 80.0)
    }
}

struct RoadMarkersView: View {
    var busRoute: BusRoute
    
    
    var body: some View {
        ZStack {
            if busRoute.isEndPoint {
                Image("icon_bus_endPoint")
                    .resizable()
                    .frame(width: 18, height: 18, alignment: .center)
            } else {
                Image("icon_bus_startPoint")
                    .resizable()
                    .frame(width: 18, height: 18, alignment: .center)
            }
            
            GeometryReader { geometry in
                VStack {
                    if !busRoute.isGoHomePoint {
                        Path { path in
                            if !busRoute.isStartPoint {
                                path.move(to: CGPoint(x: geometry.size.width / 2,
                                                      y: 0.0))
                                path.addLine(to: CGPoint(x: geometry.size.width / 2,
                                                         y: geometry.size.height / 2 - 10.0))
                            }
                            
                            if !busRoute.isEndPoint {
                                path.move(to: CGPoint(x: geometry.size.width / 2,
                                                      y: geometry.size.height / 2 + 10.0))
                                path.addLine(to: CGPoint(x: geometry.size.width / 2,
                                                         y: geometry.size.height))
                            }
                        }.stroke(Color.black, style: .init(lineWidth: 2.0,
                                                           dash: [10.0, 5.0], dashPhase: 0))
                    }
                }
            }.frame(width: 20, alignment: .center)
        }
    }
}
