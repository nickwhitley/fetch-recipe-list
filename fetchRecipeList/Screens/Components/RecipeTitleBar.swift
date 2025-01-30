import SwiftUI

struct RecipeTitleBar: View {
    @Environment(RecipeListViewModel.self) var viewModel
    @State var toolBarVisible: Bool = false
    @State var searchText: String = ""
    //used to disable buttons and search field during animation
    @State var isAnimating: Bool = false
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 0) {
                Text("Recipes")
                    .font(.title)
                    .bold()
                    .frame(alignment: .top)
                    .padding(.horizontal)
                Spacer()
                if toolBarVisible {
                    SortBar()
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                }
                SearchSortButton()
                    .padding(.horizontal)
            }
            if toolBarVisible {
                @Bindable var bindingVm = viewModel
                SearchField(text: $bindingVm.searchText)
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .dynamicTypeSize(.xLarge)
    }
    
    func SearchSortButton() -> some View {
        Button( action: {
            isAnimating = true
            withAnimation {
                toolBarVisible.toggle()
            }
            isAnimating = false
        }, label: {
            if toolBarVisible {
                Image(systemName: "xmark").foregroundStyle(.black)
            } else {
                HStack(spacing: 0) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.black)
                    Image(systemName: "arrow.up.arrow.down")
                        .foregroundStyle(.black)
                }
            }
        })
    }
    
    func SortBar() -> some View {
        HStack(spacing: 15) {
            NameSortButton()
            CuisineSortButton()
        }
        .minimumScaleFactor(0.6)
    }
    
    func SearchField(text: Binding<String>) -> some View {
        TextField(text: text, label: {
            Image(systemName: "magnifyingglass")
        })
        .padding(7)
        .background(.white)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.black, lineWidth: 2)
        )
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .frame(height: 25)
        .padding(.horizontal)
        .padding(.bottom)
        .submitLabel(.done)
        .disabled(isAnimating)
        
    }
    
    func NameSortButton() -> some View {
        Button(action: {
            viewModel.sortRecipesByName()
        }, label: {
            Text("Name")
                .lineLimit(1)
            switch viewModel.nameSort {
            case .none:
                Image(systemName: "circlebadge")
            case .descending:
                Image(systemName: "arrow.down")
            case .ascending:
                Image(systemName: "arrow.up")
            }
        })
        .disabled(isAnimating)
        .foregroundStyle(.black)
    }
    
    func CuisineSortButton() -> some View {
        Button(action: {
            viewModel.sortRecipesByCuisine()
        }, label: {
            Text("Cuisine")
                .lineLimit(1)
            switch viewModel.cuisineSort {
            case .none:
                Image(systemName: "circlebadge")
            case .descending:
                Image(systemName: "arrow.down")
            case .ascending:
                Image(systemName: "arrow.up")
            }
            
        })
        .disabled(isAnimating)
        .foregroundStyle(.black)
    }
}

#Preview {
    RecipeTitleBar()
        .addEnvironments()
}


