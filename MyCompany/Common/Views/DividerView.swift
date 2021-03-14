//
//  DividerView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/15/20.
//

import SwiftUI

struct DividerView: View {
    var body: some View {
        Spacer().frame(width: UIScreen.main.bounds.width,
                       height: 8.0, alignment: .center)
            .background(Color(UIColor.ColorE9E9E9))
    }
}

struct DividerView_Previews: PreviewProvider {
    static var previews: some View {
        DividerView()
            .previewLayout(.sizeThatFits)
    }
}
