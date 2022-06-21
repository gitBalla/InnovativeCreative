import SwiftUI

struct RecycleView: View {
    @State var isPresenting: Bool = false
    @State var uiImage: UIImage?
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var showingPopover = false
    
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
            
                RoundedRectangle(cornerRadius: 4)
                    .strokeBorder()
                    .foregroundColor(.white)
                    .overlay(
                        Group {
                            if uiImage != nil {
                                Image(uiImage: uiImage!)
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    )
            
                HStack{
                    Image(systemName: "arrow.3.trianglepath")
                        .foregroundColor(.green)
                        .font(.title)
                        .background(RoundedRectangle(cornerRadius: 4).stroke().fill())
                Group {
                    
                    if let imageClass = classifier.imageClass {
                        VStack{
                            HStack{
                            Text(imageClass)
                                .bold()
                                .frame(alignment: .leading)
                            
                                Button("More tips"){
                                showingPopover = true
                                }
                                    .foregroundColor(.blue)
                                    .padding()
                                    .font(.caption)
                                    .popover(isPresented:$showingPopover) {
                                        Text("Water bottle")
                                            .font(.headline)
                                            .padding()
                                    }
                            }
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
