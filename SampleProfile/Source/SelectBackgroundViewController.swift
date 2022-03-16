//
//  SelectBackgroundViewController.swift
//  SampleProfile
//
//  Created by eat.toyama003 on 2022/03/14.
//

import UIKit

protocol CatchBackgroundProtocol{
    func catchBackgroundProtocol(backgroundName: String)
}

class SelectBackgroundViewController: UIViewController {
    
    var backgroundNames: [String] = ["sa_pixar_virtualbg_incredibles2_16x9_149dbf8d.jpeg", "sa_pixar_virtualbg_toystory_16x9_8461039f.jpeg"]
    var selectedBackgroundName: String!
    var delegate: CatchBackgroundProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //完了ボタンがタップされた時
    @IBAction func tappedCompleteButton(_ sender: Any) {
        delegate?.catchBackgroundProtocol(backgroundName: selectedBackgroundName)
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

extension SelectBackgroundViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    //セルの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return backgroundNames.count
    }
    
    //セルの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        //識別子からイメージビューを宣言
        let imageView = cell.contentView.viewWithTag(1) as? UIImageView
        //画像を設定
        imageView?.image = UIImage(named: backgroundNames[indexPath.row])
        //imageViewをcellより少し小さくし、cellの真ん中に配置する
        let rect = CGRect(x: cell.frame.width * 0.05,y: cell.frame.height * 0.05, width: cell.bounds.width * 0.9, height: cell.bounds.height * 0.9)
        imageView?.frame = rect
        imageView?.contentMode = .scaleAspectFill
        return cell
    }
    
    //セルの大きさ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //正方形のセルの一辺の長さ
        let cellWidth: CGFloat = collectionView.bounds.width
        let cellHeight: CGFloat = collectionView.bounds.height / 6
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    //セル内のアイテムがタップされた時
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedBackgroundName = backgroundNames[indexPath.row]
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
