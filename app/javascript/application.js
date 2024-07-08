// // Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails"
// import "controllers"
// // app/assets/javascripts/application.js

// // app/javascript/packs/application.js
// import { Application } from "stimulus";
// import { definitionsFromContext } from "stimulus/webpack-helpers";

// const application = Application.start();
// const context = require.context("../controllers", true, /\.js$/);
// application.load(definitionsFromContext(context));

// app/javascript/packs/application.js
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
// app/assets/javascripts/application.js
