//
//  SelectIconViewController.swift
//  SampleProfile
//
//  Created by eat.toyama003 on 2022/03/12.
//

import UIKit

protocol CatchIconNameProtocol{
    func catchIconName(iconName: String)
}

class SelectIconViewController: UIViewController {
    
    @IBOutlet weak var iconCollectionView: UICollectionView!
    
    //インポート済みのアイコン画像の名前一覧
    let iconNames: [String] = ["icon_psyduck.png", "icon_eevee.png", "icon_squirtle.png"]
    
    //選択中のアイコン画像
    var selectedIconName: String = "None"
    
    var delegate: CatchIconNameProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //iconCollectionView.isScrollEnabled = false
        
        // Do any additional setup after loading the view.
    }
    
    //完了ボタンを押したとき、元の画面へ戻る
    @IBAction func tappedCompleteButton(_ sender: Any) {
        delegate?.catchIconName(iconName: selectedIconName)
        dismiss(animated: true, completion: nil)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension SelectIconViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    //セルの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        //候補のアイコン画像をセルに設定
        let iconImageView = cell.contentView.viewWithTag(1) as! UIImageView
        iconImageView.image = UIImage(named: iconNames[indexPath.row])
        
        return cell
    }
    
    //UICollectionViewDelegateFlowLayoutの継承で実装可能
    //cellの大きさを変更する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //アイテム間のスペース
        let horizontalSpace: CGFloat = 5
        //正方形のセルの一辺の長さ
        let cellSize: CGFloat = collectionView.bounds.width / 3 - horizontalSpace * 2
        
        return CGSize(width: cellSize, height: cellSize)
    }
    
    //セル内のアイテムがタップされた時
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIconName = iconNames[indexPath.row]
        let selectedCell = collectionView.cellForItem(at: indexPath)!
        //一度全てのセルの背景色を戻す
        for cell in collectionView.subviews{
            cell.backgroundColor = .none
        }
        //選択中の画像をもつセルの背景色を変える
        selectedCell.backgroundColor = .darkGray
        //アニメーションの再生
        animateView(selectedCell)
    }
    
    //タップした時にポヨヨンとするアニメーション
    func animateView(_ viewToAnimate:UIView) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 1.08, y: 1.08)
        }) { (_) in
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: .curveEaseOut, animations: {
                viewToAnimate.transform = .identity
                
            }, completion: nil)
        }
    }
}
