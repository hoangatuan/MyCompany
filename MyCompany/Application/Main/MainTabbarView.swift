//
//  MainTabbarView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/18/20.
//

import SwiftUI
import CodeScanner

struct MainTabbarView: View {
    @State private var onShowScanQR: Bool = false
    @State private var selectedTab: Int = 2
    @ObservedObject var viewModel = ScanViewModel()
    
    let appState: AppState = AppState() // Trick to Pop to Root: https://www.youtube.com/watch?v=Wx-6HOkz5pE
    let newsViewModel: NewViewModel = NewViewModel()
    let coinViewModel: TotalCoinViewModel = TotalCoinViewModel(totalCoin: 0)
    
    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $selectedTab) {
                    MeetingRoomView().tabItem {
                        Image(systemName: "house").resizable()
                        Text("Room")
                    }.tag(0)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    
                    VouchersView().tabItem {
                        Image(systemName: "applescript").resizable()
                        Text("Vouchers")
                    }
                    .tag(1)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    
                    NewsView(onShowScanQR: $onShowScanQR, newsViewModel: newsViewModel)
                        .environmentObject(coinViewModel)
                        .tabItem {
                            Image(systemName: "newspaper").resizable()
                            Text("News")
                        }
                        .tag(2)
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                    
                    CreateRequestView().tabItem {
                        Image(systemName: "doc").resizable()
                        Text("Request")
                    }
                    .tag(3)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    
                    BusInforView().tabItem {
                        Image(systemName: "bus").resizable()
                        Text("eBus")
                    }
                    .tag(4)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                }.accentColor(Color(UIColor.ColorFF88A7))
                
                NavigationLink(destination: InputPaymentView(store: viewModel.store).environmentObject(appState),
                               isActive: $viewModel.onShowPaymentView, label: {

                               }).isDetailLink(false)
                    .onReceive(appState.$moveToRoot, perform: { moveToRoot in
                        if moveToRoot == true {
                            self.viewModel.onShowPaymentView = false
                            self.appState.moveToRoot = false
                        }
                    })
            }.sheet(isPresented: $onShowScanQR, content: {
                CodeScannerView(codeTypes: [.qr], completion: handleScan)
            })
        }
    }
    
    private func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        switch result {
            case .success(let code):
                print(code)
                onShowScanQR = false
                viewModel.getInfo(storeID: code)
            case .failure(let err):
                print("Scanning fail with error: \(err)")
        }
    }
}

struct MainTabbarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabbarView()
    }
}
