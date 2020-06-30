import Vue from 'vue'
import VueRouter from "vue-router"

import UsersIndexPage from './views/users/index.vue'
import UsersShowPage from './views/users/show.vue'
import UsersNewPage from './views/users/new.vue'
import TweetsIndexPage from './views/tweets/index.vue'
import TweetsSearchPage from './views/tweets/search.vue'

Vue.use(VueRouter)

const router = new VueRouter({
  routes: [
    { path: '/', name: 'TweetsIndexPage', component: TweetsIndexPage },
    { path: '/tweets/search', name: 'TweetsSearchPage', component: TweetsSearchPage },
    { path: '/users.index', component: UsersIndexPage },
    { path: '/users/:id(\\d+)', name: 'UsersShowPage', component: UsersShowPage },
    { path: '/users/new', name: 'UsersNewPage', component: UsersNewPage },
  ]
})

export default router