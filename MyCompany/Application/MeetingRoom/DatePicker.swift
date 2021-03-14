//
//  DatePicker.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/4/20.
//

import SwiftUI
import Combine

struct DatePickerView: View {
    @Binding var date: Date
    @State private var valueChangeCount: Int = 0
    
    var dateDidChange: (() -> Void)
    var isIgnoreFirstTime: Bool = false
    var onComplete: (() -> Void)?
    var isSearchOnPast: Bool = false
    
    var body: some View {
        VStack {
            if isSearchOnPast {
                DatePicker(selection: $date, in: ...Date(), displayedComponents: .date, label: {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Select a date")
                })
                .accentColor(.black)
                .onReceive(Just(date), perform: { _ in
                    dateDidChange()
                    
                    valueChangeCount += 1
                    
                    if isIgnoreFirstTime && valueChangeCount == 2 {
                        onComplete?()
                    }
                })
            } else {
                DatePicker(selection: $date, in: Date()..., displayedComponents: .date, label: {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Select a date")
                })
                .accentColor(.black)
                .onReceive(Just(date), perform: { _ in
                    dateDidChange()
                    valueChangeCount += 1
                    
                    if isIgnoreFirstTime && valueChangeCount == 2 {
                        onComplete?()
                    }
                })
            }
        }
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView(date: .constant(Date()), dateDidChange: {})
            .previewLayout(.sizeThatFits)
    }
}
