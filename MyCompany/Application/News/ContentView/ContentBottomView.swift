//
//  ContentBottomView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/25/20.
//

import SwiftUI

struct ContentBottomView: View {
    @State private var inputComment: String = ""
    @Binding var listComments: [Comment]
    @Binding var new: New
    @ObservedObject private var viewModel: ContentBottomViewModel
    
    init(listComments: Binding<[Comment]>, new: Binding<New>) {
        viewModel = ContentBottomViewModel()
        _new = new
        _listComments = listComments
        viewModel.new = self.new
    }
    
    var body: some View {
        HStack(spacing: 0.0) {
            Button(action: {
                viewModel.likeNew(of: viewModel.new.newID)
            }, label: {
                let didLike = viewModel.didReaction(reactionsArray: viewModel.new.likes)
                let imageName = didLike ? "icon_new_like_color" : "icon_new_like"
                
                HStack(alignment: .bottom) {
                    Image(imageName)
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .center)
                    Text("\(viewModel.new.likes.count)")
                        .foregroundColor(didLike ? .blue : .black)
                }.padding()
            }).alert(isPresented: $viewModel.onLikeFailed, content: {
                Alert(title: Text(viewModel.messageError), message: nil, dismissButton: .none)
            })
            
            Button(action: {
                viewModel.dislikeNew(of: viewModel.new.newID)
            }, label: {
                let didDislike = viewModel.didReaction(reactionsArray: viewModel.new.dislikes)
                let imageName = didDislike ? "icon_new_dislike_color" : "icon_new_dislike"
                
                HStack(alignment: .bottom) {
                    Image(imageName)
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .center)
                    Text("\(viewModel.new.dislikes.count)")
                        .foregroundColor(didDislike ? .blue : .black)
                }.padding()
            }).alert(isPresented: $viewModel.onLikeFailed, content: {
                Alert(title: Text(viewModel.messageError), message: nil, dismissButton: .none)
            })
            
            TextField("Leave your comment...", text: $inputComment)
                .padding(EdgeInsets(top: 10.0, leading: 4.0, bottom: 10.0, trailing: 4.0))
                .border(Color.black)
                .padding([.top, .bottom])
            
            Button(action: {
                viewModel.postNewComment(of: viewModel.new.newID, comment: inputComment) { (comment) in
                    inputComment = ""
                    listComments.append(comment)
                }
            }, label: {
                Image("icon_new_send")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .padding()
            }).alert(isPresented: $viewModel.onPostCommentFailed, content: {
                Alert(title: Text(viewModel.messageError), message: nil, dismissButton: .none)
            })
        }.border(Color.gray)
        .onChange(of: viewModel.new, perform: { value in
            new = viewModel.new
        })
    }
}

struct ContentBottomView_Previews: PreviewProvider {
    static var previews: some View {
        ContentBottomView(listComments: .constant([]),
                          new: .constant(New(newID: "", title: "", imageURL: "", createDate: 0, type: 0, likes: [], dislikes: [], comments: 0)))
            .previewLayout(.sizeThatFits)
    }
}
