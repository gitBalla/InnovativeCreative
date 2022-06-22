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
                    Text("♻️")
                        .foregroundColor(.green)
                        .font(.title)
                        .background(RoundedRectangle(cornerRadius: 4).stroke().fill())
                Group {
                    
                    if let imageClass = classifier.imageClass {
                        VStack{
                            HStack{
                            Text(imageClass)
                                    .font(.title)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                                Button("More tips"){
                                showingPopover = true
                                }
                                    .foregroundColor(.blue)
                                    .padding()
                                    .font(.caption)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .popover(isPresented:$showingPopover) {
                                        VStack{
                                        HStack{
                                            Image(systemName: "drop.circle")
                                                .foregroundColor(.blue)
                                                .font(.title)
                                            Text("Water bottle")
                                            .font(.largeTitle)
                                            .padding()
                                        }
                                            HStack{
                                                Text ("♻️")
                                                    .font(.largeTitle)
                                                Text ("Recycle water bottles by placing it in the yellow lid bin.")
                                                    .padding()
                                                    .font(.headline)
                                            }
                                            HStack{
                                                Text ("🌵")
                                                    .font(.largeTitle)
                                            Text ("Empty out any remaining liquid to avoid contamination during recycling.")
                                                .padding()
                                                .font(.headline)
                                            }
                                            HStack{
                                                Text ("💪")
                                                    .font(.largeTitle)
                                            Text ("Crush plastic bottles to ensure that more items can be recycled.")
                                                .padding()
                                                .font(.headline)
                                            }
                                            HStack{
                                                Text ("🍾")
                                                    .font(.largeTitle)
                                            Text("Remove lids and labels, this may vary depending on your local council.")
                                                .padding()
                                                .font(.headline)
                                            }
                                        }
                                    }
                            }
                            if imageClass == "water bottle" {
                                Text("Recycle water bottles by placing it in the yellow lid bin.")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                            }
                            
                        }
                    } else {
                        HStack{
                            Text("Scan, Recycle, Repeat!")
                                .font(.body)
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
