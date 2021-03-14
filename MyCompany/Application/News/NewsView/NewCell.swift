//
//  NewCell.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/18/20.
//

import SwiftUI

struct NewCell: View {
    private let leadingMargin: CGFloat = 8.0
    @ObservedObject private var viewModel: NewCellViewModel
    
    init(new: New) {
        viewModel = NewCellViewModel()
        viewModel.new = new
        viewModel.loadNewsImage(urlString: new.imageURL, newID: new.newID)
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0.0, content: {
                NavigationLink(
                    destination: NewContentView(content: viewModel.contentFetched,new: $viewModel.new),
                    isActive: $viewModel.onFetchContentSuccess,
                    label: {
                        VStack(alignment: .leading) {
                            HStack {
                                let typeDescription = NewType(rawValue: viewModel.new.type)?.description ?? "News"
                                Text(typeDescription)
                                
                                let dateSince1970 = Date(timeIntervalSince1970: viewModel.new.createDate)
                                Text(dateSince1970.convertToFormat(format: .iso))
                                Spacer()
                            }
                            .foregroundColor(.black)
                            
                            Text(viewModel.new.title)
                                .foregroundColor(.black)
                            Image(uiImage: viewModel.newImage)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width - 2 * leadingMargin,
                                       height: UIScreen.main.bounds.width / 2 - leadingMargin)
                                .cornerRadius(10.0)
                        }.onTapGesture(perform: {
                            viewModel.fetchNewContent(of: "5f94f0560385dc8d18907b94")
                        }).alert(isPresented: $viewModel.onFetchContentFailed, content: {
                            Alert(title: Text(viewModel.errorMessage), message: nil, dismissButton: .none)
                        })
                    })
                
                HStack(spacing: 0) {
                    NewsActionButton(buttonImage: "icon_new_comment", buttonImageHighlight: "icon_new_comment",
                                     count: viewModel.new.comments,
                                     defaultTilte: "Comment", onTouchUpInside: {
                                        viewModel.fetchNewContent(of: "5f94f0560385dc8d18907b94")
                                     }, didReaction: false)
                        .alert(isPresented: $viewModel.onFetchContentFailed, content: {
                            Alert(title: Text(viewModel.errorMessage), message: nil, dismissButton: .none)
                        })
                    
                    NewsActionButton(buttonImage: "icon_new_like", buttonImageHighlight: "icon_new_like_color",
                                     count: viewModel.new.likes.count,
                                     defaultTilte: "Like", onTouchUpInside: {
                                        viewModel.likeNew(of: viewModel.new.newID)
                                     }, didReaction: viewModel.didReaction(reactionsArray: viewModel.new.likes))
                        .alert(isPresented: $viewModel.onLikeFailed, content: {
                            Alert(title: Text(viewModel.errorMessage), message: nil, dismissButton: .none)
                        })
                    
                    NewsActionButton(buttonImage: "icon_new_dislike", buttonImageHighlight: "icon_new_dislike_color",
                                     count: viewModel.new.dislikes.count,
                                     defaultTilte: "Dislike", onTouchUpInside: {
                                        viewModel.dislikeNew(of: viewModel.new.newID)
                                     }, didReaction: viewModel.didReaction(reactionsArray: viewModel.new.dislikes))
                        .alert(isPresented: $viewModel.onDislikeFailed, content: {
                            Alert(title: Text(viewModel.errorMessage), message: nil, dismissButton: .none)
                        })
                }.padding([.top, .bottom])
            }).padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
            
            Spacer().frame(width: UIScreen.main.bounds.width,
                           height: 8.0, alignment: .center)
                .background(Color(UIColor.ColorE9E9E9))
        }
    }
}

struct NewCell_Previews: PreviewProvider {
    static let new = New(newID: "", title: "Hoc low code qua du an OutSystem", imageURL: "", createDate: 1603502122.0, type: 0, likes: [], dislikes: [], comments: 0)
    static var previews: some View {
        NewCell(new: new).previewLayout(.sizeThatFits)
    }
}

struct NewsActionButton: View {
    var buttonImage: String
    var buttonImageHighlight: String
    var count: Int
    var defaultTilte: String
    var onTouchUpInside: () -> Void
    var didReaction: Bool
    
    var body: some View {
        Button(action: {
            onTouchUpInside()
        }, label: {
            HStack {
                Image(didReaction ? buttonImageHighlight : buttonImage)
                    .resizable()
                    .frame(width: 18, height: 18, alignment: .center)
                    .foregroundColor(didReaction ? .blue : .clear)
                Text("\(count) \(count <= 1 ? defaultTilte : "\(defaultTilte)s")")
                    .font(.system(size: 16))
                    .foregroundColor(didReaction ? .blue : .black)
            }
        }).buttonStyle(BorderlessButtonStyle()) // Use this to prevent multiple callback in a Row: https://stackoverflow.com/questions/56561064/swiftui-multiple-buttons-in-a-list-row
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}
