//
//  BreedsListProtocol.swift
//  Randog
//
//  Created by xu daitong on 7/15/21.
//

import Foundation

struct BreedsListProtocol: Codable{
    let status: String
    let message: [String:[String]]
}
