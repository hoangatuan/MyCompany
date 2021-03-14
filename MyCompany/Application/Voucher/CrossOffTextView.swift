//
//  CrossOffTextView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/1/20.
//

import SwiftUI
import UIKit

struct CrossOffTextView: View {
    let text: String
    var body: some View {
        ZStack {
            Text(text)
                .foregroundColor(Color.gray)
                .font(Font.system(size: 12))
            
            let currentFont = UIFont.systemFont(ofSize: 12)
            let size = text.size(withAttributes: [NSAttributedString.Key.font: currentFont])
            
            Divider().frame(width: size.width, height: 1, alignment: .center)
                .background(Color.red)
        }
    }
}

struct CrossOffTextView_Previews: PreviewProvider {
    static var previews: some View {
        CrossOffTextView(text: "Doi mat").previewLayout(.sizeThatFits)
    }
}
