//
//  ItemModel.swift
//  Youtube_Test
//
//  Created by MeiXiang Wu on 7/11/22.
//

import ObjectMapper

class ItemModel {

  var kind: String?
  var videoId: String?
  var snippet: SnippetModel?
  var detail: ContentDetaiModel?
  
  required convenience init?(map: Map) {
    self.init()
  }
}

extension ItemModel: Mappable {
  
  // MARK: - Mapping
  func mapping(map: Map) {
    videoId <- map["id.videoId"]
    kind    <- map["id.kind"]
    detail  <- map["contentDetails"]
    snippet <- map["snippet"]
  }
  
  // MARK: - Deserialize
  class func deserialize(with response: Response) -> [ItemModel]? {
    
    // Get JSON
    guard let jsonData = response.jsonData(),
      let jsonItems = jsonData["items"] as? [[String: Any]] else {
        return nil
    }
    // Create JSON
    let itemsModel = Mapper<ItemModel>().mapArray(JSONArray: jsonItems)
    return itemsModel
  }
}
