//
//  SearchExchangeCoinView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/30/20.
//

import SwiftUI

struct SearchExchangeCoinView: View {
    @State private var searchText: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    
    @ObservedObject var viewModel: SearchExchangeCoinViewModel = SearchExchangeCoinViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                CustomNavigationBar(isShowBackButton: true, backButtonTitle: "", isShowSearchButton: false, stateShowView: .constant(RightActionStateModel()))
                
                VStack(alignment: .leading, spacing: 0) {
                    SearchBar(inputText: $searchText, placeHolder: "Type account to search...", isWhiteBackground: false)
                    
                    HStack {
                        Text("Start date")
                            .bold()
                        Spacer()
                    }
                    
                    DatePickerView(date: $startDate, dateDidChange: {
                        if startDate > endDate {
                            endDate = startDate
                        }
                       filterResult()
                    }, isSearchOnPast: true)
                    
                    Text("End date")
                        .bold()
                    
                    DatePickerView(date: $endDate, dateDidChange: {
                        if endDate < startDate {
                            startDate = endDate
                        }
                        filterResult()
                    }, isSearchOnPast: true)
                }.padding()
                .background(Color.white)
                .cornerRadius(20, antialiased: true)
                .shadow(color: .gray, radius: 4, x: 0, y: 0)
                .padding(.all, 8)
                
                if viewModel.displayRequests.isEmpty {
                    Text("No requests to display")
                    Spacer()
                } else {
                    ScrollView {
                        Divider().frame(width: 1, height: 8, alignment: .center)
                        ForEach(viewModel.displayRequests) { request in
                            ExchangeCoinCell(exchangeCoinRequest: request)
                                .listRowInsets(EdgeInsets())
                        }
                        Divider().frame(width: 1, height: 8, alignment: .center)
                    }.background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: .gray, radius: 5, x: 0, y: 0)
                    .padding(.all, 8)
                }
            }.onAppear(perform: {
                viewModel.getAllExchangeCoinRequests()
            }).onChange(of: searchText, perform: { value in
                filterResult()
            }).alert(isPresented: $viewModel.onShowAlert, content: {
                Alert(title: Text(viewModel.errorMessage))
            })
            
            if viewModel.onShowProgress {
                CustomProgressView()
            }
        }.navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    func filterResult() {
        DispatchQueue.main.async {
            self.viewModel.filterListCoinRequest(by: self.searchText,
                                                 startDate: self.startDate,
                                                 endDate: self.endDate)
        }
    }
}

struct SearchExchangeCoinView_Previews: PreviewProvider {
    static var previews: some View {
        SearchExchangeCoinView()
    }
}
