Callinwithus::Application.routes.draw do
  resources :conference_calls, :only => [ :new, :create, :show ]
  post 'twilio/call' => 'twilio#call'
  post 'twilio/call_with_code' => 'twilio#call_with_code'
  root :to => 'conference_calls#new'
end
