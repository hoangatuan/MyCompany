//
//  NewsView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/18/20.
//

import SwiftUI

struct NewsView: View {
    @ObservedObject var viewModel: NewViewModel
    @EnvironmentObject var coinViewModel: TotalCoinViewModel
    @State private var type: NewType = .new
    @State private var onShowExchangeCoinView: Bool = false
    
    @Binding var onShowScanQR: Bool
    
    init(onShowScanQR: Binding<Bool>, newsViewModel: NewViewModel) {
        _onShowScanQR = onShowScanQR
        viewModel = newsViewModel
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            CustomNavigationBar(isShowBackButton: false, backButtonTitle: "Check", isShowSearchButton: true, stateShowView: $viewModel.stateModel)
            
            NavigationLink(
                destination: LazyView(NotificationView()),
                isActive: $viewModel.stateModel.onShowNotificationView,
                label: {
                    
                })
            
            NavigationLink(
                destination: LazyView(NewsSearchView()),
                isActive: $viewModel.stateModel.onShowSearchView,
                label: {
                    
                })
            
            ScrollView {
                TotalCoinView(coinViewModel: coinViewModel)
                    .equatable()
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                
                MenuView(onShowScanQRCode: $onShowScanQR)
                    .padding([.top, .bottom])
                
                NewTypeSelectionView(type: $type)
                
                ForEach(getNewsToDisplay(type: type)) { new in
                    NewCell(new: new)
                        .listRowInsets(EdgeInsets())
                }
                
                if viewModel.onShowProgress {
                    CustomProgressView()
                }
                
                if (viewModel.httpStatusCodeNew != 444 && type == .new) ||
                    (viewModel.httpStatusCodeAnnouncement != 444 && type == .announcement) {
                    // No more to loads
                    HStack {
                        Spacer()
                        NewLoadMoreView(action: {
                            viewModel.fetchAllNews(type: type)
                        })
                        .frame(minWidth: 0, maxWidth: .infinity)
                        Spacer()
                    }
                }
            }
        }.alert(isPresented: $viewModel.onFetchNewsFailed, content: {
            Alert(title: Text("Lỗi"), message: Text(viewModel.errorMessage),
                  dismissButton: Alert.Button.default(Text("OK")))
        }).onAppear(perform: {
            openNotificationViewIfAppWasKilled()
        })
    }
    
    private func getNewsToDisplay(type: NewType) -> [New] {
        viewModel.getNewToDisplay(type: type)
    }
    
    private func openNotificationViewIfAppWasKilled() {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene

        if let windowScenedelegate = scene?.delegate as? SceneDelegate {
            if windowScenedelegate.isTapOnNotification {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.viewModel.stateModel.onShowNotificationView = true
                    windowScenedelegate.isTapOnNotification = false
                })
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView(onShowScanQR: .constant(false), newsViewModel: NewViewModel())
    }
}
