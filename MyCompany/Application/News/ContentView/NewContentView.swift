//
//  NewContentView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/25/20.
//

import SwiftUI

struct NewContentView: View {
    @State var content: NewContent = NewContent(newID: "", contents: [], comments: [])
    @Binding var new: New
    
    init(content: NewContent, new: Binding<New>) {
        _content = State(initialValue: content)
        _new = new
        
        // Can not use self.content = content because SwiftUI doesn't allow to change @State in the initializer
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            CustomNavigationBar(isShowBackButton: true, backButtonTitle: "", isShowSearchButton: false, stateShowView: .constant(RightActionStateModel()))
            ScrollView {
                HStack {
                    Text("News")
                }.padding()
                
                ForEach(content.contents) { con in
                    ContentCell(content: con, cacheType: .newContentImage)
                }.padding([.leading, .trailing])
                
                HStack {
                    Text("Comments (\(content.comments.count))")
                        .font(Font.custom("OpticSans-201Book", size: 18))
                        .foregroundColor(.black)
                        .bold()
                    Spacer()
                }.padding()
                .border(Color.gray, width: 1)
                
                ForEach(content.comments) { comment in
                    CommentCell(aComment: comment)
                }
            }
            
            ContentBottomView(listComments: $content.comments, new: $new)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        // To hide navigation bar must set navigation bar title
    }
}

struct NewContentView_Previews: PreviewProvider {
    static let newContent = NewContent(newID: "", contents: [], comments: [])
    static var previews: some View {
        NewContentView(content: newContent,
                       new: .constant(New(newID: "", title: "", imageURL: "", createDate: 0, type: 0, likes: [], dislikes: [], comments: 0)))
    }
}
