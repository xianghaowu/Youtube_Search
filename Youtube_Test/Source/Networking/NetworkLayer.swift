//
//  NetworkLayer.swift
//  YTSearch
//
//  Created by MeiXiang Wu on 7/11/22.
//

import Foundation

// MARK: - Data Type
enum DataType {
  case JSON
  case Data
}

enum ResponseType {
  case sucess
  case failure
}

// MARK: - Request configuration
protocol RequestProtocol {
  var path: String { get }
  var method: HTTPMethod { get }
  var parameters: RequestParams { get }
  var headers: [String: Any]? { get }
}

// MARK: - Response configuration
protocol ResponseProtocol {
  var data: Data? { get }
  var type: ResponseType { get }
}

// MARK: - HTTP method
enum HTTPMethod: String {
  case post = "POST"
  case get = "GET"
  case put = "PUT"
  case delete = "DELETE"
}

// MARK: - Parameters
enum RequestParams {
  case body([String: Any]?)
  case url([String: Any]?)
}

// MARK: - Environment
struct Environment {
  
  var httpProtocol: String
  var host: String
  var port: String
  
  var urlString: String {
    return httpProtocol + host + port
  }
}

protocol Dispatcher {
  
  init(environment: Environment)
  func fetch(request: RequestProtocol, success: @escaping (Response) -> Void, failure: @escaping (NSError) -> Void)
}

class Response: ResponseProtocol {

  // MARK: - Properties
  let request: RequestProtocol!
  var data: Data?
  var type: ResponseType
  
  // MARK: - Initialization
  init(data: Data?, request: RequestProtocol) {
    self.data = data
    self.request = request
    self.type = .sucess
  }
  
  func jsonData() -> [AnyHashable: Any]? {
    guard let responseData = data else { return nil }
    let jsonData = try? JSONSerialization.jsonObject(with: responseData, options: [])
    return jsonData as? [AnyHashable : Any]
  }
  
}


