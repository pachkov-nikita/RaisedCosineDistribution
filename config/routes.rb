Rails.application.routes.draw do
  root 'pages#index'

  post "pages/result"

  post 'pages/save_result'

end
