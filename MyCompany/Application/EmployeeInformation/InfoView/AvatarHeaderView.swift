//
//  AvatarHeaderView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/11/20.
//

import SwiftUI

struct AvatarHeaderView: View {
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @ObservedObject private var viewModel: AvatarHeaderViewModel
    @Binding var onShowProgress: Bool
    
    let employeeFullname: String
    var avatarImageUrl: String
    
    private let imageWidth: CGFloat = 100.0
    private let buttonAddImageWidth: CGFloat = 28.0
    
    init(employeeFullname: String, avatarImageUrl: String, onShowProgress: Binding<Bool>) {
        self.employeeFullname = employeeFullname
        self.avatarImageUrl = avatarImageUrl
        
        viewModel = AvatarHeaderViewModel()
        self._onShowProgress = onShowProgress
        viewModel.requestGetAvatarImage(urlString: avatarImageUrl)
    }
    
    var body: some View {
        VStack {
            ZStack {
                Image(uiImage: viewModel.avatarImage)
                    .resizable()
                    .frame(width: imageWidth, height: imageWidth, alignment: .center)
                    .cornerRadius(imageWidth / 2)
                
                if !UserDataDefaults.shared.isAdministrator {
                    VStack {
                        Spacer().frame(height: imageWidth - buttonAddImageWidth, alignment: .center)
                        HStack {
                            Spacer().frame(width: imageWidth - buttonAddImageWidth, alignment: .leading)
                            Button(action: {
                                showingImagePicker = true
                            }, label: {
                                Image("icon_employee_add")
                                    .resizable()
                                    .frame(width: buttonAddImageWidth,
                                           height: buttonAddImageWidth, alignment: .center)
                                    .foregroundColor(.white)
                            }).sheet(isPresented: $showingImagePicker, onDismiss: {
                                viewModel.updateAvatarImage(inputImage: inputImage)
                            }, content: {
                                ImagePickerView(image: $inputImage)
                            })
                            .alert(isPresented: $viewModel.onUpdateAvatarImageFailed) { () -> Alert in
                                Alert(title: Text(""), message: Text("Update avatar failed"), dismissButton: .cancel())
                            }
                        }
                    }
                }
            }
            
            HStack {
                Spacer()
                Text(employeeFullname)
                    .bold()
                    .foregroundColor(.white)
                    .font(.title3)
                Spacer()
            }
        }.onChange(of: viewModel.onShowProgress, perform: { value in
            self.onShowProgress = value
        })
    }
}

struct AvatarHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarHeaderView(employeeFullname: "", avatarImageUrl: "", onShowProgress: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
