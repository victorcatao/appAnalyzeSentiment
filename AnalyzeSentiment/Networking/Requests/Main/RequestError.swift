//
//  ErrorFeedback.swift
//  AnalyzeSentiment
//
//  Created by Victor Catão on 21/03/20.
//  Copyright © 2020 Victor Catão. All rights reserved.
//

// Enum with the possible errors that might happens during the request response
enum RequestError: Error {
    case unknownReason
    case sessionExpired
    case noInternetConnection
    case failure(reason:String?, code:String?, devReason: String?)
}

// As RequestError is an instance of error, we parse the errors response to RequestError and get the
// possible messages
extension Error {
    
    /// Returns the error message for the RequestError
    var requestMessage: String {
        return getReason()
    }
    
    /// Returns the error code for the RequestError
    var requestCode: String {
        return getCode()
    }
    
    /// Checks if the error is instance of RequestError and returns the message related to it
    private func getReason() -> String {
        guard let requestError = self as? RequestError else{
            return ""
        }
        switch requestError {
            case .failure(let reason, _, _):
                return reason ?? "unknownError".localized
            case .noInternetConnection:
                return "requestErrorNoConnection".localized
            case .sessionExpired:
                return "requestErrorSessionExpired".localized
            default:
                return "unknownError".localized
        }
    }
    
    /// Checks if the error is instance of RequestError and returns the code related to it
    private func getCode() -> String {
        guard let requestError = self as? RequestError else {
            return ""
        }
        switch requestError {
            case .failure(_, let code, _):
                return code ?? ""
            default:
                return ""
        }
    }
}
/// Class responsible for decoding the errors from the server
class ErrorFeedback:Codable {
    
    // MARK: - Variables
    // The code and message of the error
    var code: String?
    var message: String?
    
    // Indicate if there is any error available
    var hasError: Bool {
        get{
            guard let msg = message else { return false }
            return !msg.isEmpty
        }
    }
    
    // MARK: - CodingKeys
    private enum CodingKeys: String, CodingKey {
        case code    = "code"
        case message = "message"
    }
    
    // MARK: - Inits
    init(){
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code    = try? container.decode(String.self, forKey: .code)
        message = try? container.decode(String.self, forKey: .message)
    }
}
