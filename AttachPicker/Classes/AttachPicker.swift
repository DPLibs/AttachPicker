import Foundation
import UIKit

// MARK: - AttachPicker
class AttachPicker: NSObject {
    
    // MARK: - Props
    weak var viewController: UIViewController?
    public var didSelect: ([AttachModel]) -> Void = { _ in }
    
    open func present(_ providers: Set<AttachProvider>, title: String? = nil, message: String? = nil, preferredStyle style: UIAlertController.Style = .actionSheet, completion: (() -> Void)? = nil) {
        guard !providers.isEmpty else { return }
        guard providers.count > 1 else {
            self.presentSinglePicker(providers.first)
            return
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        providers.forEach({ provider in
            let title = provider.title
            alert.addAction(UIAlertAction(title: title.text(provider), style: title.style, handler: { [weak self] _ in
                self?.presentSinglePicker(provider)
            }))
        })
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.present(alert, animated: true, completion: completion)
        }
    }
    
    open func presentSinglePicker(_ provider: AttachProvider?) {
        guard let provider = provider else { return }
        if let picker = provider.imagePicker {
            picker.delegate = self
            DispatchQueue.main.async { [weak self] in
                self?.viewController?.present(picker, animated: true, completion: nil)
            }
        } else if let picker = provider.documentPicker {
            picker.delegate = self
            DispatchQueue.main.async { [weak self] in
                self?.viewController?.present(picker, animated: false, completion: nil)
            }
        }
    }
    
}

// MARK: - UIDocumentPickerDelegate
extension AttachPicker: UIDocumentPickerDelegate {

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        let attachList = urls.map({ AttachModel(localUrl: $0) }) as? [AttachModel] ?? []
        self.didSelect(attachList)
    }

}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension AttachPicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        var attach: AttachModel?
        if let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            attach = AttachModel(localUrl: url)
        }
        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            attach = AttachModel(image: image)
        }
        else if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            attach = AttachModel(image: image)
        }
        if let attach = attach {
            self.didSelect([attach])
        }
        picker.dismiss(animated: true, completion: nil)
    }

}
