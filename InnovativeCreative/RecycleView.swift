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
            
            
                HStack{
                    Image(systemName: "arrow.3.trianglepath")
                        .foregroundColor(.green)
                        .font(.title)
                Group {
                    
                    if let imageClass = classifier.imageClass {
                        VStack{
                            Text("")
                                .font(.caption)
                            Text(imageClass)
                                .bold()
                            if imageClass == "water bottle" {
                                Text("Recycle water bottles by placing it in the yellow lid bin.")
                            }
                        }
                    } else {
                        HStack{
                            Text("Scan, Recycle, Repeat!")
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
