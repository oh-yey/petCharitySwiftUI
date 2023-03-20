//
//  DonateDetailSheet.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/12.
//

import SwiftUI

extension DonateView {
    
    struct DonateDetailSheet: View {
        
        @Environment(\.dismiss) private var dismiss
        
        @Binding var donate: PetDonate
        
        @State private var showingAlert = false
        
        var isToBeReleased: Bool {
            donate.state == 0
        }
        
        var body: some View {
            
            VStack(spacing: 8) {
                HStack {
                    Text(donate.name)
                        .font(.title)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .foregroundColor(donate.sex == 0 ? .blue : .pink)
                    Spacer()
                    
                    if donate.state != 2 {
                        stateButton()
                    }
                }
                
                
                HStack {
                    AsyncImage(url: URL(string: donate.coverImage.image)) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxHeight: 128)
                    .cornerRadius(12)
                    
                    
                    Spacer()
                        .frame(width: 24)
                    
                    HStack {
                        CircularProgress(progress: Double(donate.alreadyAmount ?? 0)/Double(donate.amount))
                            .overlay {
                                Text("众筹进度")
                            }
                        
                        Spacer()
                            .frame(width: 32)
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text(donate.breed.variety)
                                Text(donate.breed.name)
                                Text(donate.breed.raceValue)
                                
                            }
                            Text("体重： \(donate.weight) kg")
                            
                            Text("出生年月： \(donate.birth)")
                            
                            Text("状态：\(donate.stateValue)")
                            
                        }.font(.title3)
                        Spacer()
                        
                    }
                    .frame(height: 100)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.gray.opacity(0.5), lineWidth: 4)
                    )
                }.padding(.vertical)
                
                // 简介
                Text(donate.description)
                    .font(.body)
                
                // 图片
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 4) {
                        ForEach(donate.images) { item in
                            AsyncImage(url: URL(string: item.image)) { image in
                                image.resizable().scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
                .frame(height: 160)
                
                .cornerRadius(12)
                
                Spacer()
                
                // 时间
                HStack {
                    buildTime(time: donate.createTime, title: "创建日期")
                    Spacer()
                    buildTime(time: donate.publishTime, title: "发布日期")
                    Spacer()
                    buildTime(time: donate.finishTime, title: "完成日期")
                }
            }
            .padding()
            .padding()
            .background(Color("CardBg"))
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text(isToBeReleased ? "您确定要发布吗?" : "您确定要结束众筹吗?"),
                    message: Text(isToBeReleased ? "发布后无法修改" : "结束后无法捐赠"),
                    primaryButton: .destructive(Text(isToBeReleased ? "发布" : "结束众筹"), action: stateUpdate),
                    secondaryButton: .cancel()
                )
            }
        }
        
        private func stateButton() -> some View {
            Button(isToBeReleased ? "发布" : "完成众筹") {
                showingAlert = true
            }
            .buttonStyle(.borderless)
            .padding(.horizontal)
        }
        
        
        private func stateUpdate() {
            DonateApi.stateUpdate(id: donate.id, state: donate.state + 1) { result in
                switch(result) {
                case .success(let detail):
                    if detail.code == 200 {
                        donate.state = donate.state + 1
                        if donate.state == 1 {
                            donate.publishTime = data2String(Date(), dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSSSS")
                        }
                        if donate.state == 2 {
                            donate.finishTime = data2String(Date(), dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSSSS")
                        }
                        dismiss()
                    } else {
                        print("stateUpdate错误")
                    }
                case .failure(_):
                    print("stateUpdate错误")
                }
            }
            
           
        }
        
        private func buildTime(time: String?,title: String) -> some View {
            VStack {
                Text(django2String(time, dateFormat: "yyyy-MM-dd"))
                    .frame(minWidth: 100)
            }
            .padding()
            .overlay(
                ZStack(alignment: .bottomTrailing) {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.gray.opacity(0.25), lineWidth: 1)
                        .padding(.all, 4)
                    
                    Text(title)
                        .font(.footnote)
                        .opacity(0.25)
                        .padding(.bottom, -8)
                        .padding(.vertical, 4)
                        .background(Color("CardBg"))
                        .padding(.trailing, 16)
                }
            )
        }
    }
}
