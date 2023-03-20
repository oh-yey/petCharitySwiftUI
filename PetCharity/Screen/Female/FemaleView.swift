//
//  FemaleView.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/9.
//

import SwiftUI

// MARK: - 用户反馈
struct FemaleView: View {
    
    @State private var shouldShow = false
    @State private var feedbackList = [Feedback]()
    @State private var sortOrder = [KeyPathComparator(\Feedback.createTime)]
    
    @State private var searchText = ""
    
    
    @State private var sheet: DetailSheet?
    
    @State private var showingAlert = false
    @State private var selectedFeedback: Feedback?
    
    @State private var page = 1
    @State private var pageCount = 1
    
    
    var body: some View {
        VStack {
            
            SearchTopView() { content in
                searchText = content
                loadingData()
            }
            
            
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    if shouldShow {
                        tableView
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
        .task {
            loadingData()
        }
        
    }
    
    private func loadingData() -> Void {
        UserApi.feedbackList(searchText, page: page) { result in
            switch result {
            case let .success(data):
                withAnimation {
                    feedbackList = data.results
                    shouldShow = true
                    pageCount =  (data.count - 1) / 5 + 1
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
}

// MARK: - 子View
private extension FemaleView {
    @ViewBuilder private var tableView : some View {
        
        HStack {
            Text("用户反馈")
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
        }
        
        
        Table(feedbackList, sortOrder: $sortOrder) {
            
            TableColumn("评级", value: \.score) { item in
                HStack(spacing: 0) {
                    Text("")
                    ForEach(0..<item.score, id: \.self) { _ in
                        SFSymbol.startFill
                            .foregroundColor(Color("Start"))
                    }
                    ForEach(item.score..<5, id: \.self) { _ in
                        SFSymbol.start
                            .foregroundColor(.gray)
                            .opacity(0.5)
                    }
                }
            }
            
            TableColumn("用户昵称", value: \.nickname)
            
            TableColumn("评论") { item in
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .fontWeight(.bold)
                        .lineLimit(3)
                    Text(item.content)
                        .lineLimit(3)
                }
                .padding(.trailing)
            }
            .width(min: 220, max: 300)
            
            TableColumn("发布时间", value: \.createTime) {
                Text(django2String($0.createTime, dateFormat: "yyyy-MM-dd"))
            }
            
            TableColumn("操作") { item in
                HStack(spacing: 24) {
                    SFSymbol.look
                        .font(.title2)
                        .onTapGesture {
                            sheet = .feedbackDetail(item)
                        }
                    SFSymbol.del
                        .font(.title2)
                        .onTapGesture {
                            selectedFeedback = item
                            showingAlert = true
                        }
                }
                .padding(.trailing)
            }
        }
        .scrollContentBackground(.hidden)
        .onChange(of: sortOrder) { newOrder in
            feedbackList.sort(using: newOrder)
        }
        .sheet(item: $sheet) { $0 }
        .alert(isPresented:$showingAlert) {
            Alert(
                title: Text("您确定要删除吗?"),
                message: Text("此操作无法撤销"),
                primaryButton: .destructive(Text("删除"), action: delFeedbackById),
                secondaryButton: .cancel()
            )
        }
    }
    
    private func delFeedbackById() {
        if let id = selectedFeedback?.id {
            UserApi.delFeedbackById(id) { isSuccess in
                if isSuccess {
                    //
                    loadingData()
                } else {
                    //
                }
            }
        }
    }
}

struct FemaleView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(selected: .female)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
