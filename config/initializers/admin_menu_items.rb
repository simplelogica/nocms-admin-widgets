NoCms::Admin.menu_items << {
  name: 'widgets',
  url: proc { NoCms::Admin::Widgets::Engine.routes.url_helpers.widgets_path }
}
