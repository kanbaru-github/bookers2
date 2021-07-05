Rails.application.routes.draw do

 devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

 root to: 'homes#top'

 get'home/about' => 'homes#about'

 resources :users, only: [:show, :edit, :update, :create, :index] do
  get'relationships/follower' => 'relationships#follower'
 # 左側がURL 右側がアクション
 get'relationships/followed' => 'relationships#followed'
 end

 resources :books, only: [:create, :index, :show, :destroy, :edit, :update] do
   resource :favorites, only: [:create, :destroy]
   # このような親子関係を、「ネストする」と言います。
   # 単数にすると、そのコントローラのidがリクエストに含まれなくなります。
 end

 resources :books, only: [:new, :create, :index, :show, :destroy] do
 # 親のresourcesで指定したコントローラ名に、子のresourcesで指定したコントローラ名が続くURLが生成されるのが確認できます。
   resources :post_comments, only: [:create, :destroy]
 end

 post 'follow/:id' => 'relationships#follow', as: 'follow'
 post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'


get 'search', to: 'search#search'

end
