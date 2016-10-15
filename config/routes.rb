Rails.application.routes.draw do
  post 'translate', to: 'translator#translate'
  get 'translate', to: 'translator#translate'
end
