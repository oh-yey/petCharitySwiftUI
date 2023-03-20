//
//  FemaleDetailSheet.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/12.
//

import SwiftUI


extension FemaleView {
    
    struct FemaleDetailSheet: View {
        
        let feedback: Feedback
        
        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                
                HStack(spacing: 0) {
                    Text(feedback.title)
                        .font(.title)
                    Spacer()
                    ForEach(0..<feedback.score , id: \.self) { _ in
                        SFSymbol.startFill
                            .foregroundColor(Color("Start"))
                    }
                    ForEach(feedback.score..<5, id: \.self) { _ in
                        SFSymbol.start
                            .foregroundColor(.gray)
                            .opacity(0.5)
                    }
                }
                
                
                Text(feedback.content)
                    .font(.body)
                
                Spacer()
                
                HStack {
                    Spacer()
                    VStack(alignment: .leading,spacing: 12) {
                        Text(feedback.nickname)
                        Text(django2String(feedback.createTime, dateFormat: "yyyy-MM-dd"))
                    }
                }
            }
            .padding()
            .padding()
            .background(Color("CardBg"))
        }
    }
}

