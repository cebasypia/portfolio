import Vue from 'vue'
import VueRouter from 'vue-router'

import UsersIndexPage from './views/users/index.vue'
import UsersLoginPage from './views/users/login.vue'
import UsersShowPage from './views/users/show.vue'
import UsersNewPage from './views/users/new.vue'
import UsersEditPage from './views/users/edit.vue'
import TweetsIndexPage from './views/tweets/index.vue'
import TweetsSearchPage from './views/tweets/search.vue'
import TweetsShowPage from './views/tweets/show.vue'
import TweetsUserPage from './views/tweets/user.vue'

Vue.use(VueRouter)

const router = new VueRouter({
  routes: [
    {
      path: '/',
      name: 'TweetsIndexPage',
      component: TweetsIndexPage,
      props: true,
    },
    {
      path: '/tweets/search',
      name: 'TweetsSearchPage',
      component: TweetsSearchPage,
    },
    {
      path: '/tweets/:id(\\d+)',
      name: 'TweetsShowPage',
      component: TweetsShowPage,
    },
    {
      path: '/tweets/user/:id(\\d+)',
      name: 'TweetsUserPage',
      component: TweetsUserPage,
    },
    { path: '/users.index', component: UsersIndexPage },
    {
      path: '/login',
      name: 'UsersLoginPage',
      component: UsersLoginPage,
    },
    {
      path: '/users/:id(\\d+)',
      name: 'UsersShowPage',
      component: UsersShowPage,
    },
    { path: '/users/new', name: 'UsersNewPage', component: UsersNewPage },
    { path: '/users/edit', name: 'UsersEditPage', component: UsersEditPage },
  ],
})

export default router
