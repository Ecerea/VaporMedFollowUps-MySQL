//
//  Patient.swift
//  App
//
//  Created by JHartl on 5/10/18.
//

typealias ByteData = Array<UInt8>

import Foundation
import Vapor
import FluentMySQL

final class Patient: MySQLModel {
    var id: Int?
    var patientID: String
    var providerID: String
    var currentIV: String
    var updated: String
    var content: ByteData
    
    init(id: Int? = nil, patientID: String, providerID: String, currentIV: String, updated: String, content: ByteData) {
        self.id = id
        self.patientID = patientID
        self.providerID = providerID
        self.currentIV = currentIV
        self.updated = updated
        self.content = content
    }
}

extension Patient: Migration { }

extension Patient: Content { }

extension Patient: Parameter { }


