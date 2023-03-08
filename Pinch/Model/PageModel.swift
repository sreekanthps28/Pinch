//
//  PageModel.swift
//  Pinch
//
//  Created by SREEKANTH PS on 08/03/2023.
//

import Foundation
struct Page:Identifiable{
    var id:Int
    var imageName:String
}
extension Page{
    var thumbnail: String{
        return "thumb-" + imageName
    }
}
