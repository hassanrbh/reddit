module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      animation: {
        'pulsate': 'pulsate 1s ease-in-out',
        'pulsate-slow': 'pulsate-slow 1s ease-in-out',
        'pulsate-gray': 'pulsate-gray 1s ease-in-out',
      }
    }
  }
}
