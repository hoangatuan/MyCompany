//
//  NewSearchCell.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/18/20.
//

import SwiftUI

struct NewSearchCell: View {
    @ObservedObject private var viewModel: NewSearchCellViewModel
    
    init(newInfo: New) {
        viewModel = NewSearchCellViewModel(new: newInfo)
        viewModel.loadNewsImage(urlString: newInfo.imageURL, newID: newInfo.newID)
    }
    
    var body: some View {
        VStack {
            NavigationLink(
                destination: NewContentView(content: viewModel.contentFetched, new: $viewModel.newInfo),
                isActive: $viewModel.onFetchContentSuccess,
                label: {
                    
                })
            
            HStack(spacing: 16) {
                VStack(alignment: .leading) {
                    HStack {
                        let typeDescription = NewType(rawValue: viewModel.newInfo.type)?.description ?? "News"
                        Text(typeDescription)
                            .foregroundColor(.blue)
                        
                        let dateSince1970 = Date(timeIntervalSince1970: viewModel.newInfo.createDate)
                        Text(dateSince1970.convertToFormat(format: .iso))
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .foregroundColor(.black)
                    
                    Text(viewModel.newInfo.title)
                        .foregroundColor(.black)
                }
                
                Image(uiImage: viewModel.newImage)
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
                    .cornerRadius(5.0)
            }.padding()
            
            DividerView()
        }.onTapGesture(perform: {
            viewModel.fetchNewContent()
        })
    }
}

struct NewSearchCell_Previews: PreviewProvider {
    static let new = New(newID: "", title: "Hoc low code qua du an OutSystem", imageURL: "", createDate: 1603502122.0, type: 0, likes: [], dislikes: [], comments: 0)
    static var previews: some View {
        NewSearchCell(newInfo: new)
            .previewLayout(.sizeThatFits)
    }
}
