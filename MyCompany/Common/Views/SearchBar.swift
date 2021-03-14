//
//  SearchBar.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/3/20.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    @Binding var inputText: String
    var placeHolder: String
    var isWhiteBackground: Bool
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $inputText)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = placeHolder
        searchBar.delegate = context.coordinator
        searchBar.returnKeyType = UIReturnKeyType.done
        if isWhiteBackground {
            searchBar.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        }
        
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = inputText
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(inputText: .constant("s"), placeHolder: "Find room information...", isWhiteBackground: true)
            .previewLayout(.sizeThatFits)
    }
}
