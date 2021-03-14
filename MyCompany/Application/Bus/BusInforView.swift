//
//  BusInformationView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/20/20.
//

import SwiftUI

struct BusInforView: View {
    @ObservedObject var viewModel: BusInfoViewModel = BusInfoViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("NO.")
                    .padding(.trailing)
                Text("BUS NAME")
                Spacer()
                
                Text("TIME")
                Spacer().frame(width: 48)
            }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            
            ZStack {
                ScrollView {
                    VStack {
                        ForEach(viewModel.listBusInfos) { info in
                            NavigationLink(destination: BusRouteDetail(busInfo: info),
                                           label: {
                                            BusInfoCell(busInfo: info)
                                           })
                        }
                    }
                }
                
                if viewModel.onShowProgress {
                    CustomProgressView()
                }
            }
            
            Spacer()
        }.onAppear(perform: {
            if viewModel.listBusInfos.isEmpty {
                viewModel.requestGetBusInfo()
            }
        })
    }
}

struct BusInforView_Previews: PreviewProvider {
    static var previews: some View {
        BusInforView()
    }
}
