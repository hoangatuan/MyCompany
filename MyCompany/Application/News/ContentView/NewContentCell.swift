//
//  ContentCell.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/6/20.
//

import SwiftUI

struct ContentCell: View {
    var content: Content
    @ObservedObject var viewModel: LoadImageViewModel
    
    init(content: Content, cacheType: DataTypeCache) {
        self.content = content
        self.viewModel = LoadImageViewModel(cacheType: cacheType)
        loadImageIfNeed()
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            HStack {
                Text("\t" + "\(content.content)" + "\n")
                    .font(Font.custom(content.font, size: CGFloat(content.size)))
                Spacer()
            }
            
            if content.imageURL != "" {
                let width = UIScreen.main.bounds.width - 16
                Image(uiImage: viewModel.defaultImage)
                    .resizable()
                    .frame(width: width, height: width * 2 / 3, alignment: .center)
            }
        }
    }
    
    private func loadImageIfNeed() {
        if content.imageURL != "" {
            viewModel.loadImage(urlString: content.imageURL, identifier: content.id)
        }
    }
}
