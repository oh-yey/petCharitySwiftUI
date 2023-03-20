//
//  DonateEditView.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/16.
//

import SwiftUI

struct DonateEditView: View {
    @Environment(\.dismiss) var dismiss
    

    var isEdit: Bool
    var donate: PetDonate?
    
    @FocusState var field: MyField?
    
    @State var title: String = ""
    @State var weight: Double = 0
    @State var birth: Date = Date()
    @State var amount: Int = 100
    @State var sex: Int = 0
    @State var race: Int = 0
    @State var breed: Int = 1
    @State var breedList0: [PetBreed] = []
    @State var breedList1: [PetBreed] = []
    @State var shouldShowbreedList0 = false
    @State var shouldShowbreedList1 = false
    
    @State var images: [PetImage] = []
    @State var description: String = ""
    
    
    @State var showingActionSheet = false
    @State var showCameraImagePicker = false
    @State var showPhotoLibraryImagePicker = false
    
    
    let onSubmit: ((PetDonate) -> Void)
    
    
    @State var showErrorAlert = false
    @State var message: String = ""
    
    init(donate: PetDonate? = nil, onSubmit: @escaping ((PetDonate) -> Void)) {
        self.donate = donate
        isEdit = donate != nil
        _title = State(initialValue: donate?.name ?? "")
        _weight = State(initialValue: donate?.weight ?? 0)
        _birth = State(initialValue: string2Date(donate?.birth ?? "") ?? Date())
        _amount = State(initialValue: donate?.amount ?? 0)
        _sex = State(initialValue: donate?.sex ?? 0)
        _race = State(initialValue: donate?.breed.race ?? 0)
        _breed = State(initialValue: donate?.breed.id ?? 1)

        _images = State(initialValue: donate?.images ?? [])
        _description = State(initialValue: donate?.description ?? "")
        self.onSubmit = onSubmit

    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    leftView
                        .frame(width: geometry.size.width * 0.4, height: geometry.size.height)
                        .background(Color("CardBg"))
                    
                    rightView
                        .frame(width: geometry.size.width * 0.6, height: geometry.size.height)
                        .background(Color("AppBg2"))
                }
            }
        }
        .cornerRadius(12)
        .padding()
        .padding()
        .background(Color("AppBg"))
        .navigationTitle(isEdit ? "修改众筹" : "添加众筹")
    } 
    
}

struct DonateEditView_Previews: PreviewProvider {
    static var previews: some View {
        DonateEditView(){ _ in
            
        }
        .previewInterfaceOrientation(.landscapeLeft)
    }
}

