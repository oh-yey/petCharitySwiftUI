//
//  DonateSheet.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/12.
//

import SwiftUI

enum DetailSheet: Identifiable, View {
    case donateDetail(Binding<PetDonate>)
    case feedbackDetail(Feedback)
    
    var id: String {
        switch self {
        case .donateDetail(let donate):
            return "donateDetail\(donate.id)"
        case .feedbackDetail(let feedback):
            return "feedbackDetail\(feedback.id)"
        }
    }
    
    var body: some View {
        switch self {
        case .donateDetail(let donate):
            DonateView.DonateDetailSheet(donate: donate)
        case .feedbackDetail(let feedback):
            FemaleView.FemaleDetailSheet(feedback: feedback)
            
        }
    }
}



