root "static_pages#home"

# Team page
get '/team', to: 'static_pages#team'

# Contact page
get '/contact', to: 'static_pages#contact'

# Landing page
get '/welcome/:first_name', to: 'static_pages#welcome'