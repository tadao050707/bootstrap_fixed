Rails.application.routes.draw do

  root 'fixed_costs#index'
  resources :fixed_costs

  devise_for :users

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
