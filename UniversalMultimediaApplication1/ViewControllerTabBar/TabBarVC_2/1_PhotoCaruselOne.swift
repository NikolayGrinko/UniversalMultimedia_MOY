//
//  PhotoCaruselOne.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 21.01.2025.
//

import UIKit

func degreeToRadians (deg:CGFloat) -> CGFloat {
    return (deg * CGFloat.pi) / 180
}

class PhotoCaruselOne: UIViewController {
    
    private var photoLabel: UILabel = {
        let photoLab = UILabel()
        photoLab.text = "Фото КАРУСЕЛЬ"
        photoLab.textColor = .systemBlue
        photoLab.numberOfLines = 2
        photoLab.textAlignment = .center
        photoLab.font = .systemFont(ofSize: 20, weight: .semibold, width: .standard)
        photoLab.frame = CGRect(x: 140, y: 60, width: 120, height: 55)
        return photoLab
    }()
    
    let transformLayer = CATransformLayer()
    var currentAngle: CGFloat = 0
    var currentOffSet: CGFloat = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientView()
        
        view.addSubview(photoLabel)
        
        transformLayer.frame = self.view.bounds
        view.layer.addSublayer(transformLayer)
        
        // Здесь заменить на загрузку и отображение фото
        for i in 1...6 {
            addImageCard(name: "\(i)")
            turnCarusel()
        }
        
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(PhotoCaruselOne.performPanAction(recognizer: )))
        self.view.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    private func gradientView() {
        view.applyGradient(colors: [.customBlue, .customGreen],
                                   startPoint: CGPoint(x: 0.0, y: 0.0),
                                   endPoint: CGPoint(x: 1.0, y: 1.0))
    }
    
    func addImageCard (name: String) {
        let imageCardSize = CGSize(width: 200, height: 300)
        
        
        let imageLayer = CALayer()
        imageLayer.frame = CGRect(
            x: view.frame.size.width / 2 - imageCardSize.width / 2,
            y: view.frame.size.height / 2 - imageCardSize.height / 2,
            width: imageCardSize.width,
            height: imageCardSize.height)
        imageLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        guard let imageCardImage = UIImage(named: name)?.cgImage else {return}
        
        imageLayer.contents = imageCardImage
        imageLayer.contentsGravity = .resizeAspectFill
        imageLayer.masksToBounds = true
        imageLayer.isDoubleSided = true
        
        imageLayer.borderColor = UIColor(white: 1, alpha: 0.5).cgColor
        imageLayer.borderWidth = 5
        imageLayer.cornerRadius = 10
        
       transformLayer.addSublayer(imageLayer)
    }
    
    func turnCarusel() {
        guard let transformSublayer = transformLayer.sublayers else {return}
        
        let segmentForImageCard = CGFloat(360 / transformSublayer.count)
        
        var angleOffset = currentAngle
        
        for layer in transformSublayer {
            var transform = CATransform3DIdentity
            transform.m34 = -1 / 500
            transform = CATransform3DRotate(transform, degreeToRadians(deg: angleOffset), 0, 1, 0)
            transform = CATransform3DTranslate(transform, 0, 0, 200)
            
            CATransaction.setAnimationDuration(0)
            
            layer.transform = transform
            
            angleOffset += segmentForImageCard
        }
    }
    
    @objc
    func performPanAction (recognizer: UIPanGestureRecognizer) {
        let xOffset = recognizer.translation(in: self.view).x
        
        if recognizer.state == .began {
            currentOffSet = 0
        }
        
        let xDiff = xOffset * 0.6 - currentOffSet
        
        currentOffSet += xDiff
        currentAngle += xDiff
        
        turnCarusel()
    }
}
