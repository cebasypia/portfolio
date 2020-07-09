import Vue from 'vue'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import '@mdi/font/css/materialdesignicons.css' // Ensure you are using css-loader
import App from '../app.vue'
import router from './router.js'
import AsyncComputed from 'vue-async-computed'

Vue.use(Vuetify)
const vuetify = new Vuetify()
Vue.use(AsyncComputed)

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    vuetify,
    router,
    render: (h) => h(App),
  }).$mount()
  document.body.appendChild(app.$el)

  console.log(app)
})
