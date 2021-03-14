//
//  CustomProgressView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/25/20.
//

import SwiftUI

struct CustomProgressView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: Color(UIColor.ColorFF88A7)))
            .scaleEffect(2.0, anchor: .center)
    }
}

struct CustomProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressView()
    }
}
