//
//  NewTypeSelectionView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/15/20.
//

import SwiftUI

struct NewTypeSelectionView: View {
    @Binding var type: NewType
    
    var body: some View {
        HStack(alignment: .top, spacing: 0.0) {
            VStack(spacing: 0) {
                Button(action: {
                    type = .new
                }, label: {
                    Text("News")
                        .foregroundColor(type == .new ? Color(UIColor.ColorFF88A7) : Color(UIColor.black))
                }).frame(minWidth: 0, maxWidth: .infinity)
                .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                
                if type == .new {
                    Divider().frame(height: 2)
                        .background(Color(UIColor.ColorFF88A7))
                }
            }
            VStack(spacing: 0) {
                Button(action: {
                    type = .announcement
                }, label: {
                    Text("Announcements")
                        .foregroundColor(type == .announcement ? Color(UIColor.ColorFF88A7) : Color(UIColor.black))
                }).frame(minWidth: 0, maxWidth: .infinity)
                .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                
                if type == .announcement {
                    Divider().frame(height: 2)
                        .background(Color(UIColor.ColorFF88A7))
                }
            }
        }
    }
}

struct NewTypeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NewTypeSelectionView(type: .constant(.new))
            .previewLayout(.sizeThatFits)
    }
}
