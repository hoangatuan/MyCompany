//
//  HeaderBookingRoomView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/9/20.
//

import SwiftUI

struct HeaderBookingRoomView: View {
    var title: String
    var content: String
    
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .foregroundColor(.white)
                .bold()
            Text(content)
                .lineLimit(1)
                .foregroundColor(.white)
                .font(Font.system(size: 16))
        }.frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
        .background(Color(UIColor.ColorFF88A7))
        .cornerRadius(10)
    }
}

struct HeaderBookingRoomView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderBookingRoomView(title: "Room", content: "Ngoc Ha")
            .previewLayout(.sizeThatFits)
    }
}
