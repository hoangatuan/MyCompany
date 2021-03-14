//
//  NewsSearchView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/17/20.
//

import SwiftUI

struct NewsSearchView: View {
    @ObservedObject var viewModel: NewSearchViewModel = NewSearchViewModel()
    @State private var searchText: String = ""
    @State private var newType: Int = 0
    
    init() {
        print("Init New search view")
    }
    
    var body: some View {
        ZStack {
            VStack {
                SearchHeaderView(newType: $newType, searchTitle: $searchText, placeHolder: "Type title...", valuesArray: viewModel.filterArrays)
                
                ScrollView() {
                    ForEach(viewModel.newDatasToPresent) { new in
                        NewSearchCell(newInfo: new)
                            .listRowInsets(EdgeInsets())
                    }
                }
            }.onChange(of: searchText, perform: { value in
                fetchNewsWithTitle()
            }).onChange(of: newType, perform: { value in
                fetchNewsWithTitle()
            })
            
            if viewModel.newDatasToPresent.isEmpty {
                ZStack {
                    let title = viewModel.didSearchFirstTime ? "Nothing matching your keyword is found" : "Please type your keyword to search"
                    Text(title)
                }
            }
        }.navigationTitle("")
        .navigationBarHidden(true)
    }
    
    private func fetchNewsWithTitle() {
        let newType = NewType(rawValue: self.newType) ?? .new
        viewModel.searchNewByTitle(title: searchText, type: newType)
    }
}

struct NewsSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NewsSearchView()
    }
}
