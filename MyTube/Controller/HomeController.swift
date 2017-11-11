import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  let cellId = "cellId"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
  }
  
  let menuBar: MenuBar = {
    let mb = MenuBar()
    return mb
  }()
  
  private func setupMenuBar() {
    view.addSubview(menuBar)
    view.addConstraintWithFormat(format: "H:|[v0]|", views: menuBar)
    view.addConstraintWithFormat(format: "V:|[v0(50)]", views: menuBar)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = (view.frame.width - 16 - 16) * 9 / 16
    return CGSize(width: view.frame.width, height: height + 16 + 68)
  }
}

