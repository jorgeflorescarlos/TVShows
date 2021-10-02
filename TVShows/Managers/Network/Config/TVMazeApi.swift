    //
    //  TVMazeApi.swift
    //  TVShows
    //
    //  Created by Jorge Flores Carlos on 30/09/21.
    //

import Foundation

struct TVMazeApi {
    static let BASEURL = "https://api.tvmaze.com/"
    enum APIError {
        case failedToGetData
        case failedToManageLocalData
    }
    
    
}

extension TVMazeApi.APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedToGetData:
            return NSLocalizedString("Ocurrió un error al consultar el servicio. ¿Quieres intentar nuevamente?", comment: "Request failed to get data")
            
        case .failedToManageLocalData:
            return NSLocalizedString("Hubo un problema al guardar/borrar este show de TV. ¿Quieres intentar nuevamente?", comment: "Request failed to get data")
        }
    }
}
