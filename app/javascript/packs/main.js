import Vue from 'vue'
import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css";
import App from '../app.vue'
import router from './router.js'

Vue.use(Vuetify);
const vuetify = new Vuetify();

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    vuetify,
    router,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log(app)
})
