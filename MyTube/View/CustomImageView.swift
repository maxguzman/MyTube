import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
  var imageUrlString: String?
  
  func loadImageUsing(urlString: String) {
    
    imageUrlString = urlString
    guard let url = URL(string: urlString) else { return }
    image = nil
    
    if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) {
      self.image = (imageFromCache as! UIImage)
      return
    }
    
    URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
      if error != nil {
        print(error!)
        return
      }
      
      if let data = data {
        DispatchQueue.main.async {
          guard let imageToCache = UIImage(data: data) else { return }
          if self.imageUrlString == urlString {
            self.image = imageToCache
          }
          
          imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
        }
      }
    }).resume()
  }
}

