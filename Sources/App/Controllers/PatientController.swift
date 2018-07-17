//
//  PatientController.swift
//  App
//
//  Created by JHartl on 5/10/18.
//

import Foundation
import Vapor
import FluentMySQL

final class PatientController {
    
    func index(_ req: Request) throws -> Future<[Patient]> {
        print("GET")
        let  providerID = req.http.headers["providerID"].first ?? ""
        print(providerID)
        return Patient.query(on: req).filter(\.providerID == providerID).all().map({ (patients) -> ([Patient]) in
            print(patients)
            return patients
        })
    }
    
    /// Saves a decoded `Patient` to the database.
    func create(_ request: Request) throws -> HTTPResponse {
        print("POST")
        guard let data = request.http.body.data else { return HTTPResponse(status: .badRequest) }
        var json = [String : Any]()
        do {
            json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : Any]
            
        } catch {
            print(error)
            print("badRequest")
        }
        guard let patientID = json["patientID"] as? String else {
            print("patientID + \(json)")
            return HTTPResponse(status: .badRequest)
        }
        
        guard let providerID = json["providerID"] as? String else  {
            print("providerID + \(json)")
            return HTTPResponse(status: .badRequest)
        }
        
        guard let content = json["content"] as? Array<Int> else {
            print("byteData + \(json)")
            return HTTPResponse(status: .badRequest)
        }
        let currentIV = json["currentIV"] as? String
        let updated = json["updated"] as? String

        //Create New Patient
        let newPatient = Patient(patientID: patientID, providerID: providerID, currentIV: currentIV ?? "", updated: updated ?? "", content: content)
        newPatient.save(on: request)
        print("Successfully saved patient")
        return HTTPResponse(status: .accepted)
        
    }
    
    //TODO: Test to see if this works.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        print("DELETE")
        let  patientID = req.http.headers["patientID"].first ?? ""
        return Patient.query(on: req).filter(\.patientID == patientID).all().map({ (patient) in
            return patient.first?.delete(on: req)
        }).transform(to: .ok)
    }
    
    /// Deletes a parameterized `Todo`.
//    func delete(_ req: Request) throws -> Future<HTTPStatus> {
//        return try req.parameters.next(Patient.self).flatMap { patient in
//            return patient.delete(on: req)
//            }.transform(to: .ok)
//    }
}
