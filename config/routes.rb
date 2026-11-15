Rails.application.routes.draw do
 get '/health/live',to:'health#live'
 get '/ready',to:'health#ready'
resources :envelopes,only:[:create,:show]
post '/envelopes/:id/spends',to:'envelopes#spend'
end
