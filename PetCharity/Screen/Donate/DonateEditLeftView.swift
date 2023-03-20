//
//  DonateEditLeftView.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/19.
//

import SwiftUI


extension DonateEditView {
    
    @ViewBuilder var leftView: some View {
        VStack {
            titleView("基本信息")
            
            ScrollView {
                buildStringField("标题", $title, field: .title)
                buildDoubleField("体重", $weight, field: .weight, suffix: "千克")
                buildDateField("出生年月", $birth, field: .birth)
                buildInterField("金额", $amount, field: .amount, suffix: "元")
                buildSexSelectView()
                buildRaceSelectView()
                buildBreedSelectView()
            }
            Button("保存", action: save)
                .foregroundColor(.white)
                .frame(width: 300)
                .padding(.vertical, 12)
                .background(.myLinearGradient1())
                .cornerRadius(4)
                .padding()
                .padding(.vertical)
                .alert(isPresented: $showErrorAlert) {
                    Alert(title: Text("错误!"), message: Text(message), dismissButton: .default(Text("OK")))
                }
        }.padding(.horizontal)
    }
    
    // 保存
    func save() {
        
        if title.count < 2 {
            message = "标题长度需要大于2"
            showErrorAlert = true
            return
        }
        if description.isEmpty {
            message = "简介不能为空"
            showErrorAlert = true
            return
        }
        if amount < 100 {
            message = "众筹金额需要大于100!"
            showErrorAlert = true
            return
        }
        if images.count < 2 {
            message = "图片需要大于2!"
            showErrorAlert = true
            return
        }
        
        if isEdit {
            DonateApi.donateUpdate(
                id:donate?.id ?? 0,
                name: title,
                breed: breed,
                sex: sex,
                weight: weight,
                birth: data2String(birth, dateFormat: "yyyy-MM-dd"),
                description: description,
                amount: amount,
                images: images.map({$0.id}),
                coverImage: images.first?.id ?? 0
            ) { result in
                switch(result){
                case .success(let donate):
                    onSubmit(donate)
                    dismiss()
                case .failure(_):
                    message = "未知错误 请稍后再试"
                    showErrorAlert = true
                }
            }
        } else {
            DonateApi.donateCreate(
                name: title,
                breed: breed,
                sex: sex,
                weight: weight,
                birth: data2String(birth, dateFormat: "yyyy-MM-dd"),
                description: description,
                amount: amount,
                images: images.map({$0.id}),
                coverImage: images.first?.id ?? 0
            ) { result in
                switch(result){
                case .success(let donate):
                    onSubmit(donate)
                    dismiss()
                case .failure(_):
                    message = "未知错误 请稍后再试"
                    showErrorAlert = true
                }
            }
        }
        
    }
    
    func titleView(_ title: String) -> some View {
        HStack(spacing: 0) {
            Text("众筹")
                .font(.title2)
                .fontWeight(.bold)
            
            Divider()
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 4)
            
            Text(title)
                .font(.title3)
                .opacity(0.625)
        }
        .padding(.vertical)
    }
    
    private func buildSexSelectView() -> some View {
        HStack(spacing: 0) {
            Text("性别")
            Spacer()
            Picker("性别", selection: $sex) {
                Text("公").tag(0)
                Text("母").tag(1)
            }
        }
        .overlayBox()
    }
    
    
    private func buildRaceSelectView() -> some View {
        HStack(spacing: 0) {
            Text("种族")
            Spacer()
            
            Picker("种族", selection: $race) {
                Text("猫").tag(0)
                Text("狗").tag(1)
            }
        }
        .overlayBox()
    }
    
    private func buildBreedSelectView() -> some View {
        HStack(spacing: 0) {
            Text("品种")
            Spacer()
            if shouldShowbreedList0, shouldShowbreedList1 {
                Picker("", selection: $breed) {
                    race == 0 ?
                    ForEach(breedList0) { item in
                        Text(item.name)
                            .tag(item.id)
                    } :
                    ForEach(breedList1) { item in
                        Text(item.name)
                            .tag(item.id)
                    }
                }
                .pickerStyle(.navigationLink)
            } else {
                ProgressView()
            }
            
        }
        .overlayBox()
        .task {
            PetApi.breedList(0) { result in
                switch result {
                case let .success(data):
                    withAnimation {
                        breedList0 = data
                    }
                    shouldShowbreedList0 = true
                case let .failure(error):
                    print(error)
                }
            }
            
            PetApi.breedList(1) { result in
                switch result {
                case let .success(data):
                    withAnimation {
                        breedList1 = data
                    }
                    shouldShowbreedList1 = true
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
}
// MARK: - Field
extension DonateEditView {
    // int
    private func buildInterField(_ title: String,_ value: Binding<Int>, field: MyField, suffix: String = "g") -> some View {
        buildField(title, TextField("", value: value, format: .number), field: field, suffix: suffix)
    }
    // double
    private func buildDoubleField(_ title: String,_ value: Binding<Double>, field: MyField, suffix: String = "g") -> some View {
        buildField(title, TextField("", value: value, format: .number.precision(.fractionLength(2))), field: field, suffix: suffix)
    }
    // string
    private func buildStringField(_ title: String,_ value: Binding<String>, field: MyField) -> some View {
        buildField(title, TextField("", text: value), field: field)
    }
    // 日期
    private func buildDateField(_ title: String,_ value: Binding<Date>, field: MyField) -> some View {
        buildField(title, TextField("", value: value, format: .dateTime), field: field)
    }
    
    // 无后缀
    private func buildField(_ title: String, _ textField: some View, field: MyField) -> some View {
        LabeledContent(title) {
            textField
                .multilineTextAlignment(.trailing)
                .focused($field, equals: field)
        }
        .overlayBox()
    }
    // 有后缀
    private func buildField(_ title: String, _ textField: some View, field: MyField, suffix: String) -> some View {
        
        LabeledContent(title) {
            HStack {
                textField
                    .multilineTextAlignment(.trailing)
                    .focused($field, equals: field)
                    .keyboardType(.decimalPad)
                Text(suffix)
            }
        }
        .overlayBox()
    }
    
    enum MyField: Int {
        case title, weight, birth, amount, description
    }
}

