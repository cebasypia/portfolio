import Vue from 'vue'
import VueRouter from 'vue-router'

import store from './store.js'

import NotFound from './views/notFound.vue'
import UsersLoginPage from './views/users/login.vue'
import UsersShowPage from './views/users/show.vue'
import UsersNewPage from './views/users/new.vue'
import UsersEditPage from './views/users/edit.vue'
import TweetsIndexPage from './views/tweets/index.vue'
import TweetsSearchPage from './views/tweets/search.vue'
import TweetsShowPage from './views/tweets/show.vue'
import TweetsUserPage from './views/tweets/user.vue'
import RecordsIndexPage from './views/records/index.vue'
import GamesIndexPage from './views/games/index.vue'
import GamesPlayPage from './views/games/play.vue'
import GamesRecordPage from './views/games/record.vue'

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
      meta: {
        requiresAuth: true,
      },
    },
    {
      path: '/tweets/user/:id(\\d+)',
      name: 'TweetsUserPage',
      component: TweetsUserPage,
    },
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
    {
      path: '/users/edit',
      name: 'UsersEditPage',
      component: UsersEditPage,
      meta: {
        requiresAuth: true,
      },
    },
    {
      path: '/records',
      name: 'RecordsIndexPage',
      component: RecordsIndexPage,
    },
    {
      path: '/games',
      name: 'GamesIndexPage',
      component: GamesIndexPage,
    },
    {
      path: '/games/play',
      name: 'GamesPlayPage',
      component: GamesPlayPage,
    },
    {
      path: '/games/record',
      name: 'GamesRecordPage',
      component: GamesRecordPage,
      props: true,
    },
    {
      path: '*',
      name: 'NotFound',
      component: NotFound,
      meta: { title: 'お探しのページは見つかりませんでした' },
    },
  ],
})

router.beforeEach((to, from, next) => {
  if (to.matched.some((record) => record.meta.requiresAuth)) {
    if (!store.state.auth.logged_in) {
      next({
        path: '/login',
        query: {
          redirect: to.fullPath,
        },
      })
    } else {
      next()
    }
  } else {
    next()
  }
})

export default router
