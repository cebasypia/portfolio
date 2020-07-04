<template>
  <div>
    <v-app-bar app hide-on-scroll color="amber darken-2" dark>
      <v-app-bar-nav-icon v-if="current_user" @click="drawer = true">
        <v-icon>mdi-account</v-icon>
      </v-app-bar-nav-icon>
      <router-link v-else v-bind:to="{ name: 'UsersNewPage' }">
        <v-icon>mdi-account-plus</v-icon>
      </router-link>

      <v-spacer></v-spacer>

      <v-toolbar-title @click="scrollTop">Let</v-toolbar-title>

      <v-spacer></v-spacer>

      <v-icon v-if="current_user" @click="logout">mdi-logout</v-icon>
      <router-link v-bind:to="{ name: 'UsersLoginPage' }">
        <v-icon v-if="!current_user">mdi-login</v-icon>
      </router-link>
    </v-app-bar>

    <v-navigation-drawer v-model="drawer" absolute temporary>
      <v-list nav dense>
        <v-list-item>
          <v-list-item-icon>
            <v-icon>mdi-home</v-icon>
          </v-list-item-icon>
          <v-list-item-title>Home</v-list-item-title>
        </v-list-item>

        <v-list-item>
          <v-list-item-icon>
            <v-icon>mdi-account</v-icon>
          </v-list-item-icon>
          <v-list-item-title>Account</v-list-item-title>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
  </div>
</template>

<script>
import axios from 'axios'
import router from '../router.js'

export default {
  data: () => ({
    drawer: false,
  }),
  props: ['current_user'],
  methods: {
    scrollTop: () => {
      window.scrollTo({
        top: 0,
        behavior: 'smooth',
      })
    },
    logout: () => {
      axios.delete('/api/v1/logout').then(() => {
        router.push({ name: 'TweetsIndexPage' })
      })
    },
  },
}
</script>

<style scoped>
a {
  text-decoration: none;
}
</style>
