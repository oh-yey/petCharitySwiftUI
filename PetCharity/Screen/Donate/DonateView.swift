//
//  DonateView.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/9.
//

import SwiftUI

struct DonateView: View {
    
    @State private var shouldShow = false
    @State private var donateList = [PetDonate]()
    @State private var sortOrder = [KeyPathComparator(\PetDonate.id)]
    
    @State private var searchText = ""
    
    @Environment(\.editMode) var editMode
    
    @State private var sheet: DetailSheet?
    
    @State private var page = 1
    @State private var pageCount = 1

    @State private var selectedItem: PetDonate?
    
    private var isEditing: Bool {
        editMode?.wrappedValue.isEditing ?? false
    }
    
    var body: some View {
        VStack {
            SearchTopView() { content in
                searchText = content
                loadingData()
            }
            
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    if shouldShow {
                        cardView
                    } else {
                        ProgressView()
                    }
                }
                .padding()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .card()
            }
            .padding(.all, 24)
            
        }
        .sheet(item: $sheet) { $0 }
        .task {
            loadingData()
        }
    }
    
    private func loadingData() -> Void {
        DonateApi.donateList(searchText, page: page) { result in
            switch result {
            case let .success(data):
                withAnimation {
                    donateList = data.results
                    pageCount =  (data.count - 1) / 5 + 1
                    shouldShow = true
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
}

// MARK: - 子View
private extension DonateView {
    
    @ViewBuilder private var cardView : some View {
        titleBar
        
        List {
            ForEach($donateList, editActions: .delete, content: buildItemRow)
                .onDelete(perform: { selectedItem = donateList[$0.first!] })
        }
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
        .alert(item: $selectedItem) { item in
            Alert(
                title: Text("删除"),
                message: Text(item.state == 0 ? "你确定要删除\(item.name)吗?" : "当前禁止删除"),
                primaryButton: item.state == 0 ? .destructive(Text("删除")) {  delete(item) } : .default(Text("确认")),
                secondaryButton: .cancel()
            )
        }
    }
    
    func delete(_ item: PetDonate) {
        DonateApi.delDonate(item.id) { isSuccess in
            if isSuccess {
                withAnimation {
                    donateList.removeAll(where: { $0.id == item.id })
                }
            } else {
                print("删除失败")
            }
        }
        
        
    }
    
    private var titleBar: some View {
        HStack {
            Text("众筹管理")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.accentColor)
            
            Spacer()
            
            Picker("页", selection: $page) {
                ForEach(Array(1...pageCount), id: \.self) { item in
                    Text("\(item)")
                }
            }
            .onChange(of: page, perform: { _ in
                loadingData()
            })
            .pickerStyle(.menu)
            .padding(.horizontal)
            
            EditButton()
                .buttonStyle(.bordered)
                .transition(.scale)
            
            if !isEditing {
                Spacer().frame(width: 16)
                addButton
            }
            
        }
    }
    
    private var addButton: some View {
        NavigationLink {
            DonateEditView() { donate in
                donateList.append(donate)
            }
        } label: {
            Text("添加")
        }
        .buttonStyle(.bordered)
    }
    

    private func buildItemRow(donateBinding: Binding<PetDonate>) -> some View {
        let donate = donateBinding.wrappedValue
        
        return HStack {
            HStack {
                Text(donate.name)
                    .font(.title3)
                    .padding(.vertical, 10)
                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                if isEditing {
                    return
                }
                sheet = .donateDetail(donateBinding)
            }
            
            
           
            if !isEditing, donate.state == 0 {
                editButton(donateBinding)
                    .frame(width: 100)
            }
            
        }
        .listRowBackground(Color.clear)
            
        
    }
    
    private func editButton(_ donateBinding: Binding<PetDonate>) -> some View {

        NavigationLink {
            DonateEditView(donate: donateBinding.wrappedValue) { donate in
                donateBinding.wrappedValue = donate
            }
        } label: {
            Text("修改")
                .padding(.horizontal)
        }
        .buttonStyle(.bordered)
    }
}

struct DonateView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(selected: .donate)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
