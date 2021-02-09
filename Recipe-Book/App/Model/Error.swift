//
//  Error.swift
//  Recipe-Book
//
//  Created by Сергей Куклин on 15.10.2020.
//

import Foundation

enum JSONErrors: Error {
    case marshalJSONError
    case unmarshalJSONError
}
