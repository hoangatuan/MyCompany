//
//  CommentViewCell.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/25/20.
//

import SwiftUI

struct CommentCell: View {
    var aComment: Comment
    @ObservedObject var viewModel: CommentCellViewModel
    
    init(aComment: Comment) {
        self.aComment = aComment
        viewModel = CommentCellViewModel()
        viewModel.loadAvatarImage(userID: aComment.employeeID, urlString: aComment.avatarURL)
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            VStack {
                HStack {
                    Image(uiImage: viewModel.avatarImage)
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        .cornerRadius(20)
                    VStack {
                        Text(aComment.account).font(Font.custom("OpticSans-201Book", size: 16))
                        
                        let department = String(aComment.department.suffix(7))
                        Text("(\(department))")
                            .font(Font.custom("OpticSans-201Book", size: 14))
                            .foregroundColor(Color.gray)
                    }
                    Spacer()
                    
                    let commentDate = Date(timeIntervalSince1970: aComment.createDate)
                    Text(commentDate.convertToFormat(format: .comment))
                        .font(Font.custom("OpticSans-201Book", size: 14))
                        .foregroundColor(Color.gray)
                }
                
                HStack {
                    Text(aComment.comment)
                    Spacer()
                }
            }.padding()
            
            Divider()
        }
    }
}

struct CommentCell_Previews: PreviewProvider {
    static let aComment = Comment(account: "TuanHA24",
                                  avatarURL: "", department: "SYN APL",
                                  comment: "Thats great brooooooooo",
                                  createDate: 1603588522)
    
    static var previews: some View {
        CommentCell(aComment: aComment)
    }
}
