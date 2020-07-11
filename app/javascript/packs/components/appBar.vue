<template>
  <div>
    <v-app-bar app hide-on-scroll color="amber darken-2" dark>
      <v-app-bar-nav-icon v-if="auth.logged_in" @click="drawer = true">
        <UserImage
          :size="30"
          :user="auth.current_user"
          :is_link="false"
        ></UserImage>
      </v-app-bar-nav-icon>
      <router-link v-else v-bind:to="{ name: 'UsersNewPage' }">
        <v-icon>mdi-account-plus</v-icon>
      </router-link>
      <v-toolbar-title @click="scrollTop">Let</v-toolbar-title>
      <v-icon v-if="auth.logged_in" @click="logout">mdi-logout</v-icon>
      <router-link v-else v-bind:to="{ name: 'UsersLoginPage' }">
        <v-icon>mdi-login</v-icon>
      </router-link>
    </v-app-bar>

    <v-navigation-drawer v-model="drawer" absolute temporary>
      <v-list nav dense>
        <v-list-item @click="linkTo(`/`)">
          <v-list-item-icon>
            <v-icon>mdi-home</v-icon>
          </v-list-item-icon>
          <v-list-item-title>Home</v-list-item-title>
        </v-list-item>

        <v-list-item @click="linkTo(`/users/${auth.current_user.id}`)">
          <v-list-item-icon>
            <v-icon>mdi-account</v-icon>
          </v-list-item-icon>
          <v-list-item-title>My Account</v-list-item-title>
        </v-list-item>

        <v-list-item @click="linkTo(`/users/edit`)">
          <v-list-item-icon>
            <v-icon>mdi-account-cog</v-icon>
          </v-list-item-icon>
          <v-list-item-title>ユーザー情報の変更</v-list-item-title>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
  </div>
</template>

<script>
import axios from 'axios'
import router from '../router.js'

import UserImage from './userImage.vue'

export default {
  data: () => ({
    drawer: false,
  }),
  computed: {
    auth() {
      return this.$store.state.auth
    },
  },
  methods: {
    scrollTop: () => {
      window.scrollTo({
        top: 0,
        behavior: 'smooth',
      })
    },
    logout: function () {
      axios.delete('/api/v1/logout').then(() => {
        this.$store.dispatch('resetAuth')
        router.push({ name: 'TweetsIndexPage' })
      })
    },
    linkTo: (path) => {
      router.push({ path: path })
    },
  },
  components: {
    UserImage,
  },
}
</script>

<style scoped>
a {
  text-decoration: none;
}
::v-deep .v-toolbar__content {
  justify-content: space-between !important;
}
::v-deep .v-toolbar__title {
  padding-left: 0 !important;
}
::v-deep .v-list-item__avatar {
  margin-right: 0 !important;
}
</style>
