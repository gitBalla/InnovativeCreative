import SwiftUI

struct RecycleView: View {
    @State var isPresenting: Bool = false
    @State var uiImage: UIImage?
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @ObservedObject var classifier: ImageClassifier

    var body: some View {
        NavigationView {
                HStack{
                  Text("Scan")
                  Image(systemName: "camera.viewfinder")
                        .onTapGesture {
                            isPresenting = true
                            sourceType = .camera
                        }
                }
              .font(.largeTitle)
              .foregroundColor(.blue)
              .background(RoundedRectangle(cornerRadius: 4).stroke())
            .padding()
            .navigationTitle("Recycle")
        }
        
    }
}

struct RecycleView_Previews: PreviewProvider {
    static var previews: some View {
        RecycleView(classifier: ImageClassifier())
    }
}
