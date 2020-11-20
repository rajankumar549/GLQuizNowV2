Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root "application#hello"
  root 'question#list'
  get 'question/new', to: 'question#new'
  post 'question/new', to: 'question#add_question'
  get 'question/list', to: 'question#list'
  get 'question/edit/:id', to: 'question#edit'
  post 'question/update/:id', to: 'question#update'

  get 'testpaper/list', to: 'test_paper#list'
  get 'testpaper/new', to: 'test_paper#new'
  post 'testpaper/new', to: 'test_paper#add_test_paper'

  get 'testpaper/edit/:id', to: 'test_paper#edit'
  post 'testpaper/update/:id', to: 'test_paper#update'

  get 'exam/start/:id', to:'exam#show_exam'
  post 'exam/evaluate/:id', to:'exam#evaluate'
end
