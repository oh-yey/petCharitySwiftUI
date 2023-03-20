//
//  SystemDataModel.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/7.
//

import UIKit

class SystemDataModel: ObservableObject {

    var boundsSize: CGRect {
        UIScreen.main.bounds
    }

    var width: CGFloat {
        boundsSize.width
    }

    var height: CGFloat {
        boundsSize.height
    }

//    var frameHeight: CGFloat {
//        UIScreen.main!.frame.height
//    }
}
