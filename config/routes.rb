Rails.application.routes.draw do

 # Railsのルーティングは、ルーティングファイルの上からの記載順に読み込まれる

 devise_for :users
 # モデル名を指定すると認証に必要なルーティングを自動で設定してくれます。
 # この記述の追加と同時にマイグレーションファイルも作成されます。

 root to: 'homes#top'

 get '/homes/about', to: 'homes#about'
 # 現在のパスはhomes_about_path,, as: "about"をつけて名前付きパスにするとabout_pathになる

 resources :users, only: [:index, :show, :edit, :update] do
   # only ↔︎ except以外という意味.今回ならnew,create,destroy
  	resource :relationships, only: [:create, :destroy]
  	get 'followings', to: 'relationships#followings', as: 'followings'
  	# 左側がURL 右側がcontroller#action
  	get 'followers', to:  'relationships#followers', as: 'followers'
  	get "search", to: "users#search"
 end

 resources :books, only: [:create, :index, :show, :destroy, :edit, :update] do
  resource :favorites, only: [:create, :destroy]
  # このような親子関係を、「ネストする」と言う
  # 単数にすると、そのコントローラのidがリクエストに含まれなくなる
  resources :post_comments, only: [:create, :destroy]
  resource :relationships, only: [:create, :destroy]
   get 'followings', to: 'relationships#followings', as: 'followings'
   get 'followers', to: 'relationships#followers', as: 'followers'
 end

 resources :groups, except: [:destroy]

 # get '/search', to: 'searches#search'

 get '/search', to: 'homes#search'


end
