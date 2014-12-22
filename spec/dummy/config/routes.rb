Rails.application.routes.draw do

  mount NoCms::Admin::Engine => "/admin"
  mount NoCms::Admin::Widgets::Engine => "/admin"

end
