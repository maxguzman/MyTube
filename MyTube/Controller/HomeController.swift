import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  var videos: [Video]?
  
  func fetchVideos() {
    guard let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json") else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if error != nil {
        print(error!)
        return
      }
      
      if let data = data {
        do {
          let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
          self.videos = [Video]()
          
          for dictionary in json as! [[String: Any]] {
            let video = Video()
            video.title = dictionary["title"] as? String
            video.thumbnailImage = dictionary["thumbnail_image_name"] as? String
            
            let channelDictionary =  dictionary["channel"] as! [String: Any]
            let channel = Channel()
            channel.name = channelDictionary["name"] as? String
            channel.profileImageName = channelDictionary["profile_image_name"] as? String
            video.channel = channel
            
            self.videos?.append(video)
          }
          
          DispatchQueue.main.async {
            self.collectionView?.reloadData()
          }
        } catch let jsonError {
          print(jsonError)
        }
      }
    }.resume()
  }
  
  let cellId = "cellId"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchVideos()
    
    navigationController?.navigationBar.isTranslucent = false
    
    let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
    titleLabel.text = "Home"
    titleLabel.textColor = .white
    titleLabel.font = UIFont.systemFont(ofSize: 20)
    navigationItem.titleView = titleLabel
   
    collectionView?.backgroundColor = .white
    collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
    collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
    
    setupMenuBar()
    setupNavBarButtons()
  }
  
  // MARK: menu bar
  
  let menuBar: MenuBar = {
    let mb = MenuBar()
    return mb
  }()
  
  private func setupMenuBar() {
    view.addSubview(menuBar)
    view.addConstraintWithFormat(format: "H:|[v0]|", views: menuBar)
    view.addConstraintWithFormat(format: "V:|[v0(50)]", views: menuBar)
  }
  
  private func setupNavBarButtons() {
    let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
    let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
    
    let moreImage = UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal)
    let moreButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
    navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
  }
  
  let settingsLauncher = SettingLauncher()
  
  @objc func handleMore() {
    //show menu
    settingsLauncher.showSettings()
  }
  
  @objc func handleSearch() {
    // TODO: (implement this)
    print("123")
  }
  
  // MARK: delegates
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return videos?.count ?? 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
    cell.video = videos?[indexPath.item]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = (view.frame.width - 16 - 16) * 9 / 16
    return CGSize(width: view.frame.width, height: height + 16 + 88)
  }
}

