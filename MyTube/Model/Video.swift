import Foundation

class Video: NSObject {
  
  var thumbnailImage: String?
  var title: String?
  var numberOfViews: NSNumber?
  var uploadDate: NSDate?
  
  var channel: Channel?
  
}

class Channel: NSObject {
  
  var name: String?
  var profileImageName: String?
  
}
