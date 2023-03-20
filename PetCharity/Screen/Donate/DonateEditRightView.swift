//
//  DonateEditRightView.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/19.
//

import SwiftUI


extension DonateEditView {
    @ViewBuilder var rightView: some View {
        VStack {
            titleView("详细信息")
            
            VStack {
                HStack {
                    Text("宠物图片")
                    Spacer()
                    
                    Button {
                        showingActionSheet = true
                    } label: {
                        Text("添加图片")
                    }
                    .actionSheet(isPresented: $showingActionSheet) {
                        ActionSheet(title: Text("选择来源"), buttons: [
                            .default(Text("相机")) { self.showCameraImagePicker = true },
                            .default(Text("相册")) { self.showPhotoLibraryImagePicker = true },
                            .cancel(),
                        ])
                    }
                }
                buildImages()
            }
            .overlayBox()
            .sheet(isPresented: $showCameraImagePicker) {
                // 相机
                ImagePicker(onSubmit: uploadImage)
            }
            .sheet(isPresented: $showPhotoLibraryImagePicker) {
                // 相册
                ImagePicker(sourceType: .photoLibrary, onSubmit: uploadImage)
            }
            
            buildDescriptionField("简介", $description, field: .description)
            
            
        }
        .padding(.horizontal)
    }
    // 图片上传
    private func uploadImage(image: UIImage) -> Void {
        PetApi.upload(image: image) { result in
            switch(result) {
            case .success(let newImage):
                images.append(newImage)
            case .failure(_):
                print("图片上传 错误")
            }
        }
    }
    // 图片显示
    private func buildImages() -> some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 8) {
                ForEach(images) { item in
                    
                    AsyncImage(url: URL(string: item.image)) { image in
                        image.resizable()
                            .overlay {
                                VStack {
                                    HStack {
                                        Spacer()
                                        Button {
                                            if let index = self.images.firstIndex(where: { $0.id == item.id }) {
                                                self.images.remove(at: index)
                                            }
                                        } label: {
                                            SFSymbol.close
                                                .font(.title)
                                        }
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.trailing, 4)
                                .padding(.top, 4)
                            }
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFit()
                    .cornerRadius(12)
                    
                }
            }
        }
    }
    
    
    // 简介
    private func buildDescriptionField(_ title: String,_ value: Binding<String>, field: MyField) -> some View {
        VStack(spacing: 4) {
            HStack {
                Text(title)
                Spacer()
            }
            TextEditor(text: value)
                .focused($field, equals: field)
                .scrollContentBackground(.hidden)
        }
        .overlayBox()
    }
}
