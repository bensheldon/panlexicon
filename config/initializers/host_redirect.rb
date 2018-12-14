Rails.application.config.middleware.use Rack::HostRedirect, {
  'panlexicon.herokuapp.com' => 'panlexicon.com',
  'beta.panlexicon.com' => 'panlexicon.com',
}
