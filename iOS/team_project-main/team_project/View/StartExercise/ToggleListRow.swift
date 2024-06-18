






import SwiftUI

struct ToggleListRow: View {
    var body: some View {
        NavigationStack {
            List {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            .navigationTitle("리스트")
            .toolbar(.visible, for: .bottomBar)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button("Show") {
                            print("hi")
                        }
                    }.frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
        
    }
}

#Preview {
    ToggleListRow()
}
