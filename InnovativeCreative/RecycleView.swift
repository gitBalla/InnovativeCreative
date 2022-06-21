import SwiftUI

struct RecycleView: View {
    @State var isPresenting: Bool = false
    @State var uiImage: UIImage?
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @ObservedObject var classifier: ImageClassifier

    var body: some View {
        NavigationView {
            VStack{
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
            
            
            
            VStack{
                Button(action: {
                    if uiImage != nil {
                        classifier.detect(uiImage: uiImage!)
                    }
                }) {
                    Image(systemName: "arrow.3.trianglepath")
                        .foregroundColor(.green)
                        .font(.title)
                }
                
                
                Group {
                    if let imageClass = classifier.imageClass {
                        HStack{
                            Text("Image categories:")
                                .font(.caption)
                            Text(imageClass)
                                .bold()
                        }
                    } else {
                        HStack{
                            Text("Image categories: NA")
                                .font(.caption)
                        }
                    }
                }
                .font(.subheadline)
                .padding()
                
            }
            }
        }
        
        .sheet(isPresented: $isPresenting){
            ImagePicker(uiImage: $uiImage, isPresenting:  $isPresenting, sourceType: $sourceType)
                .onDisappear{
                    if uiImage != nil {
                        classifier.detect(uiImage: uiImage!)
                    }
                }
            
        }
    }
}

struct RecycleView_Previews: PreviewProvider {
    static var previews: some View {
        RecycleView(classifier: ImageClassifier())
    }
}
