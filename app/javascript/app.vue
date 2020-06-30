<template>
  <div>
    <router-view></router-view>
  </div>
</template>

<script>
import Vue from 'vue'
import VueRouter from 'vue-router'

import UsersIndexPage from './packs/views/users/index.vue'
import UsersShowPage from './packs/views/users/show.vue'
import UsersNewPage from './packs/views/users/new.vue'
import TweetsIndexPage from './packs/views/tweets/index.vue'
import TweetsSearchPage from './packs/views/tweets/search.vue'

const router = new VueRouter({
  routes: [
    { path: '/', component: UsersIndexPage},
    { path: '/users/:id(\\d+)', name: 'UsersShowPage', component: UsersShowPage},
    { path: '/users/new', name: 'UsersNewPage', component: UsersNewPage},
    { path: '/tweets/index', name: 'TweetsIndexPage', component: TweetsIndexPage},
    { path: '/tweets/search', name: 'TweetsSearchPage', component: TweetsSearchPage},
  ]
})

Vue.use(VueRouter)

export default {
  router
}
</script>

<style scoped>
</style>