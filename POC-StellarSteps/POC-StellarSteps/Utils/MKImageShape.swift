import SwiftUI
import Vision

struct MKImageShape: InsettableShape {
    var insetAmount = 0.0
    let inputImage: UIImage // Agora aceitamos qualquer UIImage

    var trimmedImage: UIImage {
        // Verifica se a imagem é válida
        guard let cgRef = inputImage.cgImage else {
            fatalError("Could not get cgImage!")
        }
        
        // Cria uma nova imagem a partir do cgRef
        let imgB = UIImage(cgImage: cgRef, scale: inputImage.scale, orientation: inputImage.imageOrientation)
        
        // Renderiza a imagem em um fundo branco
        let resultImage = UIGraphicsImageRenderer(size: imgB.size).image { ctx in
            UIColor.white.setFill()
            ctx.fill(CGRect(origin: .zero, size: imgB.size))
            imgB.draw(at: .zero)
        }
        
        return resultImage
    }
    
    func path(in rect: CGRect) -> Path {
        // Obtemos o caminho da imagem de entrada
        let inputImage = self.trimmedImage
        guard let cgPath = detectVisionContours(from: inputImage) else { return Path() }
        
        let scW: CGFloat = (rect.width - CGFloat(insetAmount)) / cgPath.boundingBox.width
        let scH: CGFloat = (rect.height - CGFloat(insetAmount)) / cgPath.boundingBox.height
        
        // Inverte o espaço Y
        var transform = CGAffineTransform.identity
            .scaledBy(x: scW, y: -scH)
            .translatedBy(x: 0.0, y: -cgPath.boundingBox.height)
        
        if let imagePath = cgPath.copy(using: &transform) {
            return Path(imagePath)
        } else {
            return Path()
        }
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }
    
    func detectVisionContours(from sourceImage: UIImage) -> CGPath? {
        let inputImage = CIImage(cgImage: sourceImage.cgImage!)
        let contourRequest = VNDetectContoursRequest()
        contourRequest.revision = VNDetectContourRequestRevision1
        contourRequest.contrastAdjustment = 1.0
        contourRequest.maximumImageDimension = 512
        
        let requestHandler = VNImageRequestHandler(ciImage: inputImage, options: [:])
        try! requestHandler.perform([contourRequest])
        if let contoursObservation = contourRequest.results?.first {
            return contoursObservation.normalizedPath
        }
        
        return nil
    }
}
